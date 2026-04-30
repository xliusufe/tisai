\name{get_Ashare_data}
\alias{get_Ashare_data}
\title{Download A-share panel data from AKShare}
\usage{
get_Ashare_data(
  tickers = NULL,
  from = "2018-01-01",
  to = "2025-12-31",
  save_path = NULL,
  ticker_info = NULL,
  adjust = "qfq"
)
}
\arguments{
\item{tickers}{A character vector of A-share ticker symbols, such as
\code{c("600000.SS", "600036.SS", "000001.SZ")}. Common suffixes
(\code{.SS}, \code{.SZ}), exchange prefixes (\code{sh}, \code{sz}), and plain
six-digit stock codes are supported. If \code{NULL}, the function will try to
use the built-in ticker table.}

\item{from}{Start date in \code{"YYYY-MM-DD"} format. Default is
\code{"2018-01-01"}.}

\item{to}{End date in \code{"YYYY-MM-DD"} format. Default is
\code{"2025-12-31"}.}

\item{save_path}{Optional file path for saving the resulting object as an
\code{.rda} file. Default is \code{NULL}.}

\item{ticker_info}{Optional data frame containing ticker information. It should
include at least a column named \code{ticker}, and may also include
\code{name} and \code{market}.}

\item{adjust}{Price adjustment method passed to AKShare. The default
\code{"qfq"} returns forward-adjusted prices. Use \code{""} for unadjusted
prices or \code{"hfq"} for backward-adjusted prices.}
}
\value{
A long-format data frame with columns:
\describe{
\item{date}{Trading date.}
\item{ticker}{Ticker symbol supplied by the user or the built-in ticker table.}
\item{name}{Company name, if available.}
\item{market}{Exchange code (\code{"SSE"} or \code{"SZSE"}), if available.}
\item{close_adj}{Closing price using the selected AKShare adjustment method.}
\item{ret}{Daily log return.}
}
}
\description{
This function downloads daily closing prices for selected A-share stocks
through AKShare and constructs a long-format panel data set with daily log
returns.
}
\details{
If \code{tickers} is not provided, the function tries to use the built-in
\code{Ashare} object (or \code{Ashare_tickers}, if available). Downloaded
series are returned in a single long-format data frame sorted by ticker and
date.

The function keeps the original ticker labels in the returned data, but
internally converts common A-share code styles such as \code{600000.SS},
\code{000001.SZ}, \code{sh600000}, \code{sz000001}, and plain six-digit codes
to the format required by AKShare. It first uses AKShare's Sina A-share daily
interface and falls back to the Tencent historical interface if necessary.
}
\section{Dependencies}{

This function requires the R package \code{reticulate} and the Python package
\code{akshare}. If AKShare is not available in the active Python environment,
install it with \code{reticulate::py_install("akshare")} or \verb{pip install akshare -U}.
}

\section{Disclaimer}{

This function is for educational and research purposes only. The data are
retrieved from public financial data sources through AKShare. This package
and its authors have no affiliation with AKShare, Sina Finance, Tencent, or
any other data provider. Users should refer to the terms of service of the
corresponding data sources.
}
\examples{
\dontrun{
data(Ashare)

panel <- get_Ashare_data(
  tickers = Ashare$ticker[1:5],
  from = "2020-01-01",
  to = "2024-12-31"
)

head(panel)
}
}
