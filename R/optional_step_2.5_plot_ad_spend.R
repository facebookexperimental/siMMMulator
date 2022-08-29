# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' (Optional) Step 2.5: Plot Graph of Ad Spend
#'
#' Plots ad spend simulated from step 2.
#'
#' @param df_ads_step2 A data frame created by Step 2.
#'
#' @return A ggplot object
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text

#' @export
#'
#' @examples
#' \dontrun{
#' optional_step_2.5_plot_ad_spend(
#' df_ads_step2 = df_ads_step2
#' )
#' }

optional_step_2.5_plot_ad_spend <- function(
  df_ads_step2 = df_ads_step2
){

  # initialize local variables to use later on
  campaign_id <- NA
  spend_channel <- NA
  channel <- NA
  DATE <- NA

  # Make plot
  p <- ggplot(data = df_ads_step2,
         aes(x = campaign_id, y = spend_channel, group = channel, color = channel)) +
    geom_line() +
    ylab("Ad Spend on Channel") +
    xlab("Campaign Number") +
    ggtitle("Ad Spend on Each Channel by Campaign") +
    theme(plot.title = element_text(hjust = 0.5))

  # output
  p
}
