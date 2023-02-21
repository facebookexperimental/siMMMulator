# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 5b: Apply Adstock Decay
#'
#' Apply adstock decay (using geometric distribution) to media variables
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step5a_before_mmm A data frame that was created after running step 5a.
#' @param true_lambda_decay A vector of numbers between 0 and 1 specifying the lambda parameters for a geometric distribution for adstocking media variables. Vector must be in same order that channels are specified (channels using impressions as a metric followed by channels using click as metric of activity), must have same length as total number of channels
#'
#' @return A data frame with adstocked media variables
#' @export
#'
#' @examples
#' \dontrun{
#' step_5b_decay(
#'  my_variables = my_variables,
#'  df_ads_step5a_before_mmm = df_ads_step5a_before_mmm,
#' true_lambda_decay = c(0.1, 0.2, 0.15, 0.08)
#' )
#' }

step_5b_decay <- function(
  my_variables = my_variables,
  df_ads_step5a_before_mmm = df_ads_step5a_before_mmm,
  true_lambda_decay # a vector with same length as number of channels and in same order as specification of channels
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
  if (typeof(true_lambda_decay) != "double") stop("You did not enter a number for true_lambda_decay Must enter a numeric." ) # error if incorrect variable type for true_lambda_decay

  if (length(true_lambda_decay)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(true_lambda_decay)) == TRUE)) stop("Did not input in enough numbers or input in too many numbers for true_lambda_decay. Must have a value specified for each channel.") # error if not enough true_lambda_decay are supplied

  if (ifelse(all(true_lambda_decay >= 0), TRUE, FALSE) == FALSE) stop("You entered a negative decay rate. Enter a decay  rate between 0 and 1") # error if any decay rates entered are less than 0
  if (ifelse(all(true_lambda_decay <= 1), TRUE, FALSE) == FALSE) stop("You entered a decay rate greater than 1. Enter decay rate between 0 and 1.") # error if any decay rates are greater than 1

  # define media unit columns to apply decay adstock to
  cols_to_adstock_imps <- c() # account for when no channels using impressions  are provided
  if(length(channels_impressions) == 0) {
    cols_to_adstock_imps <- cols_to_adstock_imps
  } else {
    for (i in 1:length(channels_impressions)){
      cols_to_adstock_imps[i] <- paste0("sum_n_", channels_impressions[i], "_imps_this_day")
    }
  }

  cols_to_adstock_clicks <- c()
  if(length(channels_clicks) == 0) {cols_to_adstock_clicks <- cols_to_adstock_clicks # account for when no channels using clicks are provided
  } else {
    for (j in 1:length(channels_clicks)){
      cols_to_adstock_clicks[j] <- paste0("sum_n_", quo_name(channels_clicks[j]), "_clicks_this_day")
    }
  }

  cols_to_adstock <- c(cols_to_adstock_imps, cols_to_adstock_clicks)

  # apply decay
  intermediate_df <- df_ads_step5a_before_mmm
  for (i in 1:length(cols_to_adstock)){
    adstocked_col_name <- paste(cols_to_adstock[i], sep = "_", "adstocked") # makes new column name
    intermediate_df[, adstocked_col_name] <- NA # fills this column with NA
    adstocked_col <- numeric(nrow(intermediate_df)) # creates vector with number of rows
    adstocked_col[1] =   intermediate_df[1 ,cols_to_adstock[i]] # first number does not need to be processed
    for (j in 2:length(adstocked_col)) { # for the rest of the values in this vector
      adstocked_col[j] = intermediate_df[j, cols_to_adstock[i]] +
        (true_lambda_decay[i]*adstocked_col[j-1]) # Exponential distribution function
      intermediate_df[, adstocked_col_name] <- adstocked_col
    }
  }

  # output
  output <- intermediate_df

  print("You have completed running step 5b: applying adstock decay.")

  return(output)


}
