\name{T_econ}
\alias{T_econ}
\docType{data}
\title{Regional Climate and Economic Panel Data from Kotz, Levermann, and Wenz}
\description{
Regional panel data on climate and economic production derived from the replication package for Kotz, Levermann, and Wenz on rainfall changes and economic production, reorganized for use in \pkg{tisai}.
}
\usage{data(T_econ)}
\format{
A data frame with 14577 observations on the following 17 variables:
\describe{
  \item{\code{country}}{Country name.}
  \item{\code{iso}}{Three-letter country code.}
  \item{\code{year}}{Calendar year from 2001 to 2012.}
  \item{\code{region_id}}{Subnational spatial unit identifier from the source package.}
  \item{\code{lgdppc}}{Log GDP per capita in U.S. dollars.}
  \item{\code{dlgdppc}}{Annual change in log GDP per capita.}
  \item{\code{agdppc}}{Agricultural GDP per capita in U.S. dollars.}
  \item{\code{mangdppc}}{Manufacturing GDP per capita in U.S. dollars.}
  \item{\code{servgdppc}}{Services GDP per capita in U.S. dollars.}
  \item{\code{p5_totalpr}}{Source-package precipitation indicator.}
  \item{\code{t5_mean}}{Source-package temperature mean indicator.}
  \item{\code{t5_varc}}{Source-package temperature variability indicator.}
  \item{\code{t5_varm}}{Source-package temperature variability indicator.}
  \item{\code{t5_seas_diff}}{Source-package temperature seasonality indicator.}
  \item{\code{rich}}{High-income country dummy from the source package.}
  \item{\code{lon}}{Longitude of the spatial unit centroid.}
  \item{\code{lat}}{Latitude of the spatial unit centroid.}
}
}
\details{
The original \code{T_econ.dta} file contains a larger subnational panel with many climate-derived features. For the \pkg{tisai} release, the data are organized as a continuous-year subset covering 2001--2012, which retains 14577 observations from 75 countries and 1446 spatial units while preserving the subnational structure.

To stay close to the original replication package, several climate variables retain condensed source notation such as \code{p5_totalpr} and \code{t5_mean}.
}
\source{
Kotz, M., Levermann, A. and Wenz, L. (2022). The effect of rainfall changes on economic production. \emph{Nature}, 601, 223--227. \doi{10.1038/s41586-021-04283-8}

Replication package:
\url{https://doi.org/10.5281/zenodo.5657457}

The Zenodo record notes that the economic data are derived from the DoSE database and the climate data are derived from the ERA5 reanalysis.
}
\examples{
data(T_econ)
head(T_econ)

subset(T_econ, iso == "CHN")[1:6, ]
}
\keyword{datasets}
