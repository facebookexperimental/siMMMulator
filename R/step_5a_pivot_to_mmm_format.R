# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 5a: Pivot from Our campaign + channel format to a weekly format
#'
#' We pivot our table from Step 4 (which was on a campaign + channel format) to a weekly format.
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param df_ads_step4 A data frame that was created after running step 4.
#'
#' @return A data frame with media variables, media spend
#'
#' @name step_5a_pivot_to_mmm_format
#'
#' @importFrom dplyr across
#' @importFrom dplyr group_by
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom dplyr summarise_at
#' @importFrom magrittr %>%
#' @importFrom rlang quo_name
#' @importFrom rlang :=
#' @importFrom tidyselect all_of
#'
#' @export
#' @examples
#' \dontrun{
#'step_5a_pivot_to_mmm_format(
#'my_variables = my_variables,
#'df_ads_step4 = df_ads_step4)
#' }

utils::globalVariables("where")

step_5a_pivot_to_mmm_format <- function(my_variables = my_variables,
                                        df_ads_step4 = df_ads_step4
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

  # initialize local variables to use later on
  campaign_id <- NA
  . <- NA

  # set up rows to get an intermediate data frame
  df_ads_step5a_before_mmm <- data.frame(
    DATE = seq(from = as.Date("2017/1/1"),
               to = as.Date("2017/1/1") + (n_weeks*7) - (n_weeks/52),
               by = "1 week")
  )

  # for impressions, pivot into a weekly format
  if (length(channels_impressions) == 0) { # skip this step if no channels that use clicks were provided

  } else {
    for (j in 1:length(channels_impressions)) {
      cols_to_summarize_imps <-   names(df_ads_step4[grepl(paste0("impressions_", quo_name(channels_impressions[j]), "_after_running_week_"), names(df_ads_step4))])
      df_no_channel_imps <- df_ads_step4 %>%
        select(c(campaign_id, all_of(cols_to_summarize_imps))) %>%
        replace(is.na(.), 0) %>% # fill all the NAs with 0 so that we can do some math
        group_by(campaign_id) %>%
        summarise_at(.vars = cols_to_summarize_imps, .funs =sum) ## this will become useful later when we need to generalize
      #### pivot the data and cbind onto the date dataframe
      campaign_ids <- paste0("campaign_", df_no_channel_imps$campaign_id)
      df_no_channel_imps <- as.data.frame(t(df_no_channel_imps[,-1]))
      colnames(df_no_channel_imps) <- campaign_ids

      #### shift values down the appropriate number of weeks from when data start that campaign starts
      #### add empty rows to data set so that we can shift downwards
      df_no_channel_imps[nrow(df_no_channel_imps)+1:(n_weeks-frequency_of_campaigns),] <- NA
      ##### shift
      for(i in 1:ncol(df_no_channel_imps)) {
        df_no_channel_imps[,i] <- data.table::shift(df_no_channel_imps[,i],
                                                    n = (frequency_of_campaigns*i)-frequency_of_campaigns,
                                                    fill = NA,
                                                    type = 'lag')
      }
      df_no_channel_imps <- df_no_channel_imps %>%
        replace(is.na(.), 0) %>%
        mutate(!!paste0("sum_n_", quo_name(channels_impressions[j]), "_this_week") := rowSums(across(where(is.numeric))))
      # input in our results from earlier
      df_ads_step5a_before_mmm[,paste0("sum_n_", quo_name(channels_impressions[j]), "_imps_this_week")] <- df_no_channel_imps[,paste0("sum_n_", quo_name(channels_impressions[j]), "_this_week")]
    }
  }

  # for clicks, pivot into a weekly format
  if (length(channels_clicks) == 0) { # skip this step if no channels that use clicks were provided

  } else {
    for (j in 1:length(channels_clicks)) {
      cols_to_summarize_clicks <-   names(df_ads_step4[grepl(paste0("clicks_", quo_name(channels_clicks[j]), "_after_running_week_"), names(df_ads_step4))])
      df_no_channel_clicks <- df_ads_step4 %>%
        select(c(campaign_id, all_of(cols_to_summarize_clicks))) %>%
        replace(is.na(.), 0) %>% # fill all the NAs with 0 so that we can do some math
        group_by(campaign_id) %>%
        summarise_at(.vars = cols_to_summarize_clicks, .funs =sum) ## this will become useful later when we need to generalize
      #### pivot the data and cbind onto the date dataframe
      campaign_ids <- paste0("campaign_", df_no_channel_clicks$campaign_id)
      df_no_channel_clicks <- as.data.frame(t(df_no_channel_clicks[,-1]))
      colnames(df_no_channel_clicks) <- campaign_ids

      #### shift values down the appropriate number of weeks from when data start that campaign starts
      #### add empty rows to data set so that we can shift downwards
      df_no_channel_clicks[nrow(df_no_channel_clicks)+1:(n_weeks-frequency_of_campaigns),] <- NA
      ##### shift
      for(i in 1:ncol(df_no_channel_clicks)) {
        df_no_channel_clicks[,i] <- data.table::shift(df_no_channel_clicks[,i],
                                                      n = (frequency_of_campaigns*i)-frequency_of_campaigns,
                                                      fill = NA,
                                                      type = 'lag')
      }
      df_no_channel_clicks <- df_no_channel_clicks %>%
        replace(is.na(.), 0) %>%
        mutate(!!paste0("sum_n_", quo_name(channels_clicks[j]), "_this_week") := rowSums(across(where(is.numeric))))
      # input in our results from earlier
      df_ads_step5a_before_mmm[,paste0("sum_n_", quo_name(channels_clicks[j]), "_clicks_this_week")] <- df_no_channel_clicks[,paste0("sum_n_", quo_name(channels_clicks[j]), "_this_week")]
    }
  }

  # for spend, pivot into a weekly format
  for (j in 1:length(channels)) {
    cols_to_summarize_spend <-   names(df_ads_step4[grepl(paste0("spend_", quo_name(channels[j]), "_after_running_week_"), names(df_ads_step4))])
    df_no_channel <- df_ads_step4 %>%
      select(c(campaign_id, all_of(cols_to_summarize_spend))) %>%
      replace(is.na(.), 0) %>% # fill all the NAs with 0 so that we can do some math
      group_by(campaign_id) %>%
      summarise_at(.vars = cols_to_summarize_spend, .funs =sum) ## this will become useful later when we need to generalize
    #### pivot the data and cbind onto the date dataframe
    campaign_ids <- paste0("campaign_", df_no_channel$campaign_id)
    df_no_channel <- as.data.frame(t(df_no_channel[,-1]))
    colnames(df_no_channel) <- campaign_ids

    #### shift values down the appropriate number of weeks from when data start that campaign starts
    #### add empty rows to data set so that we can shift downwards
    df_no_channel[nrow(df_no_channel)+1:(n_weeks-frequency_of_campaigns),] <- NA
    ##### shift
    for(i in 1:ncol(df_no_channel)) {
      df_no_channel[,i] <- data.table::shift(df_no_channel[,i],
                                             n = (frequency_of_campaigns*i)-frequency_of_campaigns,
                                             fill = NA,
                                             type = 'lag')
    }
    df_no_channel <- df_no_channel %>%
      replace(is.na(.), 0) %>%
      mutate(!!paste0("sum_n_", quo_name(channels[j]), "_this_week") := rowSums(across(where(is.numeric))))
    # input in our results from earlier
    df_ads_step5a_before_mmm[,paste0("sum_spend_", quo_name(channels[j]), "_this_week")] <- df_no_channel[,paste0("sum_n_", quo_name(channels[j]), "_this_week")]
  }

  # add noisy CVR to the dataframe
  for (j in 1:length(channels)) {
    cols_to_summarize_cvr <-   names(df_ads_step4[grepl(paste0("noisy_cvr_", quo_name(channels[j]), "_after_running_week_"), names(df_ads_step4))])
    df_no_channel_cvr <- df_ads_step4 %>%
      select(c(campaign_id, all_of(cols_to_summarize_cvr))) %>%
      replace(is.na(.), 0) %>% # fill all the NAs with 0 so that we can do some math
      group_by(campaign_id) %>%
      summarise_at(.vars = cols_to_summarize_cvr, .funs =sum) ## this will become useful later when we need to generalize
    #### pivot the data and cbind onto the date dataframe
    campaign_ids <- paste0("campaign_", df_no_channel_cvr$campaign_id)
    df_no_channel_cvr <- as.data.frame(t(df_no_channel_cvr[,-1]))
    colnames(df_no_channel_cvr) <- campaign_ids

    #### shift values down the appropriate number of weeks from when data start that campaign starts
    #### add empty rows to data set so that we can shift downwards
    df_no_channel_cvr[nrow(df_no_channel_cvr)+1:(n_weeks-frequency_of_campaigns),] <- NA
    ##### shift
    for(i in 1:ncol(df_no_channel_cvr)) {
      df_no_channel_cvr[,i] <- data.table::shift(df_no_channel_cvr[,i],
                                                 n = (frequency_of_campaigns*i)-frequency_of_campaigns,
                                                 fill = NA,
                                                 type = 'lag')
    }
    df_no_channel_cvr <- df_no_channel_cvr %>%
      replace(is.na(.), 0) %>%
      mutate(!!paste0("cvr_", quo_name(channels[j]), "_this_week") := rowSums(across(where(is.numeric))))
    # input in our results from earlier
    df_ads_step5a_before_mmm[,paste0("cvr_", quo_name(channels[j]), "_this_week")] <- df_no_channel_cvr[,paste0("cvr_", quo_name(channels[j]), "_this_week")]
  }

  # output of function
  output <- df_ads_step5a_before_mmm

  print("You have completed running step 5a: pivoting the data frame to an MMM format.")

  return(output)

}
