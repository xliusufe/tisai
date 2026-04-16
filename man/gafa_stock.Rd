\name{gafa_stock}
\alias{gafa_stock}
\docType{data}
\title{Daily Prices for Four GAFA Stocks}
\description{
Daily stock prices for four GAFA stocks redistributed from the \pkg{fpp3} package, where the dataset is made available through \pkg{tsibbledata}, and reorganized for use in \pkg{tisai}.
}
\usage{data(gafa_stock)}
\format{
A data frame with 5032 observations on the following 8 variables:
\describe{
  \item{\code{symbol}}{Stock ticker symbol: \code{AAPL}, \code{AMZN}, \code{FB}, or \code{GOOG}.}
  \item{\code{date}}{Trading date from January 2, 2014 to December 31, 2018.}
  \item{\code{open}}{Opening stock price in U.S. dollars.}
  \item{\code{high}}{Highest stock price of the trading day in U.S. dollars.}
  \item{\code{low}}{Lowest stock price of the trading day in U.S. dollars.}
  \item{\code{close}}{Closing stock price in U.S. dollars.}
  \item{\code{volume}}{Number of shares traded.}
  \item{\code{adjusted}}{Adjusted closing stock price in U.S. dollars.}
}
}
\details{
In the \pkg{fpp3} ecosystem, \code{gafa_stock} is distributed as a \code{tsibble} on irregular trading days. The \pkg{tisai} version keeps the full sample and reorganizes it as a base data frame so it can be used directly in teaching examples on multi-asset prices, returns, and panel-style financial analysis.
}
\source{
Available via the \pkg{fpp3} package, with the dataset object provided by \pkg{tsibbledata}.
\url{https://cran.r-project.org/package=fpp3}
\url{https://cran.r-project.org/web/packages/fpp3/fpp3.pdf}
\url{https://cran.r-project.org/package=tsibbledata}

The original \pkg{tsibbledata} documentation states that the underlying source is Yahoo Finance historical data.
}
\examples{
data(gafa_stock)
head(gafa_stock)

subset(gafa_stock, symbol == "AAPL")[1:6, ]
}
\keyword{datasets}
