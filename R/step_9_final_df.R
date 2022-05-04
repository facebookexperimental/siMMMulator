# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 9 : Get Final Data Frame
#'
#' Keep only necessary variables for final data frame and format
#'
#' @return A data frame to use to put into an MMM
#' @export
#'
#' @examples
#' \dontrun{
#' step_9_final_df()
#' }

step_9_final_df <- function(){

  # calculate inputs that we need
  years <- .GlobalEnv$basic_vars[[1]]
  channels_impressions <- .GlobalEnv$basic_vars[[2]]
  channels_clicks <- .GlobalEnv$basic_vars[[3]]

  n_weeks <- years*52
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # keep only variables that appear in final data frame
  df_mmm <- .GlobalEnv$df_ads_step7 %>% select(c("DATE",
                                                  "total_revenue"))

  # list impression variables
  for(j in 1:length(channels_impressions)) {
    column_to_grab <- paste0("impressions_", quo_name(channels_impressions[j]))
    column_name_in_df_mmm <- paste0("impressions_", quo_name(channels_impressions[j]))
    df_mmm[,column_name_in_df_mmm] <-  .GlobalEnv$df_ads_step7[, column_to_grab]
  }

  # list click variables
  for(j in 1:length(channels_clicks)) {
    column_to_grab <- paste0("clicks_", quo_name(channels_clicks[j]))
    column_name_in_df_mmm <- paste0("clicks_", quo_name(channels_clicks[j]))
    df_mmm[,column_name_in_df_mmm] <-  .GlobalEnv$df_ads_step7[, column_to_grab]
  }

  # list spend variables
  for(j in 1:length(channels)) {
    column_to_grab <- paste0("spend_", quo_name(channels[j]))
    column_name_in_df_mmm <- paste0("spend_", quo_name(channels[j]))
    df_mmm[,column_name_in_df_mmm] <-  .GlobalEnv$df_ads_step7[, column_to_grab]
  }

  # output
  .GlobalEnv$df_final <- df_mmm

}
