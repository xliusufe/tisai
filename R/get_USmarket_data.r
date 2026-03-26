#' Download global financial market data from Yahoo Finance
#'
#' This function downloads daily adjusted closing prices for major global
#' financial market assets from Yahoo Finance, aligns trading dates across
#' markets, and returns a data frame.
#'
#' The default series include the S and P 500 index, Nasdaq Composite index,
#' U.S. dollar index, and gold futures price.
#'
#' @param from A character string specifying the start date in `"YYYY-MM-DD"`
#'   format. The default is `"2018-01-01"`.
#' @param to A character string specifying the end date in `"YYYY-MM-DD"`
#'   format. The default is `"2025-12-31"`.
#' @param symbols An optional named character vector of Yahoo Finance symbols.
#'   The names of this vector will be used as the output variable names. If
#'   `NULL`, a default set of symbols is used.
#' @param save_path An optional character string giving the file path to save
#'   the resulting data object as an `.rda` file. If `NULL`, the data are not
#'   saved to disk.
#'
#' @section Disclaimer:
#' This function is for **educational and research purposes only**. The data 
#' is retrieved from Yahoo Finance. This package and its authors have no 
#' affiliation with Yahoo Inc. Please refer to Yahoo's Terms of Service 
#' for data usage restrictions.
#' 
#' @return A data frame containing aligned daily adjusted closing prices for
#'   the selected market series. The first column is `date`, followed by the
#'   downloaded market variables.
#'
#' @details
#' The function retrieves market data from Yahoo Finance via
#' `quantmod::getSymbols()`. Since different markets may have different trading
#' calendars, the downloaded series are aligned by date using inner joins, so
#' that only common trading days are retained.
#'
#' The default symbols are:
#' \describe{
#'   \item{sp500}{S and P 500 Index (`^GSPC`)}
#'   \item{nasdaq}{Nasdaq Composite Index (`^IXIC`)}
#'   \item{dxy}{U.S. Dollar Index (`DX-Y.NYB`)}
#'   \item{gold}{Gold Futures (`GC=F`)}
#' }
#'
#' @examples
#' \dontrun{
#' library(tisai)
#'
#' USmarket <- get_USmarket_data()
#' head(USmarket)
#'
#' USmarket2 <- get_USmarket_data(
#'   from = "2020-01-01",
#'   to = "2024-12-31"
#' )
#'
#' USmarket3 <- get_USmarket_data(
#'   save_path = "USmarket.rda"
#' )
#' }
#'
#' @importFrom quantmod getSymbols Ad
#' @importFrom dplyr inner_join
#' @importFrom zoo index
#' @export
get_USmarket_data <- function(from = "2018-01-01",
                              to = "2025-12-31",
                              symbols = NULL,
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

  if (is.null(symbols)) {
    symbols <- c(
      sp500  = "^GSPC",
      nasdaq = "^IXIC",
      dxy    = "DX-Y.NYB",
      gold   = "GC=F"
    )
  }

  market_list <- lapply(seq_along(symbols), function(i) {
    sym <- symbols[i]
    varname <- names(symbols)[i]

    message("Downloading: ", sym)

    data_xts <- quantmod::getSymbols(
      Symbols = sym,
      from = from,
      to = to,
      src = "yahoo",
      auto.assign = FALSE
    )

    df <- data.frame(
      date = zoo::index(data_xts),
      value = as.numeric(quantmod::Ad(data_xts))
    )

    colnames(df) <- c("date", varname)
    df
  })

  market_data <- Reduce(function(x, y) dplyr::inner_join(x, y, by = "date"),
                        market_list)

  market_data <- market_data[order(market_data$date), , drop = FALSE]
  rownames(market_data) <- NULL

  if (!is.null(save_path)) {
    save(market_data, file = save_path)
  }

  return(market_data)
}
