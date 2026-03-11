#' Download Chinese financial market data from Yahoo Finance
#'
#' This function downloads daily adjusted closing prices for major Chinese
#' financial market indices and related financial variables from Yahoo Finance,
#' aligns trading dates across markets, and returns a data frame.
#'
#' The default series include the Shanghai Composite Index, Shenzhen Component
#' Index, CSI 300 Index, Hang Seng Index, and the USD/CNY exchange rate.
#'
#' @param from A character string specifying the start date in `"YYYY-MM-DD"`
#'   format. The default is `"2018-01-01"`.
#' @param to A character string specifying the end date in `"YYYY-MM-DD"`
#'   format. The default is `"2025-12-31"`.
#' @param save_path An optional character string giving the file path to save
#'   the resulting data object as an `.rda` file. If `NULL`, the data are not
#'   saved to disk.
#'
#' @return A data frame containing aligned daily adjusted closing prices for
#'   the selected Chinese and related financial market series. The first column
#'   is `date`, followed by the downloaded market variables.
#'
#' @details
#' The function retrieves market data from Yahoo Finance via
#' `quantmod::getSymbols()`. Since different markets may have different trading
#' calendars, the downloaded series are aligned by date using inner joins, so
#' that only common trading days are retained.
#'
#' The default symbols are:
#' \describe{
#'   \item{shanghai}{Shanghai Composite Index (`000001.SS`)}
#'   \item{shenzhen}{Shenzhen Component Index (`399001.SZ`)}
#'   \item{hs300}{CSI 300 Index (`000300.SS`)}
#'   \item{hsi}{Hang Seng Index (`^HSI`)}
#'   \item{usd_cny}{USD/CNY exchange rate (`CNY=X`)}
#' }
#'
#' @examples
#' \dontrun{
#' library(tisai)
#'
#' CNmarket <- get_CNmarket_data()
#' head(CNmarket)
#'
#' CNmarket2 <- get_CNmarket_data(
#'   from = "2020-01-01",
#'   to = "2024-12-31"
#' )
#'
#' CNmarket3 <- get_CNmarket_data(
#'   save_path = "CNmarket.rda"
#' )
#' }
#'
#' @importFrom quantmod getSymbols Ad
#' @importFrom dplyr inner_join
#' @importFrom zoo index
#' @export
get_CNmarket_data <- function(from = "2018-01-01",
                              to = "2025-12-31",
                              save_path = NULL) {
  if (!requireNamespace("quantmod", quietly = TRUE)) {
    stop("Package 'quantmod' is required. Please install it first.")
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it first.")
  }
  if (!requireNamespace("zoo", quietly = TRUE)) {
    stop("Package 'zoo' is required. Please install it first.")
  }

  symbols <- c(
    shanghai = "000001.SS",
    shenzhen = "399001.SZ",
    hs300    = "000300.SS",
    hsi      = "^HSI",
    usd_cny  = "CNY=X"
  )

  data_list <- lapply(seq_along(symbols), function(i) {
    sym <- symbols[i]
    varname <- names(symbols)[i]

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
      value = as.numeric(quantmod::Ad(xt))
    )

    colnames(df) <- c("date", varname)
    df
  })

  data_list <- Filter(Negate(is.null), data_list)

  if (length(data_list) < 2) {
    stop("Too few valid series were downloaded.")
  }

  china_data <- Reduce(function(x, y) dplyr::inner_join(x, y, by = "date"),
                       data_list)

  china_data <- china_data[order(china_data$date), , drop = FALSE]
  rownames(china_data) <- NULL

  if (!is.null(save_path)) {
    save(china_data, file = save_path)
  }

  return(china_data)
}