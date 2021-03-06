\name{qmethod}
\alias{qmethod}
\title{Q methodology analysis}
\description{This function performs a full Q method analysis using principal components analysis (see Notes). The main results are factor characteristics, statement z-scores and factor scores, and distinguishing and consensus statements.}
\usage{
qmethod(dataset, nfactors, rotation = "varimax", forced = TRUE, 
        distribution = NULL, cor.method = "pearson",
        silent = FALSE, ...)}

\arguments{
  \item{dataset}{a matrix or a data frame containing original data, with statements as rows, Q-sorts as columns, and the column scores in the distribution in each cell. The matrix or data frame should not contain character strings. The results keep row names and column names if set in the \code{dataset} (see 'Details').}
  \item{nfactors}{number of factors to extract.}
  \item{rotation}{rotation method, defaults to \code{"varimax"}. Other possible rotations allowed in \code{\link[psych]{principal}} function can be used: \code{"none"}, \code{"varimax"}, \code{"quartimax"}, \code{"promax"}, \code{"oblimin"}, \code{"simplimax"}, and \code{"cluster"}.}
  \item{forced}{logical; Is the ranking of the items forced to match the distributions? Set to \code{TRUE} if all respondents ranked the items strictly following the distribution scores, in which case the values of the distribution are calculated automatically. Set to \code{FALSE} if respondents were able to rank the items without following the distribution, and the values of the distribution have to be provided as an array in the argument \code{distribution}.}
\item{distribution}{logical; when forced = \code{FALSE}, the distribution has to be provided as a vector of numbers, such as \code{c(-2, -1, -1, 0, 1, 1, 2, 2)}.}
\item{cor.method}{character string indicating which correlation coefficient is to be computed, to be passed on to the function \code{\link[stats]{cor}}: \code{"pearson"} (default), \code{"kendall"}, or \code{"spearman"}. }
\item{silent}{logical; when = \code{TRUE}, a summary message is printed.}
\item{...}{other parameters to pass to functions such as \code{\link[psych]{principal}}}
}

\details{This function wraps together all the steps required for a complete analysis: extracting component loadings (\code{\link[psych]{principal}}); flagging Q-sorts (\code{\link{qflag}}); calculating weights, z-scores, and rounded scores (\code{\link{qzscores}}), calculating general characteristics (\code{\link{qfcharact}}), and finding distinguishing and consensus statements (\code{\link{qdc}}).

The default \code{\link{qmethod}} performs automatic flagging and uses varimax rotation. Varimax rotation can be replaced by other methods for rotation allowed in \code{\link[psych]{principal}} from \pkg{psych} package.

If the input data contains row names and variable names, these will be kept throughout the analysis. Input data is validated, and it will give an error if there are non numerical values or either if the number of statements and Q-sorts introduced does not match the input data. It also returns error if the argument \code{forced} is set to \code{TRUE} but Q-sorts contain differing distributions.
}
\value{
Returns a list of class \code{QmethodRes}, with eight objects:
\item{brief}{a list with the basic values of the analysis: date (\code{"date"}), number of statements (\code{"nstat"}), number of Q-sorts (\code{"nqsort"}), whether the distribution was 'forced' (\code{"distro"}),  number of factors extracted (\code{"nfactors"}), type or rotation (\code{"rotation"}), method for correlation in the PCA (\code{"cor.method"}), and a summary of this information for display purposes (\code{"info"}).}
\item{dataset}{original data.}
\item{loa}{factor loadings for Q-sorts.}
\item{flagged}{logical dataframe of flagged Q-sorts.}
\item{zsc}{statements z-scores.}
\item{zsc_n}{statements factor scores, matched to the ordered array of values in the first row of the dataset.}
\item{f_char}{factor characteristics (see \code{\link{qfcharact}}):
\itemize{
    \item{\code{"characteristics"}: data frame with the following values for each factor: average reliability coefficient, number of loading Q-sorts, eigenvalues, percentage of explained variance, composite reliability, standard error of factor scores.}
    \item{\code{"cor_zsc"}: matrix of correlation coefficients between factors z-scores.}
    \item{\code{"sd_dif"}: matrix of standard errors of differences.}
    }
    }
\item{qdc}{distinguishing and consensus statements (see \code{\link{qdc}}).}
}
\references{Brown, S. R., 1980 \emph{Political subjectivity: Applications of Q methodology in political science}, New Haven, CT: Yale University Press.

See further references on the methodology in \code{\link{qmethod-package}}.}

\note{
In Q methodology there are commonly two techniques to extract the factors: principal components analysis (PCA) and centroid factor analysis. 

This package uses PCA because this function is already implemented in R. If you find a function in R that suitably implements centroid factor analysis as used in Q method (See Brown, 1980), please report to the author of this package: \email{aiora.zabala@gmail.com}.
}

\author{Aiora Zabala}

\seealso{
\code{\link[psych]{principal}} in package \pkg{psych}
}
\examples{
data(lipset)
results <- qmethod(lipset[[1]], nfactors = 3, rotation = "varimax")
summary(results)
results #shows all results
}
