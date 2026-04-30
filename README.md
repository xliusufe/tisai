# tisai: AI enabled time series and spacial statistics

This package contains datasets used in the book "AI enabled time series and spacial statistics".

## Installation

You can install the package from GitHub using:

```r
devtools::install_github("xliusufe/tisai")
```

## Datasets

The package includes the following datasets:

- `Hare`: Hare population data
- `Lynx`: Lynx population data
- `gtemp.month`: Global temperature monthly data
- `lap`: LAP data

## Online market data helpers

The package also provides helper functions for downloading market data:

- `get_Ashare_data()`: downloads A-share daily stock data through AKShare.
- `get_CNmarket_data()`: downloads Chinese and related market series through AKShare.
- `get_USmarket_data()`: downloads daily market series from FRED.

`get_Ashare_data()` and `get_CNmarket_data()` require the R package
`reticulate` and the Python package `akshare`. Install the Python dependency
in the active Python environment before using these functions:

```r
install.packages("reticulate")
reticulate::py_install("akshare")
```

## Usage

To load the package and access the datasets:

```r
library(tisai)

data(Hare)
data(Lynx)
data(gtemp.month)
data(lap)

CNmarket <- get_CNmarket_data(from = "2024-01-02", to = "2024-01-10")
head(CNmarket)
```

## License

GPL (>=2)
