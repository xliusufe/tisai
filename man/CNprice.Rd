\name{CNprice}
\alias{CNprice}
\docType{data}
\title{China Monthly Consumer Price Indices (YoY)}
\description{
Monthly consumer price indices (CPI), reported as year-over-year indices 
(same month of previous year = 100), for the national aggregate as well as 
urban and rural residents.
}
\usage{data(CNprice)}
\format{
  A data frame with monthly observations on:
  \describe{
    \item{\code{date}}{First day of the month (YYYY-MM-DD).}
    \item{\code{cpi}}{National CPI (YoY index, same month last year = 100).}
    \item{\code{cpi_city}}{Urban CPI (YoY index, same month last year = 100).}
    \item{\code{cpi_rural}}{Rural CPI (YoY index, same month last year = 100).}
  }
}
\source{
  National Bureau of Statistics of China (NBS), Monthly Data Portal: 
  \url{https://data.stats.gov.cn/}
}
\keyword{datasets}