# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 6 : Calculating Conversions
#'
#' We calculate the number of conversions that occur each week and on each channel using the outputs from previous steps.
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step5c A data frame that was created after running step 5c.
#'
#' @return A data frame with number of conversions on each channel
#' @export
#'
#' @examples
#' \dontrun{
#' step_6_calculating_conversions(
#'   my_variables = my_variables,
#'   df_ads_step5c = df_ads_step5c
#'   )
#' }
#'

step_6_calculating_conversions <- function(
  my_variables = my_variables,
  df_ads_step5c = df_ads_step5c
)
{
  # calculate inputs that we need
  years <- my_variables[[1]]
  channels_impressions <- my_variables[[2]]
  channels_clicks <- my_variables[[3]]
  frequency_of_campaigns <- my_variables[[4]]
  true_cvr <- my_variables[[5]]

  n_weeks <- years*52
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # calculate conversions
  output <- df_ads_step5c
  if (length(channels_impressions) == 0) { # account for cases when no channels that use impressions are provided

  } else {
    for(i in 1:length(channels_impressions)){
      for(j in 1:nrow(output)) {
        output[,paste0("conv_", quo_name(channels_impressions[i]))] <-
          output[,paste0("sum_n_", quo_name(channels_impressions[i]), "_imps_this_week_adstocked_adstocked_decay_diminishing")]*output[paste0("cvr_", quo_name(channels_impressions[i]), "_this_week")]
      }
    }
  }

  if (length(channels_clicks) == 0) { # account for cases when no channels that use clicks are provided

  } else {
    for(i in 1:length(channels_clicks)){
      for(j in 1:nrow(output)) {
        output[,paste0("conv_", quo_name(channels_clicks[i]))] <-
          output[,paste0("sum_n_", quo_name(channels_clicks[i]), "_clicks_this_week_adstocked_adstocked_decay_diminishing")]*output[paste0("cvr_", quo_name(channels_clicks[i]), "_this_week")]
      }
    }
  }

  # return output

  print("You have completed running step 6: Calculating the number of conversions.")

  return(output)

}
