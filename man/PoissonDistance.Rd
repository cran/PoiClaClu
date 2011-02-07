\name{PoissonDistance}
\alias{PoissonDistance}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Given a n-by-p data matrix, compute the corresponding n-by-n Poisson dissimilarity matrix.
}
\description{
This function computes a Poisson dissimilarity matrix as described in
the paper referenced below, and is intended to be applied to a data
matrix of counts resulting from a sequencing experiment.
The (i,k) element of the Poisson dissimilarity matrix is the
dissimilarity between observations i and k of the data matrix x: that is, the log
likelihood ratio statistic under a simple Poisson model.
}
\usage{
PoissonDistance(x, beta = 1, type=c("mle","deseq","quantile"),
transform=TRUE, alpha=NULL, perfeature=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
A n-by-p data matrix with observations on the rows, and p features on
the columns. The (i,j) element of x is the number of reads in
observation i that mapped to feature (e.g. gene or exon) j.
}
  \item{beta}{
A smoothing term; essentially the parameter beta in a Gamma(beta,beta)
prior used to estimate the log likelihood ratio statistic for computing
the dissimilarity between a pair of observations. Recommended to leave
it at 1, the default value.
}
  \item{type}{  How should the observations be normalized within the
    Poisson model, i.e. how should the size factors be estimated?
    Options are "quantile" or "deseq" (more robust) or "mle" (less robust).
    
   In greater detail: "quantile" is quantile normalization approach of Bullard
    et al 2010 BMC Bioinformatics, "deseq"  is median of the ratio of an
    observation to a pseudoreference obtained by taking the geometric
    mean, described in Anders and Huber 2010 Genome Biology and
    implemented in Bioconductor package "DESeq", and "mle" is the sum of
    counts for each sample; this is the maximum likelihood estimate
    under a simple Poisson model.
  }
  \item{transform}{
    Should data matrix x first be power transformed so that it more closely fits
    the Poisson model? TRUE or FALSE. Power transformation is especially
    useful if the data are overdispersed relative to the Poisson model.
  }
  \item{alpha}{
    If transform=TRUE, this determines the power to which the data
    matrix x is transformed. If alpha=NULL then the transformation that
    makes the Poisson model best fit the data is computed. Or a value of
    alpha, 0<alpha<=1, can be entered by the user.
  }
  \item{perfeature}{
    If perfeature=TRUE, then in addition to the nxn dissimilarity
    matrix, a nxnxp array will be returned. Its elements will be the
    contributions of each of the p features to the nxn dissimilarity
    matrix; summing over the 3rd index will simply give back the nxn
    dissimilarity matrix.
  }
}
\details{
More details can be found in the paper referenced below.
}
\value{
 \item{dd}{A nxn Poisson dissimilarity matrix, containing pairwise
   dissimilarities between observations based on the original nxp data
   matrix x input by the user.}
 \item{alpha}{Power to which data was transformed before computing
   dissimilarity matrix, if transform was TRUE. This was either input by
 the user, or computed automatically if not specified.}
 \item{x}{Data used to compute dissimilarity matrix, this will be x
   raised to the power alpha.}
 \item{ddd}{If perfeature=TRUE, then this is the nxnxp array containing
   the contribution of each feature to the nxn dissimilarity matrix.}
}
\references{
D Witten (2011) Classification and clustering of sequencing data using a
Poisson model. To appear in Annals of Applied Statistics.
}
\author{
Daniela Witten
}
\seealso{
  \code{\link{FindBestTransform}}
}
\examples{
set.seed(1)
dat <- CountDataSet(n=20,p=100,sdsignal=2,K=4,param=10)
dd <- PoissonDistance(dat$x,type="mle")
print(dd)
ColorDendrogram(hclust(dd$dd), y=dat$y, branchlength=10)
}
