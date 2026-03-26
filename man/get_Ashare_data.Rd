\name{get_Ashare_data}
\alias{get_Ashare_data}
\title{Download A-share panel data from Yahoo Finance}
\usage{
get_Ashare_data(
  tickers = NULL,
  from = "2018-01-01",
  to = "2025-12-31",
  save_path = NULL,
  ticker_info = NULL
)
}
\arguments{
\item{tickers}{A character vector of Yahoo Finance ticker symbols, such as
\code{c("600000.SS", "600036.SS", "000001.SZ")}. If \code{NULL}, the function
will try to use the built-in ticker table.}

\item{from}{Start date in \code{"YYYY-MM-DD"} format. Default is
\code{"2018-01-01"}.}

\item{to}{End date in \code{"YYYY-MM-DD"} format. Default is
\code{"2025-12-31"}.}

\item{save_path}{Optional file path for saving the resulting object as an
\code{.rda} file. Default is \code{NULL}.}

\item{ticker_info}{Optional data frame containing ticker information. It should
include at least a column named \code{ticker}, and may also include
\code{name} and \code{market}.}
}
\value{
A long-format data frame with columns:
\describe{
\item{date}{Trading date.}
\item{ticker}{Yahoo Finance ticker symbol.}
\item{name}{Company name, if available.}
\item{market}{Exchange code (\code{"SSE"} or \code{"SZSE"}), if available.}
\item{close_adj}{Adjusted closing price.}
\item{ret}{Daily log return.}
}
}
\description{
This function downloads adjusted daily closing prices for selected A-share
stocks from Yahoo Finance and constructs a long-format panel data set with
daily log returns.
}
\details{
If \code{tickers} is not provided, the function tries to use the built-in
\code{Ashare} object (or \code{Ashare_tickers}, if available). Downloaded
series are returned in a single long-format data frame sorted by ticker and
date.
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
