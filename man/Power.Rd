\name{Power}
\alias{Power}
\docType{data}
\title{Hourly Household Electricity Consumption}
\description{
Hourly electricity consumption of a household in 2010.
}
\usage{data(Power)}
\format{
A data frame containing:
\describe{
  \item{\code{time}}{Hourly timestamp}
  \item{\code{power}}{Active power (kilowatt)}
  \item{\code{reactive}}{Reactive power (kilowatt)}
  \item{\code{voltage}}{Voltage (volt)}
  \item{\code{current}}{Current intensity (ampere)}
  \item{\code{sub1}}{Energy sub-metering 1}
  \item{\code{sub2}}{Energy sub-metering 2}
  \item{\code{sub3}}{Energy sub-metering 3}
}
}
\source{
UCI Machine Learning Repository.
\url{https://archive.ics.uci.edu/ml/datasets/individual+household+electric+power+consumption}
}
\keyword{datasets}