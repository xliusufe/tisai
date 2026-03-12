#' Download A-share panel data from Yahoo Finance
#'
#' This function downloads adjusted daily closing prices for selected
#' A-share stocks from Yahoo Finance and constructs a long-format panel
#' data set with daily log returns.
#'
#' If `tickers` is not provided, the built-in object `Ashare`
#' (or `Ashare_tickers`) will be used if available.
#'
#' @param tickers A character vector of Yahoo Finance ticker symbols,
#'   such as `c("600000.SS", "600036.SS", "000001.SZ")`.
#'   If `NULL`, the function will try to use the built-in ticker table.
#' 
#' @param from Start date in `"YYYY-MM-DD"` format.
#'   Default is `"2018-01-01"`.
#' @param to End date in `"YYYY-MM-DD"` format.
#'   Default is `"2025-12-31"`.
#' @param save_path Optional file path for saving the resulting object
#'   as an `.rda` file. Default is `NULL`.
#' @param ticker_info Optional data frame containing ticker information.
#'   It should include at least a column named `ticker`, and may also
#'   include `name` and `market`.
#'
#' @section Disclaimer:
#' This function is for **educational and research purposes only**. The data 
#' is retrieved from Yahoo Finance. This package and its authors have no 
#' affiliation with Yahoo Inc. Please refer to Yahoo's Terms of Service 
#' for data usage restrictions.
#' 
#' @return A long-format data frame with columns:
#' \describe{
#'   \item{date}{Trading date.}
#'   \item{ticker}{Yahoo Finance ticker symbol.}
#'   \item{name}{Company name, if available.}
#'   \item{market}{Exchange code (`"SSE"` or `"SZSE"`), if available.}
#'   \item{close_adj}{Adjusted closing price.}
#'   \item{ret}{Daily log return.}
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

  # ---------- resolve ticker_info ----------
  if (is.null(ticker_info)) {
    # 1) current environment: Ashare
    if (exists("Ashare", inherits = TRUE)) {
      ticker_info <- get("Ashare", inherits = TRUE)

    # 2) current environment: Ashare_tickers
    } else if (exists("Ashare_tickers", inherits = TRUE)) {
      ticker_info <- get("Ashare_tickers", inherits = TRUE)

    # 3) package namespace: Ashare
    } else if ("tisai" %in% loadedNamespaces() &&
               exists("Ashare", envir = asNamespace("tisai"), inherits = FALSE)) {
      ticker_info <- get("Ashare", envir = asNamespace("tisai"))

    # 4) package namespace: Ashare_tickers
    } else if ("tisai" %in% loadedNamespaces() &&
               exists("Ashare_tickers", envir = asNamespace("tisai"), inherits = FALSE)) {
      ticker_info <- get("Ashare_tickers", envir = asNamespace("tisai"))

    } else {
      ticker_info <- NULL
    }
  }

  # ---------- resolve tickers ----------
  if (is.null(tickers)) {
    if (!is.null(ticker_info) && "ticker" %in% names(ticker_info)) {
      tickers <- ticker_info$ticker
    } else {
      stop("Please provide 'tickers', or make sure 'Ashare' / 'Ashare_tickers' / 'ticker_info' is available.")
    }
  }

  tickers <- unique(as.character(tickers))

  # ---------- download ----------
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

  # ---------- merge ticker info ----------
  if (!is.null(ticker_info) && "ticker" %in% names(ticker_info)) {
    need_cols <- intersect(c("ticker", "name", "market"), names(ticker_info))
    ticker_info2 <- unique(ticker_info[, c("ticker", setdiff(need_cols, "ticker")), drop = FALSE])

    panel_data <- dplyr::left_join(panel_data, ticker_info2, by = "ticker")
  }

  if (!"name" %in% names(panel_data)) panel_data$name <- NA_character_
  if (!"market" %in% names(panel_data)) panel_data$market <- NA_character_

  panel_data <- panel_data[, c("date", "ticker", "name", "market", "close_adj", "ret")]
  panel_data <- panel_data[order(panel_data$ticker, panel_data$date), , drop = FALSE]
  rownames(panel_data) <- NULL

  if (!is.null(save_path)) {
    save(panel_data, file = save_path)
  }

  return(panel_data)
}
