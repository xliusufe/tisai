\name{Ashare}
\alias{Ashare}
\docType{data}
\title{Selected Chinese A-Share Stock Tickers}
\description{
A list of representative Chinese A-share listed companies used for
constructing panel stock return data through AKShare.
}
\usage{data(Ashare)}
\format{
A data frame containing stock tickers of selected A-share companies:
\describe{
  \item{\code{ticker}}{A-share ticker symbol stored in the common
  \code{.SS}/\code{.SZ} style.}
  \item{\code{name}}{Company name.}
  \item{\code{market}}{Exchange code: SSE or SZSE.}
}
}
\source{
Ticker symbols use common Shanghai and Shenzhen suffixes and can be converted
by \code{get_Ashare_data()} for AKShare downloads.
}

\examples{
\dontrun{
data(Ashare)

## download panel data for selected A-share stocks
panel <- get_Ashare_data(
  tickers = Ashare$ticker[1:5],
  from = "2020-01-01",
  to = "2024-12-31"
)

head(panel)
}
}
\keyword{datasets}
