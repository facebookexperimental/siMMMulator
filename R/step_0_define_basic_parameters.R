# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' Step 0 : Define Basic Parameters
#'
#' User inputs basic parameters that will be used in subsequent steps to simulate the data set, exists so that user does not have to keep inputting them. The parameters here initialize some variables in the user's environment.
#'
#' @param years A number, number of years you want to generate weekly data for. Must be a whole number and equal to or greater than 1.
#' @param channels_impressions A vector of character strings, names of media channels that use impressions as their metric of activity (Examples: Facebook, TV, Long-Form Video), must be in vector format with strings. Do not provide if not applicable to you.
#' @param channels_clicks A vector of character strings, names of media channels that use clicks as their metric of activity (Examples: Search), must be in vector format with strings. Do not provide if not applicable to you.
#' @param frequency_of_campaigns A number, how often campaigns occur (for example, frequency of 2 would yield a new campaign every 2 weeks with each campaign lasting 2 weeks). Must be a whole number greater than or equal to 1.
#' @param true_cvr A vector of numbers, what the underlying conversion rates of all the channels are, statistical noise will be added on top of this, should be a vector of numbers between 0 and 1 in the SAME order as how channels were specified (channels that use impressions first, followed by channels that use clicks), must have same length as number of channels
#' @param revenue_per_conv A number, How much money we make from a conversion (i.e. profit from a unit of sale). Must be a number greater than 0.
#'
#' @return A list (in users' global environment) of variables the user has input
#' @export
#'
#' @examples
#' step_0_define_basic_parameters(years = 5,
#' channels_impressions = c("Facebook", "TV", "Long-Form Video"),
#' channels_clicks = c("Search"),
#' frequency_of_campaigns = 2,
#' true_cvr = c(0.001, 0.002, 0.01, 0.005),
#' revenue_per_conv = 1)


step_0_define_basic_parameters <- function(years = 5,
                                           channels_impressions = c(),
                                           channels_clicks = c(),
                                           frequency_of_campaigns = 1,
                                           true_cvr,
                                           revenue_per_conv){


  years_var <- years
  channels_impressions_var <- channels_impressions
  channels_clicks_var <- channels_clicks
  frequency_of_campaigns_var <- frequency_of_campaigns
  true_cvr_var <- true_cvr
  revenue_per_conv_var <- revenue_per_conv

  # Display error messages for invalid inputs
  if (typeof(years_var) != "double") stop("You did not enter a number for years. You must have years be a numeric type.") # error if incorrect variable type for years
  if (typeof(frequency_of_campaigns) != "double") stop("You did not enter a number for frequency_of_campaigns. You must enter a numeric") # error if incorrect variable type for frequency
  if (typeof(true_cvr) != "double") stop("You did not enter a number for the true conversion rates. Must enter a numeric." )# error if incorrect variable type for true_cvr
  if (typeof(revenue_per_conv) != "double") stop("You did not enter a number for the revenue per conversion. Must enter a numeric." ) # error if incorrect variable type for revenue_per_conversion
  if (years_var < 1) stop('You entered less than 1 year. Must generate at least 1 year worth of data') # error if less than 1 year
  if ((years_var%%1==0) == FALSE) stop("You entered a decimal for the number of years. Must choose a whole number of years") # error if number of years is a decimal
  if (length(true_cvr)!= sum(!is.na(channels_impressions)) + sum(!is.na(channels_clicks))) stop("Did not input in enough numbers or input in too many numbers for conversion rates. Must have a conversion rate for each channel specified.") # error if not enough conversion rates are supplied
  if (ifelse(all(true_cvr > 0), TRUE, FALSE) == FALSE) stop("You entered a negative conversion rate. Enter a conversion rate between 0 and 1") # error if any conversion rates entered are less than 0
  if (ifelse(all(true_cvr <= 1), TRUE, FALSE) == FALSE) stop("You entered a conversion rate greater than 1. Enter conversion rate between 0 and 1.") # error if any conversion rates are greater than 1
  if ((frequency_of_campaigns %% 1 == 0) == FALSE) stop("You entered a decimal for the frequency of campaigns. You must enter a whole number") # error if frequency of campaign is not an integer
  if (frequency_of_campaigns < 1) stop ("You entered a frequency of campaign less than 1. You must enter a number greater than 1") # error if frequency of campaign is < 1
  if (revenue_per_conv <= 0) stop("You entered a negative or zero revenue per conversion. You must enter a positive number") # error if revenue_per_conv is <= 0

  # return variables as outputs to use with other functions
  list_of_vars <- list(years_var,
                       channels_impressions_var,
                       channels_clicks_var,
                       frequency_of_campaigns_var,
                       true_cvr_var,
                       revenue_per_conv_var)


  # print them out so people can see

  print("You have just run step 0: Defining Basic Parameters")
  print("To confirm what you have input: ")

  print(paste("Years of Data to generate : ", list_of_vars[[1]]))
  print(paste("Channel that use impressions : ", sapply(list_of_vars[[2]], paste, collapse = "")))
  print(paste("Channel that use clicks : ", sapply(list_of_vars[[3]], paste, collapse = "")))
  print(paste("How frequently campaigns occur : ", list_of_vars[[4]]))
  print(paste("True CVRs of a channel (in order of channels you specified) : ", sapply(list_of_vars[[5]], paste, collapse = "")))
  print(paste("Revenue per conversion : ", list_of_vars[[6]]))

  return(list_of_vars)

}
