\name{HKflu}
\alias{HKflu}
\docType{data}
\title{Weekly Influenza Surveillance and Environmental Data in Hong Kong}
\description{
  This dataset contains weekly records of influenza incidence rates along with 
  various air quality and meteorological indicators in Hong Kong from 
  December 30, 2012, to December 22, 2019.
}
\usage{data(HKflu)}
\format{
  A data frame with 365 observations on the following 11 variables:
  \describe{
    \item{\code{week}}{A numeric vector indicating the sequence of monitored weeks.}
    \item{\code{influenza}}{Influenza intensity, measured as the number of laboratory-confirmed influenza cases per 1,000 recorded consultations.}
    \item{\code{FSP}}{Fine Suspended Particulates (PM2.5) daily average concentration.}
    \item{\code{RSP}}{Respirable Suspended Particulates (PM10) daily average concentration.}
    \item{\code{NO2}}{Nitrogen Dioxide ($NO_2$) daily average concentration.}
    \item{\code{CO}}{Carbon Monoxide (CO) daily average concentration.}
    \item{\code{SO2}}{Sulphur Dioxide ($SO_2$) daily average concentration.}
    \item{\code{NOX}}{Nitrogen Oxides ($NO_x$) daily average concentration.}
    \item{\code{O3}}{Ozone ($O_3$) daily average concentration.}
    \item{\code{temperature}}{Weekly average temperature in degrees Celsius.}
    \item{\code{humidity}}{Weekly average relative humidity percentage.}
  }
}
\source{
  Hong Kong Environmental Protection Department and relevant health authorities.
}
\references{
  Li, J., Wang, S., & You, J. (2022). Nonparametric additive models for discrete-time series with periodic features. Acta Mathematica Sinica, Chinese Series, 65(1), 177-204.
}
\examples{
data(HKflu)
summary(HKflu)
plot(HKflu$temperature, HKflu$influenza)
}
\keyword{datasets}