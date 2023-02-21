
# Demo Code

This is example code that users can quickly run for siMMMulator.

Run this code after you have followed the instructions in the [Setting up siMMMulator page](set_up.md).

```
my_variables <- step_0_define_basic_parameters(years = 2,
                                               channels_impressions = c("Facebook", "TV"),
                                               channels_clicks = c("Search"),
                                               frequency_of_campaigns = 1,
                                               true_cvr = c(0.001, 0.002, 0.003),
                                               revenue_per_conv = 1, 
                                               start_date = "2017/1/1"
)

df_baseline <- step_1_create_baseline(
                       my_variables = my_variables,        
                       base_p = 10000,
                       trend_p = 0.5,
                       temp_var = 2,
                       temp_coef_mean = 100,
                       temp_coef_sd = 500,
                       error_std = 100)

df_ads_step2 <- step_2_ads_spend(
  my_variables = my_variables,  
  campaign_spend_mean = 329000,
  campaign_spend_std = 100000,
  max_min_proportion_on_each_channel <- c(0.45, 0.55, # for first channel, Facebook
                                          0.1, 0.15)  # for second channel, TV.                                                         )
)
# The third channel, Search, will receive what is left. 

df_ads_step3 <- step_3_generate_media(
  my_variables = my_variables,
  df_ads_step2 = df_ads_step2,
  true_cpm = c(2, 20, NA),
  true_cpc = c(NA, NA, 0.25),
  mean_noisy_cpm_cpc = c(1, 0.05, 0.01),
  std_noisy_cpm_cpc = c(0.01, 0.15, 0.01)
)

df_ads_step4 <- step_4_generate_cvr(
  my_variables = my_variables,
  df_ads_step3 = df_ads_step3,
  mean_noisy_cvr = c(0, 0.0001, 0.0002), 
  std_noisy_cvr = c(0.001, 0.002, 0.003)
  )

df_ads_step5a_before_mmm <- step_5a_pivot_to_mmm_format(my_variables = my_variables,
                                                        df_ads_step4 = df_ads_step4)

df_ads_step5b <- step_5b_decay(
  my_variables = my_variables,
  df_ads_step5a_before_mmm = df_ads_step5a_before_mmm,
  true_lambda_decay = c(0.1, 0.2, 0.3)
)

df_ads_step5c <- step_5c_diminishing_returns(
  my_variables = my_variables,
  df_ads_step5b = df_ads_step5b,
  alpha_saturation = c(2, 2, 2),
  gamma_saturation = c(0.1, 0.2, 0.3)
)

df_ads_step6 <- step_6_calculating_conversions(
  my_variables = my_variables,
  df_ads_step5c = df_ads_step5c
)

df_ads_step7 <- step_7_expanded_df(
  my_variables = my_variables,
  df_ads_step6 = df_ads_step6,
  df_baseline = df_baseline
)

step_8_calculate_roi( 
  my_variables = my_variables,
  df_ads_step7 = df_ads_step7
)

list_of_df_final <- step_9_final_df(
  my_variables = my_variables,
  df_ads_step7 = df_ads_step7
)

optional_step_1.5_plot_baseline_sales(df_baseline = df_baseline)

optional_step_2.5_plot_ad_spend(df_ads_step2 = df_ads_step2)

optional_step_9.5_plot_final_df(df_final = list_of_df_final[[1]]) # for daily data
optional_step_9.5_plot_final_df(df_final = list_of_df_final[[2]]) # for monthly data

```
This code is for illustration purposes only. Individual results may vary.