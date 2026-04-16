\name{djia}
\alias{djia}
\docType{data}
\title{Daily Dow Jones Industrial Average Prices}
\description{
Daily Dow Jones Industrial Average trading data redistributed from the \pkg{astsa} package and reorganized for use in \pkg{tisai}.
}
\usage{data(djia)}
\format{
A data frame with 2518 observations on the following 6 variables:
\describe{
  \item{\code{date}}{Trading date from April 20, 2006 to April 20, 2016.}
  \item{\code{open}}{Opening index level.}
  \item{\code{high}}{Highest index level of the trading day.}
  \item{\code{low}}{Lowest index level of the trading day.}
  \item{\code{close}}{Closing index level.}
  \item{\code{volume}}{Trading volume.}
}
}
\details{
The original \pkg{astsa} dataset stores these values as an \code{xts} object. In \pkg{tisai}, the data are reorganized as a base data frame with an explicit \code{date} column so they can be used more easily in teaching examples and package demonstrations.
}
\source{
Redistributed from the \pkg{astsa} package.
\url{https://cran.r-project.org/package=astsa}
\url{https://cran.r-project.org/web/packages/astsa/astsa.pdf}

The original \pkg{astsa} documentation notes that the market data were obtained from Yahoo Finance via R financial-data tools.
}
\examples{
data(djia)
head(djia)

plot(djia$date, djia$close, type = "l",
     xlab = "Date", ylab = "Index level",
     main = "DJIA Close")
}
\keyword{datasets}
