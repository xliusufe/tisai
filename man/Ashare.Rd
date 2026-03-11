\name{Ashare}
\alias{Ashare}
\docType{data}
\title{Selected Chinese A-Share Stock Tickers}
\description{
A list of representative Chinese A-share listed companies used for
constructing panel stock return data from Yahoo Finance.
}
\usage{data(Ashare)}
\format{
A data frame containing stock tickers of selected A-share companies:
\describe{
  \item{\code{ticker}}{Yahoo Finance ticker symbol.}
  \item{\code{name}}{Company name.}
  \item{\code{market}}{Exchange code: SSE or SZSE.}
}
}
\source{
Yahoo Finance symbol convention for Chinese A-share listed companies:
\url{https://finance.yahoo.com/}
}

\examples{
data(Ashare)

## download panel data for selected A-share stocks
panel <- get_Ashare_data(
  tickers = Ashare$ticker[1:5],
  from = "2020-01-01",
  to = "2024-12-31"
)

head(panel)
}
\keyword{datasets}