\name{Gtemp}
\alias{Gtemp}
\docType{data}
\title{Global Annual Temperature Anomalies (1850--2017)}
\description{
  This dataset provides the global annual mean temperature anomalies relative 
  to the 1961--1990 average, sourced from the HadCRUT4 dataset.
}
\usage{data(Gtemp)}
\format{
  A data frame with 168 observations on the following 2 variables:
  \describe{
    \item{\code{year}}{The year of observation (from 1850 to 2017).}
    \item{\code{anomaly}}{Global temperature anomaly (degrees Celsius) relative to the 1961--1990 mean.}
  }
}
\details{
  The dataset reflects the long-term warming trend and potential 60-70 year 
  periodic oscillations in global temperatures.
}
\source{
  Climatic Research Unit (CRU), University of East Anglia (HadCRUT4).
  \url{https://crudata.uea.ac.uk/cru/data/temperature/}
}
\references{
  Wang, S., You, J., & Huang, T. (2022). Modelling and applications for 
  non-stationary time series in the presence of trend and period. 
  Scientia Sinica Mathematica, 52(2), 177-208.
}
\examples{
data(Gtemp)
plot(Gtemp$year, Gtemp$anomaly, type = "l", main = "Global Temperature Anomalies")
}
\keyword{datasets}