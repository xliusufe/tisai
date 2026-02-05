\name{USmacro}
\alias{USmacro}
\docType{data}
\title{U.S. Monthly Macroeconomic Pulse: Labor, Price, and Monetary Indicators}
\description{
This dataset provides a high-frequency (monthly) snapshot of the U.S. economy 
  from 2000.1.1 to 2025.10.1, consisting of 310 observations.
  
  The variables cover four critical dimensions:
  1. Labor Market: Unemployment rate and Nonfarm payrolls.
  2. Price Level: Consumer Price Index (CPI) for inflation tracking.
  3. Monetary Policy: Federal Funds Rate and 10-Year Treasury yields.
  4. Real Activity: Industrial production and Housing starts.
  
  This data is ideal for teaching lead-lag relationships, regime switching, 
  and high-frequency forecasting using LSTM or Transformer architectures.
}
\usage{data(USmacro)}
\format{
  A data frame with aligned monthly observations on the following 8 variables:
  \describe{
    \item{\code{date}}{First day of the month (YYYY-MM-DD).}
    \item{\code{unrate}}{Civilian Unemployment Rate (Percent).}
    \item{\code{cpi}}{Consumer Price Index for All Urban Consumers (Index 1982-1984=100).}
    \item{\code{interest}}{Federal Funds Effective Rate (Percent).}
    \item{\code{indpro}}{Industrial Production Index (Index 2017=100).}
    \item{\code{employ}}{All Employees, Total Nonfarm (Thousands of Persons).}
    \item{\code{housing}}{New Privately Owned Housing Units Started (Thousands of Units).}
    \item{\code{bond10y}}{10-Year Treasury Constant Maturity Rate (Percent).}
  }
}
\source{
  Federal Reserve Bank of St. Louis (FRED). Data accessible via the following IDs: 
  UNRATE, CPIAUCSL, FEDFUNDS, INDPRO, PAYEMS, HOUST, and GS10.
  Visit: \url{https://fred.stlouisfed.org/}
}
\references{
  Federal Reserve Bank of St. Louis, Federal Reserve Economic Data (FRED). 
  \url{https://fred.stlouisfed.org}
}
\examples{
data(USmacro)
# Visualize the relationship between interest rates and housing starts
plot(USmacro$interest, USmacro$housing, 
     main="Interest Rates vs Housing Starts")
}
\keyword{datasets}