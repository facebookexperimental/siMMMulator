# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 7 : Expanded Data Frame
#'
#' We do final calculations for all the variables that we need for the final data frame.
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step6 A data frame that was created after running step 6.
#' @param df_baseline A data frame that was created after running step 1.
#'
#' @return A data frame with all the variables we've calculated so far.
#' @importFrom dplyr rowwise
#' @importFrom tidyselect starts_with
#' @export
#'
#' @examples
#'  \dontrun{
#' step_7_expanded_df(
#'   my_variables = my_variables,
#'   df_ads_step6 = df_ads_step6,
#'   df_baseline = df_baseline
#'   )
#'}

step_7_expanded_df <- function(
  my_variables = my_variables,
  df_ads_step6 = df_ads_step6,
  df_baseline = df_baseline
) {

  # calculate inputs that we need
  years <- my_variables[[1]]
  channels_impressions <- my_variables[[2]]
  channels_clicks <- my_variables[[3]]
  frequency_of_campaigns <- my_variables[[4]]
  true_cvr <- my_variables[[5]]
  revenue_per_conversion <- my_variables[[6]]
  start_date <- my_variables[[7]]

  n_days <- years*365
  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)

  # initialize local variables to use later on
  total_conv_from_ads <- NA
  revenue_from_ads <- NA
  baseline_revenue <- NA

  ## daily data
  # start final data frame
  df_mmm <- data.frame(
    DATE = seq(from = as.Date(start_date),
               to = as.Date(start_date) + n_days - 1,
               by = "1 day")
  )

  # input in media variables into final data frame
  ## impressions

  if (length(channels_impressions) == 0 ) { # account for cases when no channels using impressions are provided

  } else {
    for(j in 1:length(channels_impressions)) {
      column_to_grab <- paste0("sum_n_", quo_name(channels_impressions[j]), "_imps_this_day")
      column_name_in_df_mmm <- paste0("impressions_", quo_name(channels_impressions[j]))
      df_mmm[,column_name_in_df_mmm] <-  df_ads_step6[, column_to_grab]
    }
  }


  ## clicks
  if (length(channels_clicks) == 0 ) { # account for cases when no channels using clicks are provided

  } else {
    for(j in 1:length(channels_clicks)) {
      column_to_grab <- paste0("sum_n_", quo_name(channels_clicks[j]), "_clicks_this_day")
      column_name_in_df_mmm <- paste0("clicks_", quo_name(channels_clicks[j]))
      df_mmm[,column_name_in_df_mmm] <-  df_ads_step6[, column_to_grab]
    }
  }

  # input in spend variables into final data frame
  for(j in 1:length(channels)) {
    column_to_grab <- paste0("sum_spend_", quo_name(channels[j]), "_this_day")
    column_name_in_df_mmm <- paste0("spend_", quo_name(channels[j]))
    df_mmm[,column_name_in_df_mmm] <-  df_ads_step6[, column_to_grab]
  }

  # input in conversions from marketing
  ## individual channel's conversions
  column_names_to_sum <- colnames(df_ads_step6[, grep("conv_",names(df_ads_step6))])
  for(j in 1:length(channels)) {
    df_mmm[,column_names_to_sum[j]] <-  df_ads_step6[, column_names_to_sum[j]]
  }
  ## sum across the multiple columns
  df_mmm <- df_mmm %>% rowwise() %>%   mutate(total_conv_from_ads = sum(across(starts_with("conv_"))))

  # calculate revenue per conversion
  df_mmm <- df_mmm %>% mutate(revenue_from_ads = total_conv_from_ads*revenue_per_conversion)

  # calculate total revenue by adding it to baseline revenue
  ## get baseline revenue into data frame
  df_mmm[, "baseline_revenue"] <- df_baseline$baseline_sales
  ## add baseline sales to sales from ads
  df_mmm <- df_mmm %>% mutate(total_revenue = revenue_from_ads + baseline_revenue)






  # output

  print("You have completed running step 7: Expanding to maximum data frame.")

  return(df_mmm)


}
