% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/step_0_define_basic_parameters.R
\name{step_0_define_basic_parameters}
\alias{step_0_define_basic_parameters}
\title{Step 0 : Define Basic Parameters}
\usage{
step_0_define_basic_parameters(
  years = 5,
  channels_impressions = c(),
  channels_clicks = c(),
  frequency_of_campaigns = 1,
  true_cvr,
  revenue_per_conv,
  start_date = "2017/1/1"
)
}
\arguments{
\item{years}{A number, number of years you want to generate data for. Must be a whole number and equal to or greater than 1.}

\item{channels_impressions}{A vector of character strings, names of media channels that use impressions as their metric of activity (Examples: Facebook, TV, Long-Form Video), must be in vector format with strings. Do not provide if not applicable to you.}

\item{channels_clicks}{A vector of character strings, names of media channels that use clicks as their metric of activity (Examples: Search), must be in vector format with strings. Do not provide if not applicable to you.}

\item{frequency_of_campaigns}{A number, how often campaigns occur (for example, frequency of 1 would yield a new campaign every 1 day with each campaign lasting 1 day). Must be a whole number greater than or equal to 1.}

\item{true_cvr}{A vector of numbers, what the underlying conversion rates of all the channels are, statistical noise will be added on top of this, should be a vector of numbers between 0 and 1 in the SAME order as how channels were specified (channels that use impressions first, followed by channels that use clicks), must have same length as number of channels}

\item{revenue_per_conv}{A number, How much money we make from a conversion (i.e. profit from a unit of sale). Must be a number greater than 0.}

\item{start_date}{A string in the format yyyy/mm/dd that determines when your daily data set starts on.}
}
\value{
A list (in users' global environment) of variables the user has input
}
\description{
User inputs basic parameters that will be used in subsequent steps to simulate the data set, exists so that user does not have to keep inputting them. The parameters here initialize some variables in the user's environment.
}
\examples{
step_0_define_basic_parameters(years = 5,
channels_impressions = c("Facebook", "TV", "Long-Form Video"),
channels_clicks = c("Search"),
frequency_of_campaigns = 1,
true_cvr = c(0.001, 0.002, 0.01, 0.005),
revenue_per_conv = 1,
start_date = "2017/1/1")
}
