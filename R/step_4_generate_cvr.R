# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 4 : Generate Noisy CVRs
#'
#' Generate noise around CVRs that user inputs for each channel
#'
#' @param mean_noisy_cvr A vector of numbers specifying the mean of the normal distribution used to add noise to conversion rates (CVR) of each channel, vector must be in the same order as channels specified (first channels that use impressions as a metric of activity, then channels that use clicks), must have length equal to number of total channels
#' @param std_noisy_cvr A vector of numbers specifying the standard deviation of the normal distribution used to add noise to conversion rates (CVR) of each channel, vector must be in the same order as channels specified (first channels that use impressions as a metric of activity, then channels that use clicks), must have length equal to number of total channels
#'
#' @return A data frame with noisy conversion rates for each channel and campaign
#'
#' @importFrom dplyr case_when
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom msm rtnorm
#' @importFrom rlang :=
#' @importFrom rlang quo_name
#'
#' @export
#'
#' @examples
#' \dontrun{
#' step_4_generate_cvr(
#' mean_noisy_cvr = c(0, 0.0001, 0.0002, 0.0005),
#' std_noisy_cvr = c(0.001, 0.002, 0.0001, 0.006))
#' }

step_4_generate_cvr <- function(
  mean_noisy_cvr, # a vector with length equivalent to the number of channels and in same order as true_cvr
  std_noisy_cvr # a vector with lenth equivalent to the number of channels and in same order as true_cvr
)
{

  # get inputs needed from data set
  years <- .GlobalEnv$basic_vars[[1]]
  channels_impressions <- .GlobalEnv$basic_vars[[2]]
  channels_clicks <- .GlobalEnv$basic_vars[[3]]
  frequency_of_campaigns <- .GlobalEnv$basic_vars[[4]]
  true_cvr <- .GlobalEnv$basic_vars[[5]]

  channels <- c(channels_impressions, channels_clicks)
  n_channels = length(channels)
  n_weeks <- years*52

  # Error messages for invalid user inputs
  if (typeof(mean_noisy_cvr) != "double") stop("You did not enter a number in mean_noisy_cvr. Must enter a numeric." ) # error if incorrect variable type for mean_noisy_cvr
  if (typeof(std_noisy_cvr) != "double") stop("You did not enter a number in std_noisy_cvr. Must enter a numeric." ) # error if incorrect variable type for std_noisy_cvr

  if (length(mean_noisy_cvr)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(mean_noisy_cvr)) == TRUE)) stop("Did not input in enough numbers for mean_noisy_cvr. Must have a value specified for each channel.") # error if not enough mean_noisy_cvr are supplied
  if (length(std_noisy_cvr)!= (length(c(channels_impressions, channels_clicks))) | (any(is.na(std_noisy_cvr)) == TRUE)) stop("Did not input in enough numbers for std_noisy_cvr. Must have a value specified for each channel.") # error if not enough std_noisy_cvr are supplied

  # generate noise around true CPIC
  noisy_cvr <- true_cvr + rtnorm(nrow(.GlobalEnv$df_ads_step3), mean = mean_noisy_cvr, sd = std_noisy_cvr, lower = -true_cvr, upper = Inf) # we use rtnorm to avoid getting a conversion rate less than 0, drawing from truncated normal distribution

  # add our work to the data frame from first step
  df_ads_step4_intermediate <- cbind(.GlobalEnv$df_ads_step3, true_cvr, noisy_cvr)

  # cvr remains same each week of campaign
  for (p in 1:nrow(df_ads_step4_intermediate)){
    for (j in 1:length(channels)) {
      for (n in 1:frequency_of_campaigns) {
        df_ads_step4_intermediate <- df_ads_step4_intermediate %>% mutate(
          !!paste0("noisy_cvr_", quo_name(channels[j]), "_after_running_week_", {n}) := case_when(
            channel == channels[j] ~ noisy_cvr # uniform distribution
          )
        )
      }
    }
  }

  # output
  output <- df_ads_step4_intermediate
  .GlobalEnv$df_ads_step4 <- output

}
