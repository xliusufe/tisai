#' Download A-share panel data from Yahoo Finance
#'
#' This function downloads adjusted daily closing prices for selected
#' A-share stocks from Yahoo Finance and constructs a long-format panel
#' data set with daily log returns.
#'
#' If `tickers` is not provided, the built-in object `Ashare_tickers`
#' will be used.
#'
#' @param tickers A character vector of Yahoo Finance ticker symbols,
#'   such as `c("600000.SS", "600036.SS", "000001.SZ")`.
#'   If `NULL`, `Ashare_tickers$ticker` is used.
#' @param from Start date in `"YYYY-MM-DD"` format.
#'   Default is `"2018-01-01"`.
#' @param to End date in `"YYYY-MM-DD"` format.
#'   Default is `"2025-12-31"`.
#' @param save_path Optional file path for saving the resulting object
#'   as an `.rda` file. Default is `NULL`.
#'
#' @return A long-format data frame with the following columns:
#' \describe{
#'   \item{date}{Trading date.}
#'   \item{ticker}{Yahoo Finance ticker symbol.}
#'   \item{name}{Company name, if available from `Ashare_tickers`.}
#'   \item{market}{Exchange code (`"SSE"` or `"SZSE"`), if available.}
#'   \item{close_adj}{Adjusted closing price.}
#'   \item{ret}{Daily log return.}
#' }
#'
#' @details
#' The function downloads stock price data from Yahoo Finance using
#' `quantmod::getSymbols()`. Missing values are removed within each stock
#' series before computing daily log returns. The final output is a
#' stacked panel data set in long format.
#'
#' This function is designed for teaching and research in panel data,
#' financial econometrics, and time series analysis. Since data are
#' downloaded at runtime, the package does not redistribute the original
#' stock price series.
#'
#' @examples
#' \dontrun{
#' library(tisai)
#'
#' data(Ashare_tickers)
#'
#' ashare_panel <- get_Ashare_data(
#'   tickers = Ashare_tickers$ticker,
#'   from = "2020-01-01",
#'   to = "2024-12-31"
#' )
#'
#' head(ashare_panel)
#' }
#'
#' @export
get_Ashare_data <- function(tickers = NULL,
                            from = "2018-01-01",
                            to = "2025-12-31",
                            save_path = NULL,
                            ticker_info = NULL) {
  if (!requireNamespace("quantmod", quietly = TRUE)) {
    stop("Package 'quantmod' is required. Please install it first.")
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it first.")
  }
  if (!requireNamespace("zoo", quietly = TRUE)) {
    stop("Package 'zoo' is required. Please install it first.")
  }
  
  if (is.null(ticker_info)) {
    if (exists("Ashare", inherits = TRUE)) {
      ticker_info <- get("Ashare", inherits = TRUE)
    } else {
      if ("tisai" %in% loadedNamespaces() &&
          exists("Ashare", envir = asNamespace("tisai"), inherits = FALSE)) {
        ticker_info <- get("Ashare", envir = asNamespace("tisai"))
      } else {
        ticker_info <- NULL
      }
    }
  }
    if (is.null(tickers)) {
    if (!is.null(ticker_info) && "ticker" %in% names(ticker_info)) {
      tickers <- ticker_info$ticker
    } else {
      stop("Please provide 'tickers', or make sure 'Ashare' / 'ticker_info' is available.")
    }
  }
  
  tickers <- unique(as.character(tickers))
  
  panel_list <- lapply(tickers, function(sym) {
    message("Downloading: ", sym)
    
    xt <- tryCatch(
      quantmod::getSymbols(
        Symbols = sym,
        src = "yahoo",
        from = from,
        to = to,
        auto.assign = FALSE
      ),
      error = function(e) {
        message("Failed to download: ", sym)
        return(NULL)
      }
    )
    
    if (is.null(xt)) return(NULL)
    
    df <- data.frame(
      date = zoo::index(xt),
      ticker = sym,
      close_adj = as.numeric(quantmod::Ad(xt)),
      stringsAsFactors = FALSE
    )
    
    df <- df[!is.na(df$close_adj), , drop = FALSE]
    
    if (nrow(df) == 0) return(NULL)
    
    df$ret <- c(NA_real_, diff(log(df$close_adj)))
    df
  })
  
  panel_list <- Filter(Negate(is.null), panel_list)
  
  if (length(panel_list) == 0) {
    stop("No valid stock series were downloaded.")
  }
  
  panel_data <- dplyr::bind_rows(panel_list)
  
  if (!is.null(ticker_info)) {
    need_cols <- intersect(c("ticker", "name", "market"), names(ticker_info))
    ticker_info2 <- unique(ticker_info[, need_cols, drop = FALSE])
    
    panel_data <- dplyr::left_join(panel_data, ticker_info2, by = "ticker")
    
        if (!"name" %in% names(panel_data)) panel_data$name <- NA_character_
    if (!"market" %in% names(panel_data)) panel_data$market <- NA_character_
  } else {
    panel_data$name <- NA_character_
    panel_data$market <- NA_character_
  }
  
  panel_data <- panel_data[, c("date", "ticker", "name", "market", "close_adj", "ret")]
  panel_data <- panel_data[order(panel_data$ticker, panel_data$date), , drop = FALSE]
  rownames(panel_data) <- NULL
  
  if (!is.null(save_path)) {
    save(panel_data, file = save_path)
  }
  
  return(panel_data)
}
