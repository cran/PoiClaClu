\name{CountDataSet}
\alias{CountDataSet}
\title{
Generate a simulated sequencing data set using a negative binomial model.  
}
\description{
Generate two nxp data sets: a training set and a test set, as well as
outcome vectors y and yte of length n indicating the class labels of the
training and test observations.
}
\usage{
CountDataSet(n, p, K, param, sdsignal)
}
\arguments{
  \item{n}{
Number of observations desired.
}
  \item{p}{
Number of features desired. Note that 30\% of the features will differ
between classes, though some of those differences may be small.
}
  \item{K}{
Number of classes desired. Note that the function requires that n be at
least equal to 4K -- i.e. there must be at least 4 observations per
class on average.
}
  \item{param}{
The dispersion parameter for the negative binomial distribution. The
negative binomial distribution is parameterized using "mu" and "size" in
the R function "rnbinom". That is, Y ~ NB(mu, param) means that E(Y)=mu
and Var(Y) = mu+mu^2/param.
So when param is very large this is essentially a Poisson distribution,
and when param is smaller then there is a lot of overdispersion relative
to the Poisson distribution.
}
  \item{sdsignal}{
The extent to which the classes are different. If this equals zero then
there are no class differences and if this is large then the classes are
very different.
}
}
\details{
This is based in part on a function in the DESeq Bioconductor package
(Anders and Huber 2010 Genome Biology) for generating a simulated RNA
sequencing data set.
}
\value{
  \item{x}{nxq data matrix. May have q<p because features with 0 total
    counts are removed.}
  \item{y}{class labels for the n observations in x.}
  \item{xte}{nxq data matrix of test observations; the q features are
    those with >0 total counts in x. So q<=p.}
  \item{yte}{class labels for the n observation in xte.}
}
\author{
Daniela Witten, based on software written by Anders and Huber in the
DESeq Bioconductor package.
}
\examples{
set.seed(1)
dat <- CountDataSet(n=20,p=100,sdsignal=2,K=4,param=10)
dd <- PoissonDistance(dat$x,type="mle", transform=TRUE)
}
