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
  start_date <- my_variables[[7]]

  n_days <- years*365
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)


  # keep only variables that appear in final data frame
  df_mmm <- df_ads_step7 %>% select(c("DATE", "total_revenue"))

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


  # aggregate it up to a weekly data set
  df_mmm_weekly <- data.frame(
    DATE = seq(from = as.Date(start_date),
               to = as.Date(start_date) + n_days - 1,
               by = "1 week")
  )

  # aggregate up impressions to a weekly level
  if (length(channels_impressions) == 0) { # skip this step if no channels that use impressions were provided

  } else {
    for (j in 1:length(channels_impressions)) {

      index <- (1:7)

      for (i in 1:nrow(df_mmm_weekly)) {

        # make col names generalizable
        cols_to_summarize_imps <- names(df_mmm[grepl(paste0("impressions_", quo_name(channels_impressions[j])), names(df_mmm))])

        # this code summarizes the variables weekly
        df_mmm_weekly[i, cols_to_summarize_imps] <-
          sum(df_mmm[index, cols_to_summarize_imps])

        # run this at the very end to calculate the next week
        index <- index+7
      }

    }
  }


  # aggregate up spend on impression channels to a weekly level
  if (length(channels_impressions) == 0) { # skip this step if no channels that use clicks were provided

  } else {
    for (j in 1:length(channels_impressions)) {

      index <- (1:7)

      for (i in 1:nrow(df_mmm_weekly)) {

        # make col names generalizable
        cols_to_summarize_imps_spend <-   names(df_mmm[grepl(paste0("spend_", quo_name(channels_impressions[j])), names(df_mmm))])

        # this code summarizes the variables weekly
        df_mmm_weekly[i, cols_to_summarize_imps_spend] <-
          sum(df_mmm[index, cols_to_summarize_imps_spend])

        # run this at the very end to calculate the next week
        index <- index+7
      }

    }
  }



  # aggregate up clicks to a weekly level
  if (length(channels_clicks) == 0) { # skip this step if no channels that use clicks were provided

  } else {
    for (j in 1:length(channels_clicks)) {

      index <- (1:7)

      for (i in 1:nrow(df_mmm_weekly)) {

        # make col names generalizable
        cols_to_summarize_clicks <-   names(df_mmm[grepl(paste0("clicks_", quo_name(channels_clicks[j])), names(df_mmm))])

        # this code summarizes the variables weekly
        df_mmm_weekly[i, cols_to_summarize_clicks] <-
          sum(df_mmm[index, cols_to_summarize_clicks])

        # run this at the very end to calculate the next week
        index <- index+7
      }

    }
  }

  # aggregate up spend on clicks channels to a weekly level
  if (length(channels_clicks) == 0) { # skip this step if no channels that use clicks were provided

  } else {
    for (j in 1:length(channels_clicks)) {

      index <- (1:7)

      for (i in 1:nrow(df_mmm_weekly)) {

        # make col names generalizable
        cols_to_summarize_clicks_spend <-   names(df_mmm[grepl(paste0("spend_", quo_name(channels_clicks[j])), names(df_mmm))])

        # this code summarizes the variables weekly
        df_mmm_weekly[i, cols_to_summarize_clicks_spend] <-
          sum(df_mmm[index, cols_to_summarize_clicks_spend])

        # run this at the very end to calculate the next week
        index <- index+7
      }

    }
  }

  # total revenue
  index <- (1:7)
   for (i in 1:nrow(df_mmm_weekly)) {


      # this code summarizes the variables weekly
      df_mmm_weekly[i, "total_revenue"] <- sum(df_mmm[index, "total_revenue"])

      # run this at the very end to calculate the next week
      index <- index+7
    }


  # output

  print("You have completed running step 9: Creating the final data frame. You have completed the simulation and should have two data frames ready to be used in an MMM. These two data frames are stored in a list. The first data frame is at the daily level; the second data frame is at a weekly level.")

  list_of_df <- list(df_mmm, df_mmm_weekly)

  return(list_of_df)

}
