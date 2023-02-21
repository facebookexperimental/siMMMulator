# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 5c: Applying Diminishing Returns to Media Variables
#'
#' Apply diminishing returns to our media variables
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step5b A data frame that was created after running step 5b.
#' @param alpha_saturation A vector of numbers specifying alpha parameter of geometric distribution for applying diminishing returns to media variables. Should be in the same order as how the media channels were specified (first with the channels that use impressions as a metric of activity and then channels that use clicks), must have same length as number of total channels
#' @param gamma_saturation A vector of numbers between 0 and 1 specifying gamma parameter of geometric distribution for applying diminishing returns to media variables. MUST have elements between 0 and 1!!!! Should be in the same order as how the media channels were specified (first with the channels that use impressions as a metric of activity and then channels that use clicks), must have same length as number of total channels.
#' @param x_marginal Numeric. When provided, the function returns the Hill-transformed value of the x_marginal input. Default is to leave NULL. If you leave as NULL, you may get a warning message but this is not harmful.
#'
#' @importFrom stats quantile
#'
#' @return A data frame with media variables that exhibit diminishing returns
#' @export
#'
#' @examples
#' \dontrun{
#' step_5c_diminishing_returns(
#' my_variables = my_variables,
#' df_ads_step5b = df_ads_step5b,
#' alpha_saturation = c(4, 3, 2),
#' gamma_saturation = c(0.2, 0.3, 0.4)
#' )
#'}

step_5c_diminishing_returns <- function(
  my_variables = my_variables,
  df_ads_step5b = df_ads_step5b,
  alpha_saturation,
  gamma_saturation,
  x_marginal = NULL
)
{
  # calculate inputs needed
  years <- my_variables[[1]]
  channels_impressions <- my_variables[[2]]
  channels_clicks <- my_variables[[3]]
  frequency_of_campaigns <- my_variables[[4]]
  true_cvr <- my_variables[[5]]
  start_date <- my_variables[[7]]

  n_days <- years*365
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # Display error messages for invalid inputs
  if (typeof(alpha_saturation) != "double") stop("You did not enter a number for alpha_saturation. Must enter a numeric." ) # error if incorrect variable type for alpha_saturation
  if (typeof(gamma_saturation) != "double") stop("You did not enter a number for gamma_saturation. Must enter a numeric." ) # error if incorrect variable type for gamma_saturation

  if (length(alpha_saturation)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(alpha_saturation)) == TRUE)) stop("Did not input in enough numbers or input too many numbers for alpha_saturation. Must have a value specified for each channel.") # error if not enough alpha_saturation are supplied
  if (length(gamma_saturation)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(gamma_saturation)) == TRUE)) stop("Did not input in enough numbers or input too many numbers for gamma_saturation. Must have a value specified for each channel.") # error if not enough gamma_saturation are supplied

  if (ifelse(all(gamma_saturation >= 0), TRUE, FALSE) == FALSE) stop("You entered a negative gamma_saturation. Enter a gamma_saturation between 0 and 1") # error if any gamma_saturation entered are less than 0
  if (ifelse(all(gamma_saturation <= 1), TRUE, FALSE) == FALSE) stop("You entered a gamma_saturation greater than 1. Enter gamma_saturation between 0 and 1.") # error if any gamma_saturation are greater than 1

  ## define media unit columns to apply diminishing returns to
  cols_to_adstock_imps <- c()
  if(length(channels_impressions) == 0) {
    cols_to_adstock_imps <- cols_to_adstock_imps
  } else {
    for (i in 1:length(channels_impressions)){
      cols_to_adstock_imps[i] <- paste0("sum_n_", channels_impressions[i], "_imps_this_day_adstocked")
    }
  }

  cols_to_adstock_clicks <- c()
  if(length(channels_clicks) == 0) {
    cols_to_adstock_clicks <- cols_to_adstock_clicks # account for when no channels using clicks are provided
  } else {
    for (j in 1:length(channels_clicks)){
      cols_to_adstock_clicks[j] <- paste0("sum_n_", quo_name(channels_clicks[j]), "_clicks_this_day_adstocked")
    }
  }

  cols_to_adstock <- c(cols_to_adstock_imps, cols_to_adstock_clicks)


  # apply diminishing returns
  output <- df_ads_step5b
  for (i in 1:length(cols_to_adstock)){

    # specify what to name the new column
    adstocked_col_name <- paste(cols_to_adstock[i], sep = "_", "adstocked_decay_diminishing") # makes new column name
    output[, adstocked_col_name] <- NA # fills this column with NA
    for (j in 1:nrow(output)) {

      # specify media unit
      x <- df_ads_step5b[, cols_to_adstock[i]]

      # calculate s-curve
      gammaTrans <- round(quantile(seq(range(x)[1], range(x)[2], length.out = 100), gamma_saturation), 4)
      if (is.null(x_marginal)) {
        x_scurve <- x**alpha_saturation / (x**alpha_saturation + gammaTrans**alpha_saturation) # plot(x_scurve) summary(x_scurve)
      } else {
        x_scurve <- x_marginal**alpha_saturation / (x_marginal**alpha_saturation + gammaTrans**alpha_saturation)
      }

      # multiply s-curve with that unit of media
      output[j, adstocked_col_name] <-x_scurve[j]*df_ads_step5b[j, cols_to_adstock[i]]

    }
  }

  # output

  print("You have completed running step 5c: apply diminishing marginal returns.")

  return(output)

}


