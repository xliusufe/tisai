\name{USeconomic}
\alias{USeconomic}
\docType{data}
\title{U.S. Quarterly National Economic Output and Expenditure Components}
\description{
  This dataset provides a structural (quarterly) snapshot of the U.S. economy 
  from 2000.1.1 to 2025.7.1, consisting of 103 observations.
  
  It integrates the major components of Gross Domestic Product (GDP):
  - Aggregate Output: Nominal and Real GDP.
  - Domestic Demand: Personal consumption (PCE) and Private investment.
  - External Sector: Real exports and imports of goods and services.
  
  The dataset allows students to explore the nonlinear dynamics of investment 
  shocks and the global trade balance using advanced AI structural models.
}
\usage{data(USeconomic)}
\format{
  A data frame with aligned quarterly observations on the following 7 variables:
  \describe{
    \item{\code{date}}{Start date of the quarter (YYYY-MM-DD).}
    \item{\code{gdp}}{Gross Domestic Product (Billions of Dollars).}
    \item{\code{real_gdp}}{Real Gross Domestic Product (Billions of Chained 2017 Dollars).}
    \item{\code{pce}}{Personal Consumption Expenditures (Billions of Dollars).}
    \item{\code{invest}}{Real Gross Private Domestic Investment (Billions of Chained 2017 Dollars).}
    \item{\code{export}}{Real Exports of Goods and Services (Billions of Chained 2017 Dollars).}
    \item{\code{import}}{Real Imports of Goods and Services (Billions of Chained 2017 Dollars).}
  }
}
\source{
  U.S. Bureau of Economic Analysis (BEA) via Federal Reserve Bank of St. Louis (FRED). 
  Data IDs: GDP, GDPC1, PCE, GPDIC1, EXPGSC1, and IMPGSC1.
  Visit: \url{https://fred.stlouisfed.org/}
}
\references{
  U.S. Bureau of Economic Analysis, "National Income and Product Accounts".
  Retrieved from FRED: \url{https://fred.stlouisfed.org/categories/106}
}
\examples{
data(USeconomic)
# Calculate Investment-to-GDP ratio
inv_ratio <- USeconomic$invest / USeconomic$real_gdp
plot(USeconomic$date, inv_ratio, type="l", ylab="Investment/GDP Ratio")
}
\keyword{datasets}