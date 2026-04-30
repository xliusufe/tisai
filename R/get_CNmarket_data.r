#' Download Chinese financial market data from AKShare
#'
#' This function downloads daily prices for major Chinese and related
#' financial market series using AKShare, aligns trading dates across
#' markets, and returns a data frame.
#'
#' @param from A character string specifying the start date in `"YYYY-MM-DD"`
#'   format. The default is `"2018-01-01"`.
#' @param to A character string specifying the end date in `"YYYY-MM-DD"`
#'   format. The default is `"2025-12-31"`.
#' @param save_path An optional character string giving the file path to save
#'   the resulting data object as an `.rda` file. If `NULL`, the data are not
#'   saved to disk.
#'
#' @section Dependencies:
#' This function requires the R package `reticulate` and the Python package
#' `akshare`. If AKShare is not available in the active Python environment,
#' install it with `reticulate::py_install("akshare")` or `pip install akshare -U`.
#'
#' @section Disclaimer:
#' This function is for educational and research purposes only. The data are
#' retrieved from public financial data sources through AKShare. This package
#' and its authors have no affiliation with AKShare, Eastmoney, Sina Finance,
#' Bank of China, or any other data provider. Users should refer to the terms
#' of service of the corresponding data sources.
#'
#' @return A data frame containing aligned daily closing prices for selected
#' Chinese and related financial market series. The first column is `date`,
#' followed by `shanghai`, `shenzhen`, `hs300`, `hsi`, and `usd_cny`.
#'
#' @details
#' The default series are:
#' \describe{
#'   \item{shanghai}{Shanghai Composite Index, downloaded with AKShare symbol
#'     `sh000001`}
#'   \item{shenzhen}{Shenzhen Component Index, downloaded with AKShare symbol
#'     `sz399001`}
#'   \item{hs300}{CSI 300 Index, downloaded with AKShare symbol `sh000300`}
#'   \item{hsi}{Hang Seng Index, downloaded with AKShare symbol `HSI`}
#'   \item{usd_cny}{USD/CNY exchange rate from the Bank of China quotation
#'     interface}
#' }
#'
#' For mainland China stock indices, the function first uses the Eastmoney
#' index historical data interface through AKShare and falls back to the
#' Tencent index historical data interface if the Eastmoney request fails. For
#' the Hang Seng Index, it uses the Sina Hong Kong index historical data
#' interface. For the USD/CNY exchange rate, it uses the historical Bank of
#' China RMB quotation interface and takes the central parity rate when
#' available; otherwise it falls back to other Bank of China quotation columns
#' in the downloaded data.
#'
#' Since different markets may have different trading calendars, the downloaded
#' series are aligned by date using inner joins, so that only common trading
#' days are retained.
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
#' @importFrom dplyr inner_join
#' @export
get_CNmarket_data <- function(from = "2018-01-01",
                              to = "2025-12-31",
                              save_path = NULL) {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("Package 'reticulate' is required. Please install it first.")
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it first.")
  }

  ak <- tryCatch(
    reticulate::import("akshare"),
    error = function(e) {
      stop(
        "Python package 'akshare' is required.\n",
        "Please install it first, for example:\n",
        "  reticulate::py_install('akshare')\n",
        "or in terminal:\n",
        "  pip install akshare -U"
      )
    }
  )

  start_date <- gsub("-", "", from)
  end_date   <- gsub("-", "", to)

  from_date <- as.Date(from)
  to_date   <- as.Date(to)

  as_ak_date <- function(x) {
    if (is.list(x)) {
      x <- vapply(x, function(z) as.character(z)[1], character(1))
    }

    out <- suppressWarnings(as.Date(as.character(x)))
    retry <- is.na(out) & !is.na(x)

    if (any(retry)) {
      out[retry] <- suppressWarnings(as.Date(as.character(x[retry]),
                                             format = "%Y/%m/%d"))
    }

    out
  }

  as_ak_numeric <- function(x) {
    if (is.list(x)) {
      x <- vapply(x, function(z) as.character(z)[1], character(1))
    }

    suppressWarnings(as.numeric(x))
  }

  get_index_em <- function(symbol, varname) {
    message("Downloading index from AKShare: ", symbol)

    df <- tryCatch(
      ak$stock_zh_index_daily_em(
        symbol = symbol,
        start_date = start_date,
        end_date = end_date
      ),
      error = function(e) {
        message("Failed to download from Eastmoney: ", symbol, " (",
                conditionMessage(e), ")")
        return(NULL)
      }
    )

    if (is.null(df)) {
      message("Trying Tencent index interface from AKShare: ", symbol)

      df <- tryCatch(
        ak$stock_zh_index_daily_tx(symbol = symbol),
        error = function(e) {
          message("Failed to download from Tencent: ", symbol, " (",
                  conditionMessage(e), ")")
          return(NULL)
        }
      )
    }

    if (is.null(df)) return(NULL)

    df <- as.data.frame(df)

    if (!all(c("date", "close") %in% names(df))) {
      stop("Unexpected AKShare output format for symbol: ", symbol)
    }

    out <- data.frame(
      date = as_ak_date(df$date),
      value = as_ak_numeric(df$close)
    )

    out <- out[out$date >= from_date & out$date <= to_date, , drop = FALSE]
    colnames(out) <- c("date", varname)
    out
  }

  get_hsi <- function() {
    message("Downloading Hang Seng Index from AKShare: HSI")

    df <- tryCatch(
      ak$stock_hk_index_daily_sina(symbol = "HSI"),
      error = function(e) {
        message("Failed to download: HSI")
        return(NULL)
      }
    )

    if (is.null(df)) return(NULL)

    df <- as.data.frame(df)

    if (!all(c("date", "close") %in% names(df))) {
      stop("Unexpected AKShare output format for HSI.")
    }

    out <- data.frame(
      date = as_ak_date(df$date),
      hsi = as_ak_numeric(df$close)
    )

    out <- out[out$date >= from_date & out$date <= to_date, , drop = FALSE]
    out
  }

  get_usd_cny <- function() {
    message("Downloading USD/CNY from AKShare: Bank of China quotation")

    usd_symbol <- "\u7f8e\u5143"
    date_col <- "\u65e5\u671f"
    mid_col <- "\u592e\u884c\u4e2d\u95f4\u4ef7"
    boc_conv_col <- "\u4e2d\u884c\u6298\u7b97\u4ef7"
    boc_buy_col <- "\u4e2d\u884c\u6c47\u4e70\u4ef7"

    df <- tryCatch(
      ak$currency_boc_sina(
        symbol = usd_symbol,
        start_date = start_date,
        end_date = end_date
      ),
      error = function(e) {
        message("Failed to download: USD/CNY")
        return(NULL)
      }
    )

    if (is.null(df)) return(NULL)

    df <- as.data.frame(df)

    if (!date_col %in% names(df)) {
      stop("Unexpected AKShare output format for USD/CNY.")
    }

    value_col <- NULL

    if (mid_col %in% names(df)) {
      value_col <- mid_col
    } else if (boc_conv_col %in% names(df)) {
      value_col <- boc_conv_col
    } else if (boc_buy_col %in% names(df)) {
      value_col <- boc_buy_col
    } else {
      stop("No suitable USD/CNY price column was found.")
    }

    out <- data.frame(
      date = as_ak_date(df[[date_col]]),
      usd_cny = as_ak_numeric(df[[value_col]]) / 100
    )

    out <- out[out$date >= from_date & out$date <= to_date, , drop = FALSE]
    out
  }

  data_list <- list(
    get_index_em("sh000001", "shanghai"),
    get_index_em("sz399001", "shenzhen"),
    get_index_em("sh000300", "hs300"),
    get_hsi(),
    get_usd_cny()
  )

  data_list <- Filter(Negate(is.null), data_list)

  if (length(data_list) < 2) {
    stop("Too few valid series were downloaded.")
  }

  china_data <- Reduce(
    function(x, y) dplyr::inner_join(x, y, by = "date"),
    data_list
  )

  china_data <- china_data[order(china_data$date), , drop = FALSE]
  rownames(china_data) <- NULL

  if (!is.null(save_path)) {
    save(china_data, file = save_path)
  }

  return(china_data)
}
