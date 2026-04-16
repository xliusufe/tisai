\name{walmart_sales_weekly}
\alias{walmart_sales_weekly}
\docType{data}
\title{Weekly Walmart Sales Sample}
\description{
Weekly Walmart sales data redistributed from the \pkg{timetk} package and reorganized for use in \pkg{tisai}.
}
\usage{data(walmart_sales_weekly)}
\format{
A data frame with 1001 observations on the following 17 variables:
\describe{
  \item{\code{id}}{Series identifier combining store and department.}
  \item{\code{store}}{Store identifier.}
  \item{\code{dept}}{Department identifier.}
  \item{\code{date}}{Weekly date from February 5, 2010 to October 26, 2012.}
  \item{\code{weekly_sales}}{Weekly department sales.}
  \item{\code{is_holiday}}{Logical indicator for holiday weeks.}
  \item{\code{type}}{Store type.}
  \item{\code{size}}{Store size in square feet.}
  \item{\code{temperature}}{Regional average temperature.}
  \item{\code{fuel_price}}{Regional fuel price.}
  \item{\code{markdown1}}{Promotional markdown feature 1.}
  \item{\code{markdown2}}{Promotional markdown feature 2.}
  \item{\code{markdown3}}{Promotional markdown feature 3.}
  \item{\code{markdown4}}{Promotional markdown feature 4.}
  \item{\code{markdown5}}{Promotional markdown feature 5.}
  \item{\code{cpi}}{Consumer price index.}
  \item{\code{unemployment}}{Regional unemployment rate.}
}
}
\details{
The original \pkg{timetk} dataset is a sample derived from the Kaggle competition \dQuote{Walmart Recruiting - Store Sales Forecasting}. The \pkg{tisai} version keeps the same sample coverage, which contains seven department-level weekly series from Store 1, while standardizing the object as a base data frame with lowercase variable names. Missing promotional markdown values are preserved.
}
\source{
Redistributed from the \pkg{timetk} package.
\url{https://cran.r-project.org/package=timetk}
\url{https://cran.r-project.org/web/packages/timetk/timetk.pdf}

In \pkg{timetk}, this dataset is described as a sample derived from the Kaggle competition \dQuote{Walmart Recruiting - Store Sales Forecasting}.
\url{https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting}
}
\examples{
data(walmart_sales_weekly)
head(walmart_sales_weekly)

subset(walmart_sales_weekly, dept == 1)[1:6, ]
}
\keyword{datasets}
