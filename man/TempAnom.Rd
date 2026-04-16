\name{TempAnom}
\alias{TempAnom}
\docType{data}
\title{Global Surface Air Temperature Anomalies from Hansen and Lebedeff}
\description{
Annual global surface air temperature anomalies extracted from Hansen and Lebedeff (1987) and reorganized for use in \pkg{tisai}.
}
\usage{data(TempAnom)}
\format{
A data frame with 106 observations on the following 2 variables:
\describe{
  \item{\code{year}}{Year of observation from 1880 to 1985.}
  \item{\code{anomaly}}{Global surface air temperature anomaly in degrees Celsius relative to the 1951--1980 mean.}
}
}
\details{
This series corresponds to the annual global temperature anomaly values discussed in Shao (2011) and traced through Hall and Van Keilegom (2003) back to Table 1 of Hansen and Lebedeff (1987). It provides an early annual global temperature anomaly series based on station observations with a different reference period from the \code{Gtemp} dataset in \pkg{tisai}.
}
\source{
Hansen, J. and Lebedeff, S. (1987). Global trends of measured surface air temperature. \emph{Journal of Geophysical Research: Atmospheres}, 92(D11), 13345--13372.

The file in this project was prepared from the table cited through:

Hall, P. and Van Keilegom, I. (2003). Using difference-based methods for inference in nonparametric regression with time series errors. \emph{Journal of the Royal Statistical Society: Series B}, 65(2), 443--456.

Shao, X. (2011). A simple test of changes in mean in the possible presence of long-range dependence. \emph{Journal of Time Series Analysis}, 32(6), 598--606.
}
\examples{
data(TempAnom)
head(TempAnom)

plot(TempAnom$year, TempAnom$anomaly, type = "l",
     xlab = "Year", ylab = "Temperature anomaly",
     main = "Hansen-Lebedeff Global Temperature Anomalies")
}
\keyword{datasets}
