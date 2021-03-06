\name{PoiClaClu-package}
\alias{PoiClaClu-package}
\alias{PoiClaClu}
\docType{package}
\title{
Classification and clustering of RNA sequencing data using a Poisson model
}
\description{
 A simple approach for performing classification and clustering of
 samples for which RNA sequencing data is available. Based upon a
  simple Poisson model proposed by a number of authors (e.g. Marioni et
  al Genome Research 2008, Bullard et al BMC Bioinformatics 2010, and
  others).
}
\details{
\tabular{ll}{
Package: \tab PoiClaClu\cr
Type: \tab Package\cr
Version: \tab 1.0.2\cr
Date: \tab 2013-01-02\cr
License: \tab GPL-2 \cr
LazyLoad: \tab yes\cr
}

}
\author{
Daniela Witten

Maintainer: Daniela Witten <dwitten@u.washington.edu>
}
\references{
  D. Witten (2011) Classification and clustering of sequencing data
  using a Poisson model. Annals of Applied Statistics 5(4): 2493-2518.
}
\examples{
# Poisson clustering #
set.seed(1)
dat <- CountDataSet(n=20,p=100,sdsignal=.5,K=4,param=10)
dd <- PoissonDistance(dat$x, type="mle")
print(dd)
ColorDendrogram(hclust(dd$dd), y=dat$y)

# Poisson classification #
set.seed(1)
dat <- CountDataSet(n=20,p=100,sdsignal=.1,K=4,param=10)
out <- Classify(x=dat$x,y=dat$y,xte=dat$xte,rhos=c(0,5,10))
print(out)

}
