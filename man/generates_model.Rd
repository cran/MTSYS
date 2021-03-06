% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrapper.R
\name{generates_model}
\alias{generates_model}
\title{Wrapper function to generate a model for a family of Taguchi (T) methods}
\usage{
generates_model(unit_space_data, signal_space_data, sample_data,
  method = c("T1", "Ta", "Tb"), subtracts_V_e = TRUE,
  includes_transformed_data = FALSE)
}
\arguments{
\item{unit_space_data}{Used only for the T1 method. Matrix with n rows
(samples) and (p + 1) columns (variables). The 1 ~ p
th columns are independent variables and the (p + 1)
th column is a dependent variable. Underlying data
to obtain a representative point for the
normalization of \code{signal_space_data}. All data
should be continuous values and should not have
missing values.}

\item{signal_space_data}{Used only for the T1 method. Matrix with m rows
(samples) and (p + 1) columns (variables). The
1 ~ p th columns are independent variables and the
(p + 1) th column is a dependent variable.
Underlying data to generate a prediction
expression. All data should be continuous values
and should not have missing values.}

\item{sample_data}{Used for the Ta and the Tb methods. Matrix with n rows
(samples) and (p + 1) columns (variables). The 1 ~ p th
columns are independent variables and the (p + 1) th
column is a dependent variable. All data should be
continuous values and should not have missing values.}

\item{method}{Character to designate a method. Currently, "MT", "MTA", and
"RT" are available.}

\item{subtracts_V_e}{If \code{TRUE}, then the error variance is subtracted in
the numerator when calculating \code{eta_hat}.}

\item{includes_transformed_data}{If \code{TRUE}, then the transformed data
are included in a return object.}
}
\value{
A returned object depends on the selected method. See \code{\link{T1}},
          \code{\link{Ta}} or \code{\link{Tb}}.
}
\description{
\code{generates_model} generates a model for a family of Taguchi (MT) methods.
  The model of \code{\link{T1}} method, \code{\link{Ta}} method or the
  \code{\link{Tb}} method can be generated by passing a method name
  (character) into a parameter \code{method}.
}
\examples{
# The value of the dependent variable of the following samples mediates
# in the stackloss dataset.
stackloss_center <- stackloss[c(9, 10, 11, 20, 21), ]

# The following samples are data other than the unit space data and the test
# data.
stackloss_signal <- stackloss[-c(2, 9, 10, 11, 12, 19, 20, 21), ]

# The following test samples are chosen casually.
stackloss_test <- stackloss[c(2, 12, 19), -4]

# T1 method
model_T1 <- generates_model(unit_space_data = stackloss_center,
                            signal_space_data = stackloss_signal,
                            method = "T1",
                            subtracts_V_e = TRUE)

forecasting_T1 <- forecasting(model = model_T1,
                              newdata = stackloss_test)

(forecasting_T1$y_hat)

# Ta method
model_Ta <- generates_model(sample_data =
                                   rbind(stackloss_center, stackloss_signal),
                            method = "Ta",
                            subtracts_V_e = TRUE)

forecasting_Ta <- forecasting(model = model_Ta,
                              newdata = stackloss_test)

(forecasting_Ta$y_hat)

# Tb method
model_Tb <- generates_model(sample_data =
                                   rbind(stackloss_center, stackloss_signal),
                            method = "Tb",
                            subtracts_V_e = TRUE)

forecasting_Tb <- forecasting(model = model_Tb,
                              newdata = stackloss_test)

(forecasting_Tb$y_hat)

}
\seealso{
\code{\link{T1}}, \code{\link{Ta}}, \code{\link{Tb}}
}

