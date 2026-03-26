\name{AAPL}
\alias{AAPL}
\docType{data}
\title{Daily Apple Stock Market Data}
\description{
Daily Apple Inc. stock prices, trading volume, cash dividends, and split events from 2010 to 2026.
}
\usage{data(AAPL)}
\format{
A data frame with 4000 observations on the following 8 variables:
\describe{
  \item{\code{date}}{Trading date from April 23, 2010 to March 18, 2026.}
  \item{\code{open}}{Opening price in U.S. dollars.}
  \item{\code{high}}{Highest price of the day in U.S. dollars.}
  \item{\code{low}}{Lowest price of the day in U.S. dollars.}
  \item{\code{close}}{Closing price in U.S. dollars.}
  \item{\code{volume}}{Trading volume.}
  \item{\code{dividend}}{Cash dividend per share on dividend dates, and 0 otherwise.}
  \item{\code{split}}{Split factor on stock split dates, and 0 otherwise.}
}
}
\details{
This dataset is drawn from the Kaggle collection \dQuote{Apple AAPL Full Stock Financial Dataset 1980--2026}. Following the user-approved trimming rule for this project, the package version keeps the latest 4000 trading-day observations, which currently span April 23, 2010 to March 18, 2026. The resulting data frame combines daily prices, trading volume, dividend records, and split events for Apple Inc. in a single object.
}
\source{
Anadi Gupta, \dQuote{Apple AAPL Full Stock Financial Dataset 1980--2026}, Kaggle.
\url{https://www.kaggle.com/datasets/anadiskt/apple-aapl-full-stock-financial-dataset-1980-2026}

The dataset description reports underlying data sources including Yahoo Finance, Nasdaq, and public financial disclosures.
}
\examples{
data(AAPL)
head(AAPL)

plot(close ~ date, data = AAPL, type = "l",
     xlab = "Date", ylab = "USD",
     main = "Apple Closing Price")
}
\keyword{datasets}
