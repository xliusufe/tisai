\name{FANG}
\alias{FANG}
\docType{data}
\title{Daily Prices for Four FANG Stocks}
\description{
Daily stock prices for four FANG stocks redistributed from the \pkg{timetk} package and reorganized for use in \pkg{tisai}.
}
\usage{data(FANG)}
\format{
A data frame with 4032 observations on the following 8 variables:
\describe{
  \item{\code{symbol}}{Stock ticker symbol: \code{AMZN}, \code{FB}, \code{GOOG}, or \code{NFLX}.}
  \item{\code{date}}{Trading date from January 2, 2013 to December 30, 2016.}
  \item{\code{open}}{Opening stock price in U.S. dollars.}
  \item{\code{high}}{Highest stock price of the trading day in U.S. dollars.}
  \item{\code{low}}{Lowest stock price of the trading day in U.S. dollars.}
  \item{\code{close}}{Closing stock price in U.S. dollars.}
  \item{\code{volume}}{Number of shares traded.}
  \item{\code{adjusted}}{Adjusted closing stock price in U.S. dollars.}
}
}
\details{
The \pkg{tisai} version keeps the full sample provided by \pkg{timetk} and stores it as a base data frame that is ready for multi-asset time-series exercises, return calculations, and panel-style stock analyses.
}
\source{
Redistributed from the \pkg{timetk} package.
\url{https://cran.r-project.org/package=timetk}
\url{https://cran.r-project.org/web/packages/timetk/timetk.pdf}
}
\examples{
data(FANG)
head(FANG)

subset(FANG, symbol == "AMZN")[1:6, ]
}
\keyword{datasets}
