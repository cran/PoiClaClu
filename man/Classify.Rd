\name{Classify}
\alias{Classify}
\title{
  Classify observations using a Poisson model.
}
\description{
Classify observations using a simple Poisson model. This function
implements the "sparse Poisson linear discriminant analysis classifier",
which is similar to linear discriminant analysis but assumes a Poisson
model rather than a Gaussian model for the data. The classifier
soft-thresholds the estimated effect of each feature in order to achieve sparsity.
}
\usage{
Classify(x, y, xte=NULL, rho = 0, beta = 1, rhos = NULL, type=c("mle","deseq","quantile"),
prior = NULL, transform=TRUE, alpha=NULL)
}
\arguments{
  \item{x}{
A n-by-p training data matrix; n observations and p features. Used to train the
classifier.
}
  \item{y}{
    A numeric vector of class labels of length n: 1, 2, ...., K if there
    are K classes.
    Each element of y corresponds to a row of x; i.e. these are the
    class labels for the observations in x.
}
  \item{xte}{
A m-by-p data matrix: m test observations and p features. The classifier
fit on the training data set x will be tested on this data set. If NULL,
then testing will be performed on the training set.
}
  \item{rho}{
Tuning parameter controlling the amount of soft thresholding performed,
i.e. the level of sparsity, i.e. number of nonzero features in
classifier. Rho=0 means that there is no soft-thresolding, i.e. all
features used in classifier. Larger rho means that fewer features will
be used.
}
  \item{beta}{
    A smoothing term. A Gamma(beta,beta) prior is used to fit the
    Poisson model.
    Recommendation is to just leave it at 1, the default value.
}
  \item{rhos}{
A vector of tuning parameters that control the amount of soft thresholding
performed. If "rhos" is provided then a number of
models will be fit (one for each element of "rhos"), and a number of
predicted class labels will be output (one for each element of "rhos").
}
  \item{type}{
    How should the observations be normalized within the
    Poisson model, i.e. how should the size factors be estimated?
    Options are "quantile" or "deseq" (more robust) or "mle" (less
    robust).

    In greater detail: "quantile" is quantile normalization approach
    of Bullard et al 2010 BMC Bioinformatics, "deseq"  is median of the
    ratio of an observation to a pseudoreference obtained by taking the
    geometric mean, described in Anders and Huber 2010 Genome Biology and
    implemented in Bioconductor package "DESeq", and "mle" is the sum of
    counts for each sample; this is the maximum likelihood estimate
    under a simple Poisson model.
                   
}
  \item{prior}{
    Vector of length equal to the number of classes, representing prior
    probabilities
    for each class. If NULL then uniform priors are used (i.e. each
    class is equally likely).
  }
  \item{transform}{
        Should data matrices x and xte first be power transformed so that it more
        closely fits
        the Poisson model? TRUE or FALSE. Power transformation is
        especially
        useful if the data are overdispersed relative to the Poisson
        model.
      }
 \item{alpha}{
        If transform=TRUE, this determines the power to which the data
        matrices x and xte are transformed.
        If alpha=NULL then the transformation that
        makes the Poisson model best fit the data matrix x is
        computed. (Note that alpha is computed based on x, not based on
        xte). Or a value of
        alpha, 0<alpha<=1, can be entered by the user.
 }              
}
\value{
  \item{ytehat}{The predicted class labels for each of the test
    observations (rows of xte). }
  \item{discriminant}{A m-by-K matrix, where K is the number of classes.
  The (i,k) element is large if the ith element of
xte belongs to class k.}
  \item{ds}{A K-by-p matrix indicating the extent to which each feature
    is under- or over-expressed in each class. The (k,j) element is >1
    if feature j is over-expressed in class k, and is <1 if feature j is
  under-expressed in class k. When rho is large then many of the elemtns
  of this matrix are shrunken towards 1 (no over- or under-expression).}
\item{alpha}{Power transformation used (if transform=TRUE).}
}
\references{
D Witten (2011) Classification and clustering of sequencing data using a
Poisson model. To appear in Annals of Applied Statistics.
}
\author{
Daniela Witten
}
\seealso{
\code{\link{Classify.cv}}
}
\examples{
set.seed(1)
dat <- CountDataSet(n=40,p=500,sdsignal=.1,K=3,param=10)
cv.out <- Classify.cv(dat$x,dat$y)
print(cv.out)
out <- Classify(dat$x,dat$y,dat$xte,rho=cv.out$bestrho)
print(out)
cat("Confusion matrix for predicted and true test class labels:", fill=TRUE)
print(table(out$ytehat,dat$yte))
}
