\name{Classify.cv}
\alias{Classify.cv}
\title{
Function to do cross-validation for Poisson classification.
}
\description{
  Perform cross-validation for the function that 
  implements the "sparse Poisson linear discriminant analysis
  classifier",
  which is similar to linear discriminant analysis but assumes a Poisson
  model rather than a Gaussian model for the data. The classifier
  soft-thresholds the estimated effect of each feature in order to
  achieve sparsity. This cross-validation function selects the proper
  value of the tuning parameter that controls the level of soft-thresholding.
}
\usage{
Classify.cv(x, y, rhos = NULL, beta = 1, nfolds = 5, type=c("mle","deseq","quantile"),
folds = NULL, transform=TRUE, alpha=NULL, prior=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{A n-by-p training data matrix; n observations and p features.
}
  \item{y}{
    A numeric vector of class labels of length n: 1, 2, ...., K if there
    are K classes.
    Each element of y corresponds to a row of x; i.e. these are the
    class labels for the observations in x.
}
  \item{rhos}{
A vector of tuning parameters to try out in cross-validation. Rho
controls the level of shrinkage performed, i.e. the number of features
that are not involved in the classifier. When rho=0 then all features
are involved in the classifier, and when rho is very large no features
are involved.
If rhos=NULL then a vector of rho values will be chosen automatically.
}
  \item{beta}{
    A smoothing term. A Gamma(beta,beta) prior is used to fit the
    Poisson model.
    Recommendation is to leave it at 1, the default value.
}
  \item{nfolds}{
 The number of folds in the cross-validation; default is 5-fold cross-validation.
}
  \item{type}{
    How should the observations be normalized within the
    Poisson model, i.e. how should the size factors be estimated?
    Options are "quantile" or "deseq" (more robust) or "mle" (less
    robust).
    
    In greater detail: "quantile" is quantile normalization approach
    of Bullard et al 2010 BMC Bioinformatics, "deseq"  is median of the
    ratio of an observation to a pseudoreference obtained by taking the
    geometric mean, described in Anders and Huber 2010 Genome
    Biology and implemented in Bioconductor package "DESeq", and "mle" is
    the sum of counts for each sample; this is the maximum likelihood
    estimate under a simple Poisson model.            
  }
  \item{prior}{
    Vector of length equal to the number of classes, representing prior
    probabilities
    for each class. If NULL then uniform priors are used (i.e. each
    class is equally likely).
  }

  \item{transform}{
  Should data matrices x and xte first be power transformed so  that it
  more  closely fits the Poisson model? TRUE or FALSE. Power
  transformation is especially  useful if the data are overdispersed
  relative to the Poisson model.}
  \item{alpha}{
  If transform=TRUE, this determines the power to which the data
  matrices x and xte are transformed. If alpha=NULL then the
  transformation that makes the Poisson model best fit the data matrix x
  is computed. (Note that alpha is computed based on x, not based on xte). Or a
  value of alpha, 0<alpha<=1, can be  entered by the user.
}                                                          
  \item{folds}{
 Instead of specifying the number of folds in cross-validation, one can
 explicitly specify the folds. To do this, input a list of length r (to
 perform r-fold cross-validation). The rth element of the list should be
 a vector containing the indices of the test observations in the rth fold.}
}
\value{
\item{errs}{A matrix of dimension (number of folds)-by-(length of
  rhos). The (i,j) element is the number of errors occurring in the ith cross-validation
  fold for the jth value of the tuning parameter, i.e. rhos[j].}
\item{bestrho}{The tuning parameter value resulting in the lowest
  overall cross-validation error rate.}
\item{rhos}{The vector of rho values used in cross-validation.}
\item{nnonzero}{A matrix of dimension (number of folds)-by-(length of
  rhos). The (i,j) element is the number of features included in the
  classifier occurring in the ith cross-validation fold for the jth
  value of the tuning paramer.}
  \item{folds}{Cross-validation folds used.}
  \item{alpha}{Power transformation used (if transform=TRUE).}
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
dat <- CountDataSet(n=40,p=500,sdsignal=.1,K=3,param=10)
cv.out <- Classify.cv(dat$x,dat$y)
print(cv.out)
out <- Classify(dat$x,dat$y,dat$xte,rho=cv.out$bestrho)
print(out)
cat("Confusion matrix comparing predicted class labels to true class
labels for training observations:", fill=TRUE)
print(table(out$ytehat,dat$yte))
}
