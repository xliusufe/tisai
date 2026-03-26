\name{EnergyWx}
\alias{EnergyWx}
\docType{data}
\title{Daily Spanish Energy Indicators with Weather for Five Major Cities}
\description{
Daily Spanish electricity demand, generation, and price indicators combined with city-level weather summaries for five major Spanish cities during 2017 and 2018.
}
\usage{data(EnergyWx)}
\format{
A data frame with 3650 observations on the following 19 variables:
\describe{
  \item{\code{city}}{City name: Barcelona, Bilbao, Madrid, Seville, or Valencia.}
  \item{\code{date}}{Observation date from January 1, 2017 to December 31, 2018.}
  \item{\code{load}}{Daily mean actual total electricity load in megawatts.}
  \item{\code{loadf}}{Daily mean forecast total electricity load in megawatts.}
  \item{\code{price}}{Daily mean actual electricity price in euros per megawatt-hour.}
  \item{\code{priceda}}{Daily mean day-ahead electricity price in euros per megawatt-hour.}
  \item{\code{gas}}{Daily mean electricity generation from fossil gas in megawatts.}
  \item{\code{hydro}}{Daily mean hydro reservoir generation in megawatts.}
  \item{\code{nuclear}}{Daily mean nuclear generation in megawatts.}
  \item{\code{solar}}{Daily mean solar generation in megawatts.}
  \item{\code{wind}}{Daily mean onshore wind generation in megawatts.}
  \item{\code{temp}}{Daily mean temperature in degrees Celsius.}
  \item{\code{humidity}}{Daily mean relative humidity percentage.}
  \item{\code{pressure}}{Daily mean atmospheric pressure in hectopascals.}
  \item{\code{windspeed}}{Daily mean wind speed in meters per second.}
  \item{\code{rain}}{Daily accumulated hourly rainfall in millimeters.}
  \item{\code{clouds}}{Daily mean cloud-cover percentage.}
  \item{\code{weather}}{Most frequent hourly weather category recorded on that day.}
  \item{\code{obs_hours}}{Number of distinct hourly weather observations used in the daily summary.}
}
}
\details{
The raw data contain four years of hourly Spanish electricity variables and hourly weather observations for five cities. To satisfy the project size rule while retaining all five cities, this package version keeps the user-approved period from January 1, 2017 to December 31, 2018 and aggregates the hourly data to daily frequency. City-level weather records are first deduplicated at the city-hour level before daily summaries are computed. The energy variables are national daily indicators for Spain and therefore repeat across cities on the same date, while the weather variables vary by city.
}
\source{
Nicholas J. H., \dQuote{Hourly Energy Demand Generation and Weather}, Kaggle.
\url{https://www.kaggle.com/datasets/nicholasjhana/energy-consumption-generation-prices-and-weather/data}

According to the dataset description, electricity demand and generation data were obtained from ENTSOE, electricity prices from Red Electrica de Espana (REE), and weather data from the OpenWeather API for the five largest cities in Spain.
}
\examples{
data(EnergyWx)
head(EnergyWx)

plot(load ~ temp,
     data = subset(EnergyWx, city == "Madrid"),
     xlab = "Daily mean temperature (C)",
     ylab = "Daily mean load")
}
\keyword{datasets}
