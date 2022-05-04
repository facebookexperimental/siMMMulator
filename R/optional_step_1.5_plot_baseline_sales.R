# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' (Optional) Step 1.5: Plot Graph of Baseline Sales
#'
#' Plots baseline sales simulated from step 1.
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
#' optional_step_1.5_plot_baseline_sales()
#' }

optional_step_1.5_plot_baseline_sales <- function(){

  # initialize local variables to use later on
  week <- NA
  baseline_sales <- NA

  # Make plot
  p <- ggplot(data = .GlobalEnv$df_baseline, aes (x = week, y = baseline_sales/1000)) +
    geom_line() +
    ylab("Baseline Sales in 1000s") +
    ggtitle("Baseline Sales by Week") +
    theme(plot.title = element_text(hjust = 0.5)) +
    xlab("Week")

  # output
  p
}
