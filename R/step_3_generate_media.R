# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 3 : Generate Media Variables
#'
#' This step generates media activity using spend from Step 2.
#'
#' @param true_cpm A vector of numbers specifying the true Cost per Impression (CPM) of each channel (noise will be added to this to simulate number of impressions), length MUST equal to the number of TOTAL channels, if channels do not use impressions to measure activity, then put NA, must be in same order as channels specified (put channels that use impressions first, followed by channels that use clicks)
#' @param true_cpc A vector of numbers specifying the true Cost per Click (CPC) of each channel (noise will be added to this to simulate number of clicks), length MUST equal to the number of TOTAL channels, if channels do not use clicks to measure activity, then put NA, must be in same order as channels specified (put channels that use impressions first, followed by channels that use clicks)
#' @param mean_noisy_cpm_cpc A vector of numbers with mean of normal distribution that generates noise to CPM or CPC, vector with length equal to number of channels, must be in same order as channels specified (put channels that use impressions first, followed by channels that use clicks)
#' @param std_noisy_cpm_cpc A vector of numbers with standard deviation of normal distribution that generates noise to CPM or CPC, vector with length equal to number of channels, must be in same order as channels specified (put channels that use impressions first, followed by channels that use clicks)
#'
#' @return A data frame with activity for media channels

#' @importFrom dplyr case_when
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom rlang :=
#' @importFrom rlang quo_name
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' step_3_generate_media(
#' true_cpm = c(2, 20, 10, NA),
#' true_cpc = c(NA, NA, NA, 1),
#' mean_noisy_cpm_cpc = c(0, 0.05, 0.1, 0.02),
#' std_noisy_cpm_cpc = c(0.1, 0.15, 0.2, 0.03)
#' )
#' }

