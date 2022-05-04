# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 6 : Calculating Conversions
#'
#' We calculate the number of conversions that occur each week and on each channel using the outputs from previous steps.
#'
#' @return A data frame with number of conversions on each channel
#' @export
#'
#' @examples
#' \dontrun{
#' step_6_calculating_conversions()
#' }
#'

step_6_calculating_conversions <- function(
)
{
  # calculate inputs that we need
  years <- .GlobalEnv$basic_vars[[1]]
  channels_impressions <- .GlobalEnv$basic_vars[[2]]
  channels_clicks <- .GlobalEnv$basic_vars[[3]]
  frequency_of_campaigns <- .GlobalEnv$basic_vars[[4]]
  true_cvr <- .GlobalEnv$basic_vars[[5]]

  n_weeks <- years*52
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # calculate conversions
  output <- .GlobalEnv$df_ads_step5c
  for(i in 1:length(channels_impressions)){
    for(j in 1:nrow(output)) {
      output[,paste0("conv_", quo_name(channels_impressions[i]))] <-
        output[,paste0("sum_n_", quo_name(channels_impressions[i]), "_imps_this_week_adstocked_adstocked_decay_diminishing")]*output[paste0("cvr_", quo_name(channels_impressions[i]), "_this_week")]
    }
  }
  for(i in 1:length(channels_clicks)){
    for(j in 1:nrow(output)) {
      output[,paste0("conv_", quo_name(channels_clicks[i]))] <-
        output[,paste0("sum_n_", quo_name(channels_clicks[i]), "_clicks_this_week_adstocked_adstocked_decay_diminishing")]*output[paste0("cvr_", quo_name(channels_clicks[i]), "_this_week")]
    }
  }

  # return output
  .GlobalEnv$df_ads_step6 <- output

}
