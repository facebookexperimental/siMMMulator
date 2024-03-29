# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 1 : Simulate Daily Baseline Sales
#'
#' Generates daily baseline sales (sales not due to ad spend) for number of years specified. Takes user input and ads statistical noise.
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param base_p A number, Amount of baseline sales we get in a day (sales not due to ads)
#' @param trend_p A number, How much baseline sales is going to grow over the whole period of our data.
#' @param temp_var A number, How big the height of the sine function is for temperature -- i.e. how much temperature varies (used to inject seasonality into our data)
#' @param temp_coef_mean A number, The average of how important seasonality is in our data (the larger this number, the more important seasonality is for sales)
#' @param temp_coef_sd A number, The standard deviation of how important seasonality is in our data (the larger this number, the more variable the importance of seasonality is for sales)
#' @param error_std A number, Amount of statistical noise added to baseline sales (the larger this number, the noisier baseline sales will be).
#'
#' @return A data frame with daily baseline sales
#' @importFrom stats rnorm
#' @export
#'
#' @examples
#' \dontrun{
#' step_1_create_baseline(my_variables = my_variables,
#'                        base_p = 10000,
#'                        trend_p = 1.8,
#'                        temp_var = 8,
#'                        temp_coef_mean = 50000,
#'                        temp_coef_sd = 5000,
#'                        error_std = 100)
#'                        }

step_1_create_baseline <- function(my_variables = my_variables,
                                   base_p,
                                   trend_p = 2,
                                   temp_var = 8,
                                   temp_coef_mean = 50000,
                                   temp_coef_sd = 5000,
                                   error_std = 100){


  # Extract necessary variables from Step 0's output
  years = my_variables[[1]][[1]]

  # Display error messages for invalid inputs
  if (typeof(base_p) != "double") stop("You did not enter a number for base_p. You must have years be a numeric type.") # error if incorrect variable type for base_p
  if (typeof(trend_p) != "double") stop("You did not enter a number for trend_p. You must enter a numeric") # error if incorrect variable type for trend_p
  if (typeof(temp_var) != "double") stop("You did not enter a number for temp_var. Must enter a numeric." )# error if incorrect variable type for temp_var
  if (typeof(temp_coef_mean) != "double") stop("You did not enter a number for temp_coef_mean. Must enter a numeric." ) # error if incorrect variable type for temp_coef_mean
  if (typeof(temp_coef_sd) != "double") stop("You did not enter a number for temp_coef_sd. Must enter a numeric." ) # error if incorrect variable type for temp_coef_sd
  if (typeof(error_std) != "double") stop("You did not enter a number for error_std. Must enter a numeric." ) # error if incorrect variable type for error_std
  if (error_std > base_p) warning("You entered an error much larger than your baseline sales. As a result, you may get negative numbers for baseline sales. We have corrected these negative baseline sales to 0. To not get this warning, set an error_std much lower than base_p.")

  # Number of days to generate data for
  day <- 1:(years*365)

  # Base sales of base_p units
  base <- rep(base_p,years*365)

  #Trend of trend_p extra units per day
  trend_cal <- (trend_p/(years*365))*base_p
  trend <- trend_cal*day

  #Temperature generated by a sin function and we can manipulate how much the sin function goes up or down with temp_var
  temp <- temp_var*sin(day*3.14/182.5)

  # coefficient of temperature's effect on sales will be a random variable with normal distribution
  seasonality <- rnorm(1, mean = temp_coef_mean, sd = temp_coef_sd)*temp

  # add some noise to the trend
  error <- rnorm(years*365, mean=0, sd=error_std)

  # Generate series for baseline sales
  baseline_sales <- base + trend + seasonality + error

  # if error term makes baseline_sales negative, make it 0
  for(i in 1:length(baseline_sales)) {
    if(baseline_sales[i] < 0) {baseline_sales[i] <- 0 }
  }

  output <- data.frame(day, baseline_sales, base, trend, temp, seasonality, error)

  print("You have completed running step 1: generating baseline sales.")

  return(output)



}
