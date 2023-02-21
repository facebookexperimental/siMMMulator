# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 8 : Calculating ROI
#'
#' We calculate ROIs of each channel. These are the 'true ROIs' that we generated the data set with. We can use these to compare against the ROIs predicted from our MMM and see how close our MMM comes to these true ROIs.
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step7 A data frame that was created after running step 7.
#'
#' @return A list of ROIs for each channel
#' @export
#'
#' @examples
#' \dontrun{
#' step_8_calculate_roi(
#'  my_variables = my_variables,
#'  df_ads_step7 = df_ads_step7)
#' }

step_8_calculate_roi <- function(
  my_variables = my_variables,
  df_ads_step7 = df_ads_step7
) {

  # calculate inputs that we need
  years <- my_variables[[1]]
  channels_impressions <- my_variables[[2]]
  channels_clicks <- my_variables[[3]]
  frequency_of_campaigns <- my_variables[[4]]
  true_cvr <- my_variables[[5]]
  revenue_per_conversion <- my_variables[[6]]
  start_date <- my_variables[[7]]

  n_weeks <- years*52
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # set data frame to work with
  df_intermediary <- df_ads_step7

  # have a list that you can place ROIs into
  roi_list <- list()

  # calculate roi
  for(j in 1:length(channels)) {
    column_to_grab_conv <- paste0("conv_", quo_name(channels[j]))
    column_to_grab_spend <- paste0("spend_", quo_name(channels[j]))

    ## calculate total spend for channel over all data
    total_spend <- sum(df_ads_step7[, column_to_grab_spend])

    ## calculate total conversions for channel over all data
    total_conv <- sum(df_ads_step7[, column_to_grab_conv])

    ## calculate cost per conversion = total spend / total number of conversions
    cost_per_conv <- total_spend /  total_conv

    ## calculate ROI = (revenue per conversion - cost per conversion)/cost per conversion
    roi <- (revenue_per_conversion -  cost_per_conv)/ cost_per_conv
    roi_list[j] <- print(paste0("roi of ", quo_name(channels[j]), " is: ", roi))
  }


}
