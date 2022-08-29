# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 9 : Get Final Data Frame
#'
#' Keep only necessary variables for final data frame and format
#'
#'@param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step7 A data frame that was created after running step 7.
#'
#' @return A data frame to use to put into an MMM
#' @export
#'
#' @examples
#' \dontrun{
#' step_9_final_df(
#'   my_variables = my_variables,
#'   df_ads_step7 = df_ads_step7
#'   )
#' }

step_9_final_df <- function(
  my_variables = my_variables,
  df_ads_step7 = df_ads_step7
){

  # calculate inputs that we need
  years <- my_variables[[1]]
  channels_impressions <- my_variables[[2]]
  channels_clicks <- my_variables[[3]]

  n_weeks <- years*52
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # keep only variables that appear in final data frame
  df_mmm <- df_ads_step7 %>% select(c("DATE",
                                                 "total_revenue"))

  # list impression variables
  if (length(channels_impressions) == 0) { # account for cases when no channels using impressions were provided

  } else {
    for(j in 1:length(channels_impressions)) {
      column_to_grab <- paste0("impressions_", quo_name(channels_impressions[j]))
      column_name_in_df_mmm <- paste0("impressions_", quo_name(channels_impressions[j]))
      df_mmm[,column_name_in_df_mmm] <-  df_ads_step7[, column_to_grab]
    }
  }

  # list click variables
  if (length(channels_clicks) == 0 ) { # account for cases when no channels using clicks were provided

  } else {
    for(j in 1:length(channels_clicks)) {
      column_to_grab <- paste0("clicks_", quo_name(channels_clicks[j]))
      column_name_in_df_mmm <- paste0("clicks_", quo_name(channels_clicks[j]))
      df_mmm[,column_name_in_df_mmm] <-  df_ads_step7[, column_to_grab]
    }
  }

  # list spend variables
  for(j in 1:length(channels)) {
    column_to_grab <- paste0("spend_", quo_name(channels[j]))
    column_name_in_df_mmm <- paste0("spend_", quo_name(channels[j]))
    df_mmm[,column_name_in_df_mmm] <-  df_ads_step7[, column_to_grab]
  }

  # output

  print("You have completed running step 9: Creating the final data frame. You have completed the simulation and should have a data frame ready to be used in an MMM.")

  return(df_mmm)

}
