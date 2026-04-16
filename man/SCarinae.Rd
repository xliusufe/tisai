\name{SCarinae}
\alias{SCarinae}
\docType{data}
\title{Ten-Day Visual Magnitude Series for S Carinae}
\description{
Ten-day visual magnitude series for the variable star S Carinae, reorganized for use in \pkg{tisai}.
}
\usage{data(SCarinae)}
\format{
A data frame with 1189 observations on the following 2 variables:
\describe{
  \item{\code{jd}}{Julian day index from 2431110 to 2442990 in 10-day steps.}
  \item{\code{magnitude}}{Visual magnitude of S Carinae. Missing 10-day intervals are recorded as \code{NA}. Smaller values indicate a brighter star.}
}
}
\details{
The underlying observations are visual measurements of the southern variable star S Carinae. According to the project notes, the usable sample spans JD2431110 to JD2442990, corresponding to January 21, 1944 through July 30, 1976. The released \pkg{tisai} object uses the provided 10-day series and converts placeholder zeros to \code{NA}; there are 40 such missing intervals in the current sample.
}
\source{
The official observational source is AAVSO WebObs for S Carinae.
\url{https://apps.aavso.org/webobs/results/?star=000-BBR-212&num_results=200&page=158}

Project notes also reference the time-series data page maintained by Guadalupe Huerta:
\url{https://math.unm.edu/~ghuerta/tseries/data.html}

The released \pkg{tisai} version is built from the local processed 10-day series file supplied in this project.
}
\examples{
data(SCarinae)
head(SCarinae)

plot(SCarinae$jd, SCarinae$magnitude, type = "l",
     xlab = "Julian day", ylab = "Magnitude",
     main = "S Carinae")
}
\keyword{datasets}
