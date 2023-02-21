# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' (Optional) Step 1.5: Plot Graph of Baseline Sales
#'
#' Plots baseline sales simulated from step 1.
#'
#' @param df_baseline A data frame that was created in Step 1.
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
#'
#' @export
#'
#' @examples
#' \dontrun{
#' optional_step_1.5_plot_baseline_sales(
#' df_baseline = df_baseline)
#' }

optional_step_1.5_plot_baseline_sales <- function(
  df_baseline = df_baseline
){

  # initialize local variables to use later on
  day <- NA
  baseline_sales <- NA

  # Make plot
  p <- ggplot(data = df_baseline, aes (x = day, y = baseline_sales)) +
    geom_line() +
    ylab("Baseline Sales") +
    ggtitle("Baseline Sales by Week") +
    theme(plot.title = element_text(hjust = 0.5)) +
    xlab("Day")

  # output
  p
}
