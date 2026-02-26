\name{CNpower}
\alias{CNpower}
\docType{data}
\title{China Monthly Electricity Generation by Source}
\description{
Monthly electricity generation in China, including total generation and 
generation by thermal, hydro, nuclear, wind, and solar sources.
}
\usage{data(CNpower)}
\format{
  A data frame with monthly observations on:
  \describe{
    \item{\code{date}}{First day of the month (YYYY-MM-DD).}
    \item{\code{power}}{Total electricity generation (100 million kWh).}
    \item{\code{thermal}}{Thermal power generation (100 million kWh).}
    \item{\code{hydro}}{Hydropower generation (100 million kWh).}
    \item{\code{nuclear}}{Nuclear power generation (100 million kWh).}
    \item{\code{wind}}{Wind power generation (100 million kWh).}
    \item{\code{solar}}{Solar power generation (100 million kWh).}
  }
}
\source{
  National Bureau of Statistics of China (NBS), Monthly Data Portal: 
  \url{https://data.stats.gov.cn/}
}
\keyword{datasets}