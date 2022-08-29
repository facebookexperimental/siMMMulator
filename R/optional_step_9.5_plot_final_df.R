# Copyright (c) Meta Platforms, Inc. and affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

####################################################################

#' (Optional) Step 9.5: Plot Graph of Final Data Set
#'
#' Plots final data set with date on x-axis and revenue on y-axis.
#'
#' @param df_final Your final data frame that came from Step 9.
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
#' optional_step_9.5_plot_final_df(
#' df_final = df_final
#' )
#' }

optional_step_9.5_plot_final_df <- function(
  df_final = df_final
){

  # initialize local variables to use later on
  DATE <- NA
  total_revenue <- NA

  # Make plot
  p <- ggplot(data = df_final,
         aes(x = DATE)) +
      geom_line(aes(y = total_revenue), color = "red") +
      ylab("Revenue") +
      xlab("Date") +
      ggtitle("Revenue by Date") +
      theme(plot.title = element_text(hjust = 0.5))

  # output
  p
}
