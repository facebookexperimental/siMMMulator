# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 7 : Expanded Data Frame
#'
#' We do final calculations for all the variables that we need for the final data frame.
#'
#' @return A data frame with all the variables we've calculated so far.
#' @importFrom dplyr rowwise
#' @importFrom tidyselect starts_with
#' @export
#'
#' @examples
#'  \dontrun{
#' step_7_expanded_df()
#'}

step_7_expanded_df <- function(
) {

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

  # initialize local variables to use later on
  total_conv_from_ads <- NA
  revenue_from_ads <- NA
  baseline_revenue <- NA

  # start final data frame
  df_mmm <- data.frame(
    DATE = seq(from = as.Date("2017/1/1"),
               to = as.Date("2017/1/1") + (n_weeks*7) - (n_weeks/52),
               by = "1 week")
  )

  # input in media variables into final data frame
  ## impressions
  for(j in 1:length(channels_impressions)) {
    column_to_grab <- paste0("sum_n_", quo_name(channels_impressions[j]), "_imps_this_week")
    column_name_in_df_mmm <- paste0("impressions_", quo_name(channels_impressions[j]))
    df_mmm[,column_name_in_df_mmm] <-  .GlobalEnv$df_ads_step6[, column_to_grab]
  }
  ## clicks
  for(j in 1:length(channels_clicks)) {
    column_to_grab <- paste0("sum_n_", quo_name(channels_clicks[j]), "_clicks_this_week")
    column_name_in_df_mmm <- paste0("clicks_", quo_name(channels_clicks[j]))
    df_mmm[,column_name_in_df_mmm] <-  .GlobalEnv$df_ads_step6[, column_to_grab]
  }

  # input in spend variables into final data frame
  for(j in 1:length(channels)) {
    column_to_grab <- paste0("sum_spend_", quo_name(channels[j]), "_this_week")
    column_name_in_df_mmm <- paste0("spend_", quo_name(channels[j]))
    df_mmm[,column_name_in_df_mmm] <-  .GlobalEnv$df_ads_step6[, column_to_grab]
  }

  # input in conversions from marketing
  ## individual channel's conversions
  column_names_to_sum <- colnames(.GlobalEnv$df_ads_step6[, grep("conv_",names(.GlobalEnv$df_ads_step6))])
  for(j in 1:length(channels)) {
    df_mmm[,column_names_to_sum[j]] <-  .GlobalEnv$df_ads_step6[, column_names_to_sum[j]]
  }
  ## sum across the multiple columns
  df_mmm <- df_mmm %>% rowwise() %>%   mutate(total_conv_from_ads = sum(across(starts_with("conv_"))))

  # calculate revenue per conversion
  df_mmm <- df_mmm %>% mutate(revenue_from_ads = total_conv_from_ads*revenue_per_conversion)

  # calculate total revenue by adding it to baseline revenue
  ## get baseline revenue into data frame
  df_mmm[, "baseline_revenue"] <- .GlobalEnv$df_baseline$baseline_sales
  ## add baseline sales to sales from ads
  df_mmm <- df_mmm %>% mutate(total_revenue = revenue_from_ads + baseline_revenue)

  # output
  .GlobalEnv$df_ads_step7 <- df_mmm

}