step_3_generate_media <- function(true_cpm, # true CPM should be a vector equal to the number of TOTAL channels, if channels do not use impressions, then put NA
                                  true_cpc, # true CPC should be a vector equal to the number of TOTAL channels, if channels do not use clicks, then put NA
                                  mean_noisy_cpm_cpc, # mean of normal distribution that generates noise to CPM or CPC, vector with length equal to number of channels
                                  std_noisy_cpm_cpc # std of normal distribution that generates noise to CPM or CPC, vector with length equal to number of channels
)
{

  # calculate inputs needed based on what we already put in
  years <- .GlobalEnv$basic_vars[[1]]
  channels_impressions <- .GlobalEnv$basic_vars[[2]]
  channels_clicks <- .GlobalEnv$basic_vars[[3]]
  frequency_of_campaigns <- .GlobalEnv$basic_vars[[4]]

  channels <- c(channels_impressions, channels_clicks)
  n_channels <- length(channels)
  n_weeks <- years*52

  # Display error messages for invalid inputs
  if (typeof(true_cpm) != "double") stop("You did not enter a number for true_cpm. Must enter a numeric." ) # error if incorrect variable type for true_cpm
  if (typeof(true_cpc) != "double") stop("You did not enter a number for true_cpc. Must enter a numeric." ) # error if incorrect variable type for true_cpc
  if (typeof(mean_noisy_cpm_cpc) != "double") stop("You did not enter a number in mean_noisy_cpm_cpc. Must enter a numeric." ) # error if incorrect variable type for mean_noisy_cpm_cpc
  if (typeof(std_noisy_cpm_cpc) != "double") stop("You did not enter a number in std_noisy_cpm_cpc. Must enter a numeric." ) # error if incorrect variable type for std_noisy_cpm_cpc

  if (length(true_cpm)!= (length(c(channels_impressions, channels_clicks)))) stop("Did not input in enough numbers for true_cpm. Must have a value specified for each channel. If a channel doesn't use impressions, put NA in its place.") # error if not enough true_cpm are supplied
  if (length(true_cpc)!= (length(c(channels_impressions, channels_clicks)))) stop("Did not input in enough numbers for true_cpc. Must have a value specified for each channel. If a channel doesn't use clicks, put NA in its place.") # error if not enough true_cpc are supplied
  if (length(mean_noisy_cpm_cpc)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(mean_noisy_cpm_cpc)) == TRUE)) stop("Did not input in enough numbers for mean_noisy_cpm_cpc. Must have a value specified for each channel.") # error if not enough mean_noisy_cpm_cpc are supplied
  if (length(std_noisy_cpm_cpc)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(std_noisy_cpm_cpc)) == TRUE)) stop("Did not input in enough numbers for std_noisy_cpm_cpc. Must have a value specified for each channel.") # error if not enough std_noisy_cpm_cpc are supplied

  if ((any(true_cpm < 0, na.rm = TRUE)) | (any(is.na(true_cpm)) == FALSE)) stop('You entered a negative CPM. Enter a positive number.') # error if negative true_cpm
  if ((any(true_cpc < 0, na.rm = TRUE)) | (any(is.na(true_cpc)) == FALSE)) stop('You entered a negative CPC. Enter a positive number.') # error if negative true_cpc


  # initialize local variables to use later on
  spend_channel <- NA

  # add noise to the true CPM or CPC
  noisy_cpm <- true_cpm + rnorm(nrow(.GlobalEnv$df_ads_step2), mean = mean_noisy_cpm_cpc, sd = std_noisy_cpm_cpc)
  noisy_cpc <- true_cpc + rnorm(nrow(.GlobalEnv$df_ads_step2), mean = mean_noisy_cpm_cpc, sd = std_noisy_cpm_cpc)

  # add our work to the data frame from first step
  df_ads_step3_intermediate <- cbind(.GlobalEnv$df_ads_step2, true_cpm, noisy_cpm, true_cpc, noisy_cpc) %>%
    mutate(lifetime_impressions = (spend_channel / noisy_cpm) * 1000) %>% # calculate impressions directly from the noisy CPM
    mutate(lifetime_clicks = spend_channel / noisy_cpc) # calculate clicks directly from the noisy CPC

  # spread out impressions uniformly over length of campaign
  for (p in 1:nrow(df_ads_step3_intermediate)){
    for (j in 1:length(channels_impressions)) {
      for (n in 1:frequency_of_campaigns) {
        df_ads_step3_intermediate <- df_ads_step3_intermediate %>% mutate(
          !!paste0("impressions_", quo_name(channels_impressions[j]), "_after_running_week_", {n}) := case_when(
            channel == channels_impressions[j] ~ lifetime_impressions/frequency_of_campaigns, # uniform distribution
          )
        )
      }
    }
  }

  # spread out clicks uniformly over length of campaign
  for (p in 1:nrow(df_ads_step3_intermediate)){
    for (j in 1:length(channels_clicks)) {
      for (n in 1:frequency_of_campaigns) {
        df_ads_step3_intermediate <- df_ads_step3_intermediate %>% mutate(
          !!paste0("clicks_", quo_name(channels_clicks[j]), "_after_running_week_", {n}) := case_when(
            channel == channels_clicks[j] ~ lifetime_clicks/frequency_of_campaigns, # uniform distribution
          )
        )
      }
    }
  }

  # spread out spend uniformly over length of campaign
  for (p in 1:nrow(df_ads_step3_intermediate)){
    for (j in 1:length(channels)) {
      for (n in 1:frequency_of_campaigns) {
        df_ads_step3_intermediate <- df_ads_step3_intermediate %>% mutate(
          !!paste0("spend_", quo_name(channels[j]), "_after_running_week_", {n}) := case_when(
            channel == channels[j] ~ spend_channel/frequency_of_campaigns, # uniform distribution
          )
        )
      }
    }
  }

  # generate output of this function
  output <- df_ads_step3_intermediate

  .GlobalEnv$df_ads_step3 <- output ## Save to Global Environment

}
