\name{poverty}
\alias{poverty}
\docType{data}
\title{Global Poverty, Inequality, and GDP Panel Data}
\description{
Country-year panel data on population, GDP, poverty, and income distribution indicators from 2005 to 2024.
}
\usage{data(poverty)}
\format{
A data frame with 3980 observations on the following 11 variables:
\describe{
  \item{\code{country}}{Country or territory name.}
  \item{\code{iso_code}}{Three-letter country or territory code.}
  \item{\code{year}}{Calendar year from 2005 to 2024.}
  \item{\code{pop}}{Population.}
  \item{\code{gdp}}{Gross domestic product.}
  \item{\code{gdppc}}{GDP per capita.}
  \item{\code{poverty}}{Poverty rate.}
  \item{\code{gini}}{Gini index.}
  \item{\code{top1}}{Income share of the top 1 percent.}
  \item{\code{top10}}{Income share of the top 10 percent.}
  \item{\code{bottom50}}{Income share of the bottom 50 percent.}
}
}
\details{
This dataset is drawn from the Kaggle collection \dQuote{Global Economic Inequality and Poverty 1980--2024}. Following the user-approved trimming rule for this project, the package version keeps the latest full years that fit within the 4000-row limit, which currently yields a country-year panel from 2005 to 2024 with 3980 observations for 199 countries and territories.

Missing values from the source are preserved rather than imputed. In the current package version, \code{gdp} and \code{gdppc} each contain 1028 missing values, \code{poverty} and \code{gini} each contain 2507 missing values, and \code{top1}, \code{top10}, and \code{bottom50} each contain 300 missing values.
}
\source{
Luca Lullo, \dQuote{Global Economic Inequality and Poverty 1980--2024}, Kaggle.
\url{https://www.kaggle.com/datasets/lucalullo/global-economic-inequality-and-poverty-1980-2024}

The dataset description reports underlying data sources including Our World in Data and the World Inequality Database (WID), with poverty and inequality indicators mainly based on World Bank household survey data.
\url{https://ourworldindata.org/}
\url{https://wid.world/}
}
\examples{
data(poverty)
head(poverty)

plot(gdppc ~ year, data = subset(poverty, country == "China"),
     type = "b", xlab = "Year", ylab = "GDP per capita",
     main = "China GDP per Capita")
}
\keyword{datasets}
