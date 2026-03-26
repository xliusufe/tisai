\name{GoldUSD}
\alias{GoldUSD}
\docType{data}
\title{Daily Gold Price Series in U.S. Dollars}
\description{
Daily open, high, low, close, and trading volume data for the Gold/USD market from 2016 to 2026.
}
\usage{data(GoldUSD)}
\format{
A data frame with 2554 observations on the following 6 variables:
\describe{
  \item{\code{date}}{Trading date from January 4, 2016 to March 3, 2026.}
  \item{\code{open}}{Opening price in U.S. dollars.}
  \item{\code{high}}{Highest price of the day in U.S. dollars.}
  \item{\code{low}}{Lowest price of the day in U.S. dollars.}
  \item{\code{close}}{Closing price in U.S. dollars.}
  \item{\code{volume}}{Trading volume.}
}
}
\details{
The raw file \code{GoldUSD.csv} contains 6399 daily observations from August 30, 2000 to March 3, 2026. Following the user-approved trimming rule for this project, the package version keeps the observations from 2016 onward, which yields 2554 trading-day records. The sample starts on January 4, 2016 because that is the first trading day on or after January 1, 2016.
}
\source{
Krupal Patel, \dQuote{Gold Price Dynamics}, Kaggle.
\url{https://www.kaggle.com/datasets/krupalpatel07/gold-price-dynamics}
}
\examples{
data(GoldUSD)
head(GoldUSD)

plot(close ~ date, data = GoldUSD, type = "l",
     xlab = "Date", ylab = "USD",
     main = "Gold/USD Closing Price")
}
\keyword{datasets}
