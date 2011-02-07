\name{FindBestTransform}
\alias{FindBestTransform}
\title{
Find the power transformation that makes a data set approximately Poisson.
}
\description{
Find a constant alpha, 0<alpha<=1, such that x raised to the power alpha
approximately follows the simple Poisson log linear model that says that
the (i,j) element of x is Poisson with mean si times gj, where si is a
sample-specific term and gj is a feature-specific term.
Alpha is selected via a grid search.
}
\usage{
FindBestTransform(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{A n-by-p matrix of sequencing data, with n observations and p features.}
}
\value{
Returns alpha, the power to which x should be raised.
}
\references{
D Witten (2011) Classification and clustering of sequencing data using a
Poisson model. To appear in Annals of Applied Statistics.
}
\author{
Daniela Witten
}
\examples{
set.seed(1)
dat <- CountDataSet(n=20,p=100,sdsignal=2,K=4,param=10)
alpha <- FindBestTransform(dat$x)
# This is the best transformation!
dd <- PoissonDistance(dat$x^alpha,type="mle", transform=FALSE)
# OR we could get the samething automatically:
dd2 <- PoissonDistance(dat$x,type="mle",transform=TRUE)
# or like this:
dd3 <- PoissonDistance(dat$x,type="mle",transform=TRUE,alpha=alpha)
ColorDendrogram(hclust(dd$dd), y=dat$y, branchlength=10)
}
