\name{employ}
\alias{employ}
\docType{data}
\title{Annual Global Employment and Unemployment Rates}
\description{
Annual country-level employment and unemployment rates for the total population aged 15 and above from 2016 to 2025.
}
\usage{data(employ)}
\format{
A data frame with 1816 observations on the following 5 variables:
\describe{
  \item{\code{iso_code}}{Three-letter country or territory code used by the source database.}
  \item{\code{country}}{Country or territory name.}
  \item{\code{year}}{Calendar year from 2016 to 2025.}
  \item{\code{employ}}{Employment rate, measured as the percentage of employed persons in the working-age population.}
  \item{\code{unemp}}{Unemployment rate, measured as the percentage of unemployed persons in the labour force.}
}
}
\details{
This dataset is drawn from a Kaggle collection based on ILOSTAT modelled estimates published by the International Labour Organization. The package version is organized as a country-year panel that combines employment and unemployment rates using exact matches on \code{iso_code}, \code{country}, \code{sex}, \code{age}, and \code{year}. It keeps the total population aged 15 and above from 2016 to 2025, yielding 1816 observations for 183 countries and territories.

The employment and unemployment rates in this dataset should not be interpreted as complements that add up to 100, because they use different denominators in the source definitions.
}
\source{
Luca Lullo, \dQuote{Global Employment and Unemployment Rates 1991--2025}, Kaggle.
\url{https://www.kaggle.com/datasets/lucalullo/global-employment-unemployment-rates-1991-2025}

Underlying data source: International Labour Organization (ILO), ILOSTAT database.
\url{https://ilostat.ilo.org/}
}
\examples{
data(employ)
head(employ)

china <- subset(employ, country == "China")
plot(china$year, china$employ, type = "b",
     ylim = range(c(china$employ, china$unemp)),
     xlab = "Year", ylab = "Percent",
     main = "Employment and Unemployment Rates in China")
lines(china$year, china$unemp, type = "b", col = "red")
legend("topright", legend = c("Employment", "Unemployment"),
       col = c("black", "red"), lty = 1, pch = 1, bty = "n")
}
\keyword{datasets}
