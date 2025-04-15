# wrangle

**wrangle** is an R package that provides a systematic set of tools for data wrangling with a focus on data integrity.
It helps you identify and address common data issues (missing values, duplicate entries, unsorted records), examine unique combinations of data, remove uninformative columns, and safely merge datasets without unintended side effects.

## Installation

You can install the stable release of **wrangle** from CRAN:

```r
install.packages("wrangle")
```

Or install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("bergsmat/wrangle")
```

## Usage

Load the package and use its functions to inspect and transform your data.
Below is a quick example demonstrating some core functionality:

```r
# Sample data frames
x <- data.frame(id = 1:3, value = c("A", "B", "C"))
y <- data.frame(id = c(1, 2, 2, 3), extra = c("X", "Y", "Y2", "Z"))

# Identify any problematic rows in x
wrangle::status(x)
#> Source: local data frame [3 x 2]
#> Groups: 
#> NAs: 0 
#> duplicates: 0 
#> unsorted: 0 

# Perform a safe join (left join that checks for duplicates)
# A standard left_join would duplicate rows for id=2:
dplyr::left_join(x, y, by = "id")
#>   id value extra
#> 1  1     A     X
#> 2  2     B     Y   # id 2 from x matched two rows in y, causing two output rows
#> 3  2     B    Y2
#> 4  3     C     Z

# Using safe_join instead:
wrangle::safe_join(x, y, by = "id")
#> Error: safe_join found that the join would alter the number of rows.
#> i Row 2 of `x` matches multiple rows in `y`. Each row in `x` must match at most one row in `y`.
```

In the example above, `status()` reports that `x` has no missing values, duplicates, or unsorted rows.
We then try to join `x` with `y`.
A normal `left_join()` (from dplyr) produces duplicated rows for id == 2.
wrangle’s safe_join detects this issue and throws an error instead of silently introducing inconsistencies, ensuring your merged data retains the same number of rows as the original.

Other useful functions in wrangle include:

* `dup(x, ...)` / `dupGroups(x, ...)`: find or flag duplicate rows in a data frame (optionally within groups).
* `na(x, ...)` / `naGroups(x, ...)`: find or flag rows with missing values in key columns.
* `weak(x, ...)`: quickly check if a data frame has any missing, duplicate, or unsorted entries (a combination of the above checks).
* `constant(x, ...)`: identify constant columns (e.g., columns with the same value in every row, overall or within groups).
* `informative(x)`: drop columns that are entirely NA (no information).
* `enumerate(x, cols...)` and `itemize(x, cols...)`: list unique combinations of specified columns (with counts using enumerate, or without counts using itemize).
* `ignore(x, y)`: drop columns in x that also appear in y (useful before merging datasets to avoid duplicate columns).

For detailed documentation on each function, see the reference manual or use the R help, e.g. `?status` or `?safe_join`.

## Documentation and Support

* The official manual is available on CRAN: you can read it by running `help(package="wrangle")` or on the CRAN package page.
* Report issues or suggest improvements on the GitHub issue tracker.
* For examples and usage tips, check the function reference in the package documentation.

Happy wrangling!
