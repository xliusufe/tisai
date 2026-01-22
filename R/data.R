#' Hare population data
#'
#' This dataset contains hare population data from the book "AI enabled time series and spacial statistics".
#'
#' @name Hare
#' @docType data
#' @title Hare Population Data
#' @description Hare population data from the book "AI enabled time series and spacial statistics"
#' @usage data(Hare)
#' @format A time series object with the following characteristics:
#' \itemize{
#'   \item Time period: 1845 - 1935
#'   \item Frequency: Annual
#'   \item Values: Hare population counts
#' }
#' @details The Hare dataset provides annual population counts of hares from 1845 to 1935. This dataset is often used in time series analysis and population dynamics studies.
#' @source Package 'astsa' available at \href{https://nickpoison.github.io/}{https://nickpoison.github.io/}
#' @examples
#' data(Hare)
#' 
#' # Plot the hare population data
#' plot(Hare, main = "Hare Population Data", 
#'      xlab = "Year", ylab = "Population", 
#'      col = "blue")
#' 
#' # Calculate summary statistics
#' summary(Hare)
#' @keywords datasets
"Hare"

#' Lynx population data
#'
#' This dataset contains lynx population data from the book "AI enabled time series and spacial statistics".
#'
#' @name Lynx
#' @docType data
#' @title Lynx Population Data
#' @description Lynx population data from the book "AI enabled time series and spacial statistics"
#' @usage data(Lynx)
#' @format A time series object with the following characteristics:
#' \itemize{
#'   \item Time period: 1845 - 1935
#'   \item Frequency: Annual
#'   \item Values: Lynx population counts
#' }
#' @details The Lynx dataset provides annual population counts of lynx from 1845 to 1935. This dataset is often used in time series analysis and predator-prey relationship studies.
#' @source Package 'astsa' available at \href{https://nickpoison.github.io/}{https://nickpoison.github.io/}
#' @examples
#' data(Lynx)
#' 
#' # Plot the lynx population data
#' plot(Lynx, main = "Lynx Population Data", 
#'      xlab = "Year", ylab = "Population", 
#'      col = "red")
#' 
#' # Calculate summary statistics
#' summary(Lynx)
#' @keywords datasets
"Lynx"

#' Global temperature monthly data
#'
#' This dataset contains global temperature monthly data from the book "AI enabled time series and spacial statistics".
#'
#' @name gtemp.month
#' @docType data
#' @title Global Temperature Monthly Data
#' @description Global temperature monthly data from the book "AI enabled time series and spacial statistics"
#' @usage data(gtemp.month)
#' @format A data frame with 12 rows (months) and 49 columns (years from 1975 to 2023).
#' Each cell contains the average temperature for that month and year.
#' @details The gtemp.month dataset provides monthly global temperature data from 1975 to 2023. 
#' Rows represent months (1-12) and columns represent years. This dataset is often used in climate change analysis and time series modeling.
#' @source Package 'astsa' available at \href{https://nickpoison.github.io/}{https://nickpoison.github.io/}
#' @examples
#' data(gtemp.month)
#' 
#' # Transpose the data for plotting
#' gtemp_t <- t(gtemp.month)
#' 
#' # Plot the temperature data for January
#' plot(rownames(gtemp_t), gtemp_t[, 1], type = "l", 
#'      main = "January Global Temperature",
#'      xlab = "Year", ylab = "Temperature", 
#'      col = "blue")
#' 
#' # Calculate summary statistics for each month
#' apply(gtemp.month, 1, summary)
#' @keywords datasets
"gtemp.month"

#' LAP data
#'
#' This dataset contains LAP (Local Area Pollution) data from the book "AI enabled time series and spacial statistics".
#'
#' @name lap
#' @docType data
#' @title Local Area Pollution (LAP) Data
#' @description LAP data from the book "AI enabled time series and spacial statistics"
#' @usage data(lap)
#' @format A multivariate time series (mts) object with the following characteristics:
#' \itemize{
#'   \item Time period: 1970 - 1980
#'   \item Frequency: Weekly (52 observations per year)
#'   \item Number of variables: 11
#'   \item Variables: 
#'     \itemize{
#'       \item tmort: Total mortality
#'       \item rmort: Respiratory mortality
#'       \item cmort: Cardiovascular mortality
#'       \item tempr: Temperature
#'       \item rh: Relative humidity
#'       \item co: Carbon monoxide
#'       \item so2: Sulfur dioxide
#'       \item no2: Nitrogen dioxide
#'       \item hycarb: Hydrocarbons
#'       \item o3: Ozone
#'       \item part: Particulate matter
#'     }
#' }
#' @details The lap dataset provides weekly measurements of various pollution and health indicators from 1970 to 1980. 
#' This dataset is often used in environmental health studies and time series analysis of pollution effects.
#' @source Package 'astsa' available at \href{https://nickpoison.github.io/}{https://nickpoison.github.io/}
#' @examples
#' data(lap)
#' 
#' # Plot the first variable (total mortality)
#' plot(lap[, 1], main = "Total Mortality", 
#'      xlab = "Time", ylab = "Mortality Rate", 
#'      col = "red")
#' 
#' # Calculate correlation between temperature and ozone
#' cor(lap[, "tempr"], lap[, "o3"], use = "complete.obs")
#' 
#' # Plot multiple variables
#' plot(lap[, c("tempr", "o3", "co")], 
#'      main = "Temperature, Ozone, and Carbon Monoxide")
#' @keywords datasets
"lap"