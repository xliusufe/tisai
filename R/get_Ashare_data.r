#' Download A-share panel data from AKShare
#'
#' This function downloads daily closing prices for selected A-share stocks
#' through AKShare and constructs a long-format panel data set with daily log
#' returns.
#'
#' If `tickers` is not provided, the built-in object `Ashare`
#' (or `Ashare_tickers`) will be used if available.
#'
#' @param tickers A character vector of A-share ticker symbols, such as
#'   `c("600000.SS", "600036.SS", "000001.SZ")`. Common suffixes
#'   (`.SS`, `.SZ`), exchange prefixes (`sh`, `sz`), and plain six-digit
#'   stock codes are supported. If `NULL`, the function will try to use the
#'   built-in ticker table.
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
#' @param adjust Price adjustment method passed to AKShare. The default
#'   `"qfq"` returns forward-adjusted prices. Use `""` for unadjusted prices
#'   or `"hfq"` for backward-adjusted prices.
#'
#' @section Dependencies:
#' This function requires the R package `reticulate` and the Python package
#' `akshare`. If AKShare is not available in the active Python environment,
#' install it with `reticulate::py_install("akshare")` or `pip install akshare -U`.
#'
#' @section Disclaimer:
#' This function is for educational and research purposes only. The data are
#' retrieved from public financial data sources through AKShare. This package
#' and its authors have no affiliation with AKShare, Sina Finance, Tencent, or
#' any other data provider. Users should refer to the terms of service of the
#' corresponding data sources.
#' 
#' @return A long-format data frame with columns:
#' \describe{
#'   \item{date}{Trading date.}
#'   \item{ticker}{Ticker symbol supplied by the user or the built-in ticker table.}
#'   \item{name}{Company name, if available.}
#'   \item{market}{Exchange code (`"SSE"` or `"SZSE"`), if available.}
#'   \item{close_adj}{Closing price using the selected AKShare adjustment method.}
#'   \item{ret}{Daily log return.}
#' }
#'
#' @examples
#' \dontrun{
#' data(Ashare)
#'
#' panel <- get_Ashare_data(
#'   tickers = Ashare$ticker[1:5],
#'   from = "2020-01-01",
#'   to = "2024-12-31"
#' )
#'
#' head(panel)
#' }
#'
#' @export
get_Ashare_data <- function(tickers = NULL,
                            from = "2018-01-01",
                            to = "2025-12-31",
                            save_path = NULL,
                            ticker_info = NULL,
                            adjust = "qfq") {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("Package 'reticulate' is required. Please install it first.")
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it first.")
  }

  if (!is.character(adjust) || length(adjust) != 1L ||
      !adjust %in% c("", "qfq", "hfq")) {
    stop("'adjust' must be one of '', 'qfq', or 'hfq'.")
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
  end_date <- gsub("-", "", to)
  from_date <- as.Date(from)
  to_date <- as.Date(to)

  if (is.na(from_date) || is.na(to_date)) {
    stop("'from' and 'to' must be valid dates in 'YYYY-MM-DD' format.")
  }
  if (from_date > to_date) {
    stop("'from' must be earlier than or equal to 'to'.")
  }

  date_col <- "\u65e5\u671f"
  close_col <- "\u6536\u76d8"

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

  normalize_a_symbol <- function(sym) {
    sym <- trimws(as.character(sym))
    sym_lower <- tolower(sym)

    if (grepl("^(sh|sz)[0-9]{6}$", sym_lower)) {
      return(sym_lower)
    }

    code <- sub("\\.(ss|sh|sz)$", "", sym_lower)
    code <- gsub("[^0-9]", "", code)

    if (!grepl("^[0-9]{6}$", code)) {
      stop("Unsupported A-share ticker format: ", sym)
    }

    suffix <- sub("^[0-9]{6}", "", sym_lower)

    if (suffix %in% c(".ss", ".sh")) {
      paste0("sh", code)
    } else if (suffix == ".sz") {
      paste0("sz", code)
    } else if (substr(code, 1, 1) %in% c("5", "6", "9")) {
      paste0("sh", code)
    } else {
      paste0("sz", code)
    }
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
    ak_symbol <- normalize_a_symbol(sym)
    message("Downloading from AKShare: ", sym, " (", ak_symbol, ")")

    df <- tryCatch(
      ak$stock_zh_a_daily(
        symbol = ak_symbol,
        start_date = start_date,
        end_date = end_date,
        adjust = adjust
      ),
      error = function(e) {
        message("Failed to download from Sina interface: ", sym, " (",
                conditionMessage(e), ")")
        return(NULL)
      }
    )

    if (is.null(df)) {
      df <- tryCatch(
        ak$stock_zh_a_hist_tx(
          symbol = ak_symbol,
          start_date = start_date,
          end_date = end_date,
          adjust = adjust
        ),
        error = function(e) {
          message("Failed to download from Tencent interface: ", sym, " (",
                  conditionMessage(e), ")")
          return(NULL)
        }
      )
    }

    if (is.null(df)) return(NULL)

    df <- as.data.frame(df)

    if ("date" %in% names(df)) {
      date_raw <- df$date
    } else if (date_col %in% names(df)) {
      date_raw <- df[[date_col]]
    } else {
      stop("Unexpected AKShare output format for ticker: ", sym)
    }

    if ("close" %in% names(df)) {
      close_raw <- df$close
    } else if (close_col %in% names(df)) {
      close_raw <- df[[close_col]]
    } else {
      stop("Unexpected AKShare output format for ticker: ", sym)
    }

    df <- data.frame(
      date = as_ak_date(date_raw),
      ticker = sym,
      close_adj = as_ak_numeric(close_raw),
      stringsAsFactors = FALSE
    )

    df <- df[!is.na(df$date) & df$date >= from_date & df$date <= to_date, ,
             drop = FALSE]
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
