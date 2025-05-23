% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrangle.R
\name{unsorted.data.frame}
\alias{unsorted.data.frame}
\title{Extract records whose relative positions would change if sorted.}
\usage{
\method{unsorted}{data.frame}(x, ...)
}
\arguments{
\item{x}{data.frame}

\item{...}{optional grouping columns (named arguments are ignored)}
}
\value{
data.frame, possibly grouped_df
}
\description{
Extracts records whose relative positions would change if sorted, i.e. records that would not have the same nearest neighbors (before and after). misplaced() returns the index that extracts these records.
}
\seealso{
\code{\link{na}} \code{\link{dup}}

Other unsorted: 
\code{\link{misplaced}()},
\code{\link{misplaced.data.frame}()},
\code{\link{unsorted}()}
}
\concept{unsorted}
