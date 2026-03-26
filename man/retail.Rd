\name{retail}
\alias{retail}
\docType{data}
\title{Monthly U.S. Retail Sales, Inventories, and Selected Store Categories}
\description{
Monthly U.S. retail indicators from the U.S. Census Bureau, including aggregate retail sales, inventories, inventory-sales ratio, and selected seasonally adjusted store-category sales.
}
\usage{data(retail)}
\format{
A data frame with 332 observations on the following 13 variables:
\describe{
  \item{\code{date}}{Month of observation from February 1992 to September 2019.}
  \item{\code{salesn}}{Retail sales excluding food services, not seasonally adjusted, in millions of dollars.}
  \item{\code{sales}}{Retail sales excluding food services, seasonally adjusted, in millions of dollars.}
  \item{\code{growthn}}{Monthly percent change in retail sales, not seasonally adjusted.}
  \item{\code{growth}}{Monthly percent change in retail sales, seasonally adjusted.}
  \item{\code{total}}{Retail and food services total sales, seasonally adjusted, in millions of dollars.}
  \item{\code{invent}}{Retailers inventories, seasonally adjusted, in millions of dollars.}
  \item{\code{ratio}}{Retailers inventory-to-sales ratio, seasonally adjusted.}
  \item{\code{auto}}{Automotive parts, accessories, and tire stores sales, seasonally adjusted, in millions of dollars.}
  \item{\code{furn}}{Furniture and home furnishings stores sales, seasonally adjusted, in millions of dollars.}
  \item{\code{build}}{Building materials, garden equipment, and supplies dealers sales, seasonally adjusted, in millions of dollars.}
  \item{\code{cloth}}{Clothing and clothing accessory stores sales, seasonally adjusted, in millions of dollars.}
  \item{\code{online}}{Electronic shopping and mail-order houses sales, seasonally adjusted, in millions of dollars.}
}
}
\details{
The raw directory contains multiple monthly series downloaded from a Kaggle collection that republishes U.S. Census Bureau retail data distributed through FRED. To build a compact teaching dataset, the series are merged into a single monthly data frame covering February 1992 to September 2019. The sample starts in February 1992 because the month-over-month percent change series begin one month later than the level series.
}
\source{
U.S. Census Bureau, Monthly Retail Trade Survey, distributed by the Federal Reserve Bank of St. Louis (FRED).
\url{https://fred.stlouisfed.org/}
\url{https://www.census.gov/retail/index.html}

Raw files in this project were collected from the Kaggle dataset \dQuote{Retail and Retailers Sales Time Series Collection}.
\url{https://www.kaggle.com/datasets/census/retail-and-retailers-sales-time-series-collection}
}
\examples{
data(retail)
head(retail)

plot(retail$date, retail$sales, type = "l",
     xlab = "Date", ylab = "Millions of dollars",
     main = "U.S. Retail Sales")
}
\keyword{datasets}
