\name{CNgdp}
\alias{CNgdp}
\docType{data}
\title{China Quarterly GDP and Sectoral Value Added}
\description{
Quarterly measures of China’s gross domestic product (GDP), including both 
current-price (nominal) and constant-price (real) series, together with 
value added of the primary, secondary, and tertiary industries.
}
\usage{data(CNgdp)}
\format{
  A data frame with quarterly observations on:
  \describe{
    \item{\code{date}}{First day of the quarter (YYYY-MM-DD).}
    \item{\code{gdp}}{GDP, current price (billion CNY).}
    \item{\code{gdp1}}{Primary industry value added, current price (billion CNY).}
    \item{\code{gdp2}}{Secondary industry value added, current price (billion CNY).}
    \item{\code{gdp3}}{Tertiary industry value added, current price (billion CNY).}
    \item{\code{rgdp}}{GDP, constant price (billion CNY).}
    \item{\code{rgdp1}}{Primary industry value added, constant price (billion CNY).}
    \item{\code{rgdp2}}{Secondary industry value added, constant price (billion CNY).}
    \item{\code{rgdp3}}{Tertiary industry value added, constant price (billion CNY).}
  }
}
\source{
  National Bureau of Statistics of China (NBS), Quarterly Data Portal: 
  \url{https://data.stats.gov.cn/}
}
\keyword{datasets}