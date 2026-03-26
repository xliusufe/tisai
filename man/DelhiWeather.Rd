\name{DelhiWeather}
\alias{DelhiWeather}
\docType{data}
\title{Daily Weather and Air Quality Data for Selected Delhi Sites}
\description{
Daily weather and air-quality summaries for six monitoring locations in Delhi, India, during 2025.
}
\usage{data(DelhiWeather)}
\format{
A data frame with 2190 observations on the following 15 variables:
\describe{
  \item{\code{location}}{Monitoring location in Delhi.}
  \item{\code{date}}{Observation date in 2025.}
  \item{\code{lat}}{Latitude of the monitoring location.}
  \item{\code{lon}}{Longitude of the monitoring location.}
  \item{\code{temperature}}{Daily mean temperature in degrees Celsius.}
  \item{\code{humidity}}{Daily mean relative humidity percentage.}
  \item{\code{pressure}}{Daily mean atmospheric pressure in millibars.}
  \item{\code{windspeed}}{Daily mean wind speed in kilometers per hour.}
  \item{\code{condition}}{Most frequent hourly weather condition recorded on that day.}
  \item{\code{aqi}}{Daily mean air quality index.}
  \item{\code{pm25}}{Daily mean PM2.5 concentration in micrograms per cubic meter.}
  \item{\code{pm10}}{Daily mean PM10 concentration in micrograms per cubic meter.}
  \item{\code{co}}{Daily mean carbon monoxide concentration in micrograms per cubic meter.}
  \item{\code{no2}}{Daily mean nitrogen dioxide concentration in micrograms per cubic meter.}
  \item{\code{obs_hours}}{Number of hourly observations used in the daily summary.}
}
}
\details{
The original file contains 52560 hourly observations for six Delhi monitoring sites from January 1, 2025 to December 31, 2025. For teaching and package use, the hourly records are aggregated to a daily location-level panel by averaging the numeric indicators and retaining the most frequent hourly weather condition for each site-day.
}
\source{
Sohail Shaikh, \dQuote{Delhi Weather and AQI Dataset (2025)}, Kaggle.
\url{https://www.kaggle.com/datasets/sohails07/delhi-weather-and-aqi-dataset-2025}

According to the dataset description, the hourly records were aggregated from real-time weather and air-quality monitoring APIs for the Delhi NCR. The collector code is available at
\url{https://github.com/Sohail-Shaikh-07/AI-Agents/tree/main/weather-ai-agent}.
}
\examples{
data(DelhiWeather)
head(DelhiWeather)

plot(aqi ~ date,
     data = subset(DelhiWeather, location == "Anand Vihar"),
     type = "l",
     xlab = "Date",
     ylab = "Daily mean AQI")
}
\keyword{datasets}
