\name{sunspots}
\alias{sunspots}
\docType{data}
\title{Monthly Sunspot Numbers}
\description{
Monthly mean relative sunspot numbers redistributed from the base R \pkg{datasets} package.
}
\usage{data(sunspots)}
\format{
A univariate time series with 2820 monthly observations from January 1749 to December 1983.
}
\details{
This is the classical monthly sunspot series used in many forecasting and spectral-analysis examples. The object is kept as a \code{ts} series in \pkg{tisai} so it can be used directly in time-series demonstrations.
}
\source{
Redistributed from the base R \pkg{datasets} package.

Andrews, D. F. and Herzberg, A. M. (1985). \emph{Data: A Collection of Problems from Many Fields for the Student and Research Worker}. Springer.

The \pkg{datasets} documentation notes that the figures were collected at the Swiss Federal Observatory, Zurich until 1960, and then at the Tokyo Astronomical Observatory.
}
\examples{
data(sunspots)
plot(sunspots, main = "Monthly Sunspot Numbers")
}
\keyword{datasets}
