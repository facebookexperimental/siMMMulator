# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 8 : Calculating ROI
#'
#' We calculate ROIs of each channel. These are the 'true ROIs' that we generated the data set with. We can use these to compare against the ROIs predicted from our MMM and see how close our MMM comes to these true ROIs.
#'
#' @return A list of ROIs for each channel
#' @export
#'
#' @examples
#' \dontrun{
#' step_8_calculate_roi()
#' }

step_8_calculate_roi <- function() {

  # calculate inputs that we need
  years <- .GlobalEnv$basic_vars[[1]]
  channels_impressions <- .GlobalEnv$basic_vars[[2]]
  channels_clicks <- .GlobalEnv$basic_vars[[3]]
  frequency_of_campaigns <- .GlobalEnv$basic_vars[[4]]
  true_cvr <- .GlobalEnv$basic_vars[[5]]
  revenue_per_conversion <- .GlobalEnv$basic_vars[[6]]

  n_weeks <- years*52
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # set data frame to work with
  df_intermediary <- .GlobalEnv$df_ads_step7

  # have a list that you can place ROIs into
  roi_list <- list()

  # calculate roi
  for(j in 1:length(channels)) {
    column_to_grab_conv <- paste0("conv_", quo_name(channels[j]))
    column_to_grab_spend <- paste0("spend_", quo_name(channels[j]))

    ## calculate total spend for channel over all data
    total_spend <- sum(.GlobalEnv$df_ads_step7[, column_to_grab_spend])

    ## calculate total conversions for channel over all data
    total_conv <- sum(.GlobalEnv$df_ads_step7[, column_to_grab_conv])

    ## calculate cost per conversion = total spend / total number of conversions
    cost_per_conv <- total_spend /  total_conv

    ## calculate ROI = (revenue per conversion - cost per conversion)/cost per conversion
    roi <- (revenue_per_conversion -  cost_per_conv)/ cost_per_conv
    roi_list[j] <- print(paste0("roi of ", quo_name(channels[j]), " is: ", roi))
  }

  # output
  .GlobalEnv$roi_list <- roi_list

}
