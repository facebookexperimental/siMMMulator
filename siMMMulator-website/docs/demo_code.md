
# Demo Code

This is example code that users can quickly run for siMMMulator.

Run this code after you have followed the instructions in the [Setting up siMMMulator page](set_up.md).

```
my_variables <- step_0_define_basic_parameters(years = 5,
                               channels_impressions = c("Facebook", "TV"),
                               channels_clicks = c(),
                               frequency_of_campaigns = 1,
                               true_cvr = c(0.001, 0.002),
                               revenue_per_conv = 1)

df_baseline <- step_1_create_baseline(
                       my_variables = my_variables,
                       base_p = 500000,
                       trend_p = 0.5,
                       temp_var = 8,
                       temp_coef_mean = 1000,
                       temp_coef_sd = 5000,
                       error_std = 100000)

df_ads_step2 <- step_2_ads_spend(
                my_variables = my_variables,
                campaign_spend_mean = 329000,
                 campaign_spend_std = 100000,
                 max_min_proportion_on_each_channel <- c(0.45, 0.55))


df_ads_step3 <- step_3_generate_media(
  my_variables = my_variables,
  df_ads_step2 = df_ads_step2,
  true_cpm = c(2, 20),
  true_cpc = c(),
  mean_noisy_cpm_cpc = c(1, 0.05),
  std_noisy_cpm_cpc = c(0.01, 0.15)
)

df_ads_step4 <- step_4_generate_cvr(
  my_variables = my_variables,
  df_ads_step3 = df_ads_step3,
  mean_noisy_cvr = c(0, 0.0001),
  std_noisy_cvr = c(0.001, 0.002)
  )

df_ads_step5a_before_mmm <- step_5a_pivot_to_mmm_format(my_variables = my_variables,
                                                        df_ads_step4 = df_ads_step4)

df_ads_step5b <- step_5b_decay(
  my_variables = my_variables,
  df_ads_step5a_before_mmm = df_ads_step5a_before_mmm,
  true_lambda_decay = c(0.1, 0.2)
)

df_ads_step5c <- step_5c_diminishing_returns(
  my_variables = my_variables,
  df_ads_step5b = df_ads_step5b,
  alpha_saturation = c(2, 2),
  gamma_saturation = c(0.1, 0.2)
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

df_final <- step_9_final_df(
  my_variables = my_variables,
  df_ads_step7 = df_ads_step7
)

optional_step_1.5_plot_baseline_sales(df_baseline = df_baseline)

optional_step_2.5_plot_ad_spend(df_ads_step2 = df_ads_step2)

optional_step_9.5_plot_final_df(df_final = df_final)
```
This code is for illustration purposes only. Individual results may vary.