# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 2: Generate Ad Spend
#'
#' Simulates how much to spend on each ad campaign and channel
#'
#' @param my_variables A list that was created after running step 0. It stores the inputs you've specified.
#' @param campaign_spend_mean A numeric, the average amount of money spent on a campaign, must be in same currency as baseline sales generated in step 1
#' @param campaign_spend_std A numeric, the standard deviation of money spent on a campaign, must be in same currency as baseline sales generated in step 1
#' @param max_min_proportion_on_each_channel A vector of numerics specifying the minimum and maximum percentages of total spend allocated to each channel, should be in the same order as channels specified (channels that use impressions first followed by channels that use clicks), length should be 2 times (number of total channels - 1)
#'
#' @return A data frame with amounts of money spent on each campaign and media channel
#'
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom stats runif
#'
#' @export
#'
#' @examples
#' \dontrun{
#' step_2_ads_spend(
#' my_variables = my_variables,
#' campaign_spend_mean = 329000,
#' campaign_spend_std = 100000,
#' max_min_proportion_on_each_channel <- c(0.45, 0.55,
#' 0.15, 0.25,
#' 0.1, 0.2)
#' )
#' }

step_2_ads_spend <- function(my_variables = my_variables,
                             campaign_spend_mean, # mean of campaign spends for normal distribution
                             campaign_spend_std, # standard deviation of campaign spends for normal distribution
                             max_min_proportion_on_each_channel # vector of min and max proportions of spend for each channel in order that channel_impressions and channel_clicks were identified
){


  # calculate some variables to be used in input of data frame
  years <- my_variables[[1]]
  channels_impressions <- my_variables[[2]]
  channels_clicks <- my_variables[[3]]
  frequency_of_campaigns <- my_variables[[4]]

  channels <- c(channels_impressions, channels_clicks)
  channels <- channels[!is.na(channels)] # only keep the non-NA channels
  n_channels <- length(channels)
  n_weeks <- years*52
  n_campaigns <- n_weeks/frequency_of_campaigns

  # Display error messages for invalid inputs
  if (typeof(campaign_spend_mean) != "double") stop("You did not enter a number for campaign_spend_mean. Must enter a numeric." ) # error if incorrect variable type for campaign_spend_mean
  if (typeof(campaign_spend_std) != "double") stop("You did not enter a number for campaign_spend_std. Must enter a numeric." ) # error if incorrect variable type for campaign_spend_std
  if (typeof(max_min_proportion_on_each_channel) != "double") stop("You did not enter a number in max_min_proportion_on_each_channel. Must enter a numeric." ) # error if incorrect variable type for max_min_proportion_on_each_channel
  if (campaign_spend_mean < 0) stop('You entered a negative average campaign spend. Enter a positive number.') # error if negative average campaign spend
  if (length(max_min_proportion_on_each_channel)!= ((sum(!is.na(channels_impressions)) + sum(!is.na(channels_clicks)))*2 - 2) | (any(is.na(max_min_proportion_on_each_channel)) == TRUE)) stop("Did not input in enough numbers or put in too many numbers for proportion of spends on each channel. Must have a maximum and minimum percentage specified for all channels except the last channel, which will be auto calculated as any remaining amount.") # error if not enough conversion rates are supplied
  if (ifelse(all(max_min_proportion_on_each_channel > 0), TRUE, FALSE) == FALSE) stop("You entered a negative proportion of spend on a channel. Enter a proportion between 0 and 1") # error if any proportion of spend on a channel entered are less than 0
  if (ifelse(all(max_min_proportion_on_each_channel <= 1), TRUE, FALSE) == FALSE) stop("You entered a proportion of spend on a channel greater than 1. Enter a proportion rate between 0 and 1.") # error if any proportion of spend on a channel are greater than 1

  # initialize local variables to use later on
  total_campaign_spend <- NA
  channel_prop_spend <- NA
  channel_prop_spend <- NA
  total_campaign_spend <- NA

  # specify amount spent on each campaign according to a normal distribution
  campaign_spends <- rnorm(n_campaigns, mean = campaign_spend_mean, sd = campaign_spend_std)


  # if campaign spend number is negative, automatically make it 0
  campaign_spends[campaign_spends<0] <- 0


  # specify the amount spend on each channel for each campaign
  ## proportions spent on each channel are randomly generated proportions drawn from a uniform distribution of numbers between inputs user identifies
  proportion_strings_list <- vector(mode = "list", length = n_campaigns)
  for(i in 1:n_campaigns) { # replace 1 with n_campaigns
    total_proportion_campaign <- 0
    for (j in 1:(n_channels-1)) {
      proportion_strings_list[[i]][j] <- runif(1, min = max_min_proportion_on_each_channel[(2*j)-1], max = max_min_proportion_on_each_channel[2*j])
      total_proportion_campaign <- total_proportion_campaign + proportion_strings_list[[i]][j]
    }
    proportion_strings_list[[i]][n_channels] <- 1 - total_proportion_campaign
  }


  ## output
  output <- data.frame(campaign_id = rep(1:n_campaigns, each = n_channels),
                       channel = rep(channels, n_campaigns),
                       total_campaign_spend = rep(campaign_spends, each = n_channels),
                       channel_prop_spend = unlist(proportion_strings_list, use.names = FALSE)) %>%
    mutate(spend_channel = total_campaign_spend*channel_prop_spend) # calculate the spend on each channel

  print("You have completed running step 2: Simulating ad spend.")

  return(output)


}
