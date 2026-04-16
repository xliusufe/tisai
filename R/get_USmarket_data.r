#' Download global financial market data from FRED
#'
#' This function downloads daily financial market series from FRED, aligns dates
#' across selected series, and returns a synchronized data frame.
#'
#' By default, the function downloads:
#' \describe{
#'   \item{sp500}{S&P 500 index (`SP500`)}
#'   \item{nasdaq}{NASDAQ Composite index (`NASDAQCOM`)}
#'   \item{usd_index}{Nominal Broad U.S. Dollar Index (`DTWEXBGS`)}
#' }
#'
#' Users may also provide additional or alternative FRED series IDs through
#' the `series` argument.
#'
#' @param from A character string specifying the start date in `"YYYY-MM-DD"`
#'   format. Default is `"2018-01-01"`.
#' @param to A character string specifying the end date in `"YYYY-MM-DD"`
#'   format. Default is `Sys.Date()`.
#' @param series A named character vector of FRED series IDs. The names will be
#'   used as output variable names. If `NULL`, a default set of market series is
#'   used.
#' @param save_path An optional character string giving the file path to save
#'   the resulting object as an `.rda` file. If `NULL`, the data are not saved.
#' @param na_rm Logical. If `TRUE`, rows with any missing values are removed
#'   after alignment. Default is `TRUE`.
#'
#' @return A data frame containing aligned daily series. The first column is
#'   `date`, followed by the selected market variables.
#'
#' @details
#' The function downloads each series from FRED via the public CSV endpoint:
#' `https://fred.stlouisfed.org/graph/fredgraph.csv?id=SERIES_ID`.
#'
#' Since different series may have different release calendars or missing dates,
#' the downloaded data are merged by `date`. If `na_rm = TRUE`, only dates with
#' complete observations across all selected series are retained.
#'
#' The returned object includes the following attributes:
#' \describe{
#'   \item{source}{`"FRED"`}
#'   \item{series_map}{Named character vector of downloaded FRED series IDs}
#'   \item{download_date}{System date when the function was run}
#' }
#'
#' @section Copyright and data source note:
#' This function downloads data from FRED for educational and research use.
#' FRED aggregates series from different original providers. Users should check
#' the original source and licensing terms of each selected series before
#' redistributing the data in books, packages, or other published materials.
#'
#' @examples
#' \dontrun{
#' USmarket <- get_USmarket_data()
#' head(USmarket)
#'
#' USmarket2 <- get_USmarket_data(
#'   from = "2020-01-01",
#'   to   = "2024-12-31"
#' )
#'
#' USmarket3 <- get_USmarket_data(
#'   series = c(
#'     sp500     = "SP500",
#'     nasdaq    = "NASDAQCOM",
#'     usd_index = "DTWEXBGS",
#'     vix       = "VIXCLS"
#'   )
#' )
#'
#' USmarket4 <- get_USmarket_data(
#'   save_path = "USmarket.rda"
#' )
#' }
#'
#' @export
get_USmarket_data <- function(from = "2018-01-01",
                              to = as.character(Sys.Date()),
                              series = NULL,
                              save_path = NULL,
                              na_rm = TRUE) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it first.")
  }

  if (!is.character(from) || length(from) != 1L) {
    stop("'from' must be a single character string in 'YYYY-MM-DD' format.")
  }
  if (!is.character(to) || length(to) != 1L) {
    stop("'to' must be a single character string in 'YYYY-MM-DD' format.")
  }

  from_date <- as.Date(from)
  to_date   <- as.Date(to)

  if (is.na(from_date) || is.na(to_date)) {
    stop("'from' and 'to' must be valid dates in 'YYYY-MM-DD' format.")
  }
  if (from_date > to_date) {
    stop("'from' must be earlier than or equal to 'to'.")
  }

  if (is.null(series)) {
    series <- c(
      sp500     = "SP500",
      nasdaq    = "NASDAQCOM",
      usd_index = "DTWEXBGS"
    )
  }

  if (is.null(names(series)) || any(names(series) == "")) {
    stop("'series' must be a named character vector.")
  }
  if (!is.character(series)) {
    stop("'series' must be a named character vector of FRED series IDs.")
  }

  download_one_series <- function(series_id, varname, from_date, to_date) {
    url <- paste0(
      "https://fred.stlouisfed.org/graph/fredgraph.csv?id=",
      utils::URLencode(series_id, reserved = TRUE)
    )

    dat <- tryCatch(
      utils::read.csv(url, stringsAsFactors = FALSE),
      error = function(e) {
        stop("Failed to download series '", series_id, "' from FRED: ",
             conditionMessage(e), call. = FALSE)
      }
    )

    if (ncol(dat) < 2L) {
      stop("Downloaded data for series '", series_id, "' has unexpected format.",
           call. = FALSE)
    }

    colnames(dat)[1:2] <- c("date", varname)
    dat$date <- as.Date(dat$date)

    dat <- dat[!is.na(dat$date), , drop = FALSE]
    dat <- dat[dat$date >= from_date & dat$date <= to_date, , drop = FALSE]

    # FRED commonly uses "." for missing values in CSV exports
    dat[[varname]] <- suppressWarnings(as.numeric(dat[[varname]]))

    dat
  }

  market_list <- lapply(seq_along(series), function(i) {
    sid <- unname(series[i])
    nm  <- names(series)[i]
    message("Downloading from FRED: ", sid)
    download_one_series(series_id = sid,
                        varname = nm,
                        from_date = from_date,
                        to_date = to_date)
  })

  market_data <- Reduce(
    function(x, y) dplyr::full_join(x, y, by = "date"),
    market_list
  )

  market_data <- market_data[order(market_data$date), , drop = FALSE]

  if (isTRUE(na_rm)) {
    keep <- stats::complete.cases(market_data)
    market_data <- market_data[keep, , drop = FALSE]
  }

  rownames(market_data) <- NULL

  attr(market_data, "source") <- "FRED"
  attr(market_data, "series_map") <- series
  attr(market_data, "download_date") <- as.character(Sys.Date())

  if (!is.null(save_path)) {
    USmarket <- market_data
    save(USmarket, file = save_path)
  }

  market_data
}
