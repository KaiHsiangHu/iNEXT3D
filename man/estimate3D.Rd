% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MainFun.r
\name{estimate3D}
\alias{estimate3D}
\title{Compute species diversity with a particular of sample size/coverage}
\usage{
estimate3D(
  data,
  class,
  q = c(0, 1, 2),
  datatype = "abundance",
  base = "coverage",
  level = NULL,
  nboot = 50,
  conf = 0.95,
  tree,
  nT,
  reftime = NULL,
  PDtype = "PD",
  distM,
  threshold = NULL
)
}
\arguments{
\item{data}{a \code{data.frame} or \code{list} of species abundances or incidence frequencies.\cr 
If \code{datatype = "incidence"}, then the first entry of the input data must be total number of sampling units, followed 
by species incidence frequencies in each column or list.}

\item{class}{a choice of three-level diversity: 'TD' = 'Taxonomic', 'PD' = 'Phylogenetic', and 'FD' = 'Functional' under certain threshold. Besides,'AUC' is the fourth choice which 
integrates several threshold functional diversity to get diversity.}

\item{q}{a numerical vector of the order of Hill number.}

\item{datatype}{data type of input data: individual-based abundance data (\code{datatype = "abundance"}),
sampling-unit-based incidence frequencies data (\code{datatype = "incidence_freq"}) or species by sampling-units incidence matrix (\code{datatype = "incidence_raw"}).}

\item{base}{comparison base: sample-size-based (\code{base="size"}) or coverage-based \cr (\code{base="coverage"}).}

\item{level}{a sequence specifying the particular sample sizes or sample coverages(between 0 and 1). 
If \code{base="size"} and \code{level=NULL}, then this function computes the diversity estimates for the minimum sample size among all sites extrapolated to double reference sizes. 
If \code{base="coverage"} and \code{level=NULL}, then this function computes the diversity estimates for the minimum sample coverage among all sites extrapolated to double reference sizes.}

\item{nboot}{the number of bootstrap times to obtain confidence interval. If confidence interval is not desired, use 0 to skip this time-consuming step.}

\item{conf}{a positive number < 1 specifying the level of confidence interval, default is 0.95.}

\item{tree}{a phylo object describing the phylogenetic tree in Newick format for all observed species in the pooled assemblage. It is necessary when \code{class = 'PD'}.}

\item{nT}{needed only when \code{datatype = "incidence_raw"}, a sequence of named nonnegative integers specifying the number of sampling units in each assemblage.
If \code{names(nT) = NULL}, then assemblage are automatically named as "assemblage1", "assemblage2",..., etc.
It is necessary when \code{class = 'PD'} and \code{datatype = "incidence_raw"}.}

\item{reftime}{is set to be the tree depth of the phylogenetic tree, which is spanned by all the observed species in
the pooled assemblage. Default is \code{NULL}. It will be use when \code{class = 'PD'}.}

\item{PDtype}{desired phylogenetic diversity type: \code{PDtype = "PD"} for Chao et al. (2010) phylogenetic diversity
and \code{PDtype = "meanPD"} for mean phylogenetic diversity (phylogenetic Hill number). It will be use when \code{class = 'PD'}. Default is \code{"PD"}.}

\item{distM}{a pair wise distance matrix for all pairs of observed species in the pooled assemblage. It will be use when \code{class = 'FD' or 'AUC'}.}

\item{threshold}{a sequence between 0 and 1 specifying tau. If \code{NULL}, \code{threshold = } dmean. Default is \code{NULL}. It will be use when \code{class = 'FD'}.}
}
\value{
a \code{data.frame} of species diversity table including the sample size, sample coverage,
method (rarefaction or extrapolation), and diversity estimates with q = 0, 1, and 2 for the user-specified sample size or sample coverage.
}
\description{
\code{estimate3D}: computes species diversity (Hill numbers with q = 0, 1 and 2) with a particular user-specified level of sample size or sample coverage.
}
\examples{
# class = 'TD'
data(spider)
out1 <- estimate3D(spider, class = 'TD', q = c(0,1,2), datatype = "abundance", base = "size")
out1

# class = 'PD'
data(data.abu)
data <- data.abu$data
tree <- data.abu$tree
out2 <- estimate3D(data, class = 'PD', tree = tree, datatype = "abundance", base = "coverage")
out2

# class = 'FD'
data(FunDdata.abu)
data <- FunDdata.abu$data
dij <-  FunDdata.abu$dij
out3 <- estimate3D(data, class = 'FD', distM = dij, datatype = "abundance", base = "size")
out3

# class = 'AUC'
data(FunDdata.abu)
data <- FunDdata.abu$data
dij <-  FunDdata.abu$dij
out4 <- estimate3D(data = data[,2], class = 'AUC', distM = dij, datatype = "abundance", nboot = 0, base = "coverage")
out4

## example for incidence-based data
# class = 'TD'
data(ant)
out5 <- estimate3D(ant, class = 'TD', q = c(0,1,2), datatype = "incidence_freq", base="coverage", level=0.985)
out5

# class = 'PD'
data(data.inc)
data <- data.inc$data
tree <- data.inc$tree
nT <- data.inc$nT
out6 <- estimate3D(data, class = 'PD', nT = nT, tree = tree, datatype = "incidence_raw", base = "size")
out6

# class = 'FD'
data(FunDdata.inc)
data <- FunDdata.inc$data
dij <-  FunDdata.inc$dij
out7 <- estimate3D(data, class = 'FD', distM = dij, datatype = "incidence_freq", base = "coverage")
out7

# class = 'AUC'
data(FunDdata.inc)
data <- FunDdata.inc$data
dij <-  FunDdata.inc$dij
out8 <- estimate3D(data, class = 'AUC', distM = dij, datatype = "incidence_freq", nboot = 20, base = "size")
out8

}
