---
sidebar_position: 1
---

# About siMMMulator

## What is siMMMulator?

siMMMulator is an open source R-package that allows users to generate simulated data to plug into Marketing Mix Models (MMMs). The package features a variety of functions to help users build a data set from scratch.

### What are Marketing Mix Models?
Marketing Mix Models (MMMs) are used by marketers to understand what the ROI of their advertising spend on various channels are. This helps inform future investment decisions. MMMs usually incorporate many advertising channels in addition to non-advertising factors such as factors in the business environment. For more information on MMMs see the [Analysts Guide to MMM](https://facebookexperimental.github.io/Robyn/docs/analysts-guide-to-MMM/).

To try building your own MMM, see [Robyn](https://facebookexperimental.github.io/Robyn/), an automated open source MMM.

## Why use siMMMulator?
siMMMulator provides users of MMMs with a way to generate a dataset with a ground-truth ROI so that they may validate their models.

MMMs are difficult to validate because:
- There is typically not a "ground-truth" outcome in a real data set that we can test the MMMs on. In a typical modeling problem, we would have a data set with the outcome we are trying to predict for. For example, if we were trying to build a model to predict the price of a home, we may have a data set with many different homes and the price they sold for. Then we would split up our data set into a training and testing data set. We would train our model on the training set. Then we would feed the test data set into the model to see how closely the model recovers the price of a home. This would give us an idea of how accurate our model is. However, with MMMs, marketers are trying to predict ROIs of various advertising media channels. The "true ROI" is not known, so we do not have a set to compare our model's predictions to.
- MMMs are usually built with time series data. This means the past predicts the present, which predicts the future. Since the different data points are connected to one another, it makes it difficult for us to decide which data to even select if we were going to make a testing data set.
- Finally, MMMs are usually built on weekly or monthly sales data. Newer advertisers may not have sufficient data points to make an accurate model or do model validation.

siMMMulator and simulated data helps to solve this problem because it provides a data set where:
- We know the true ROIs (the outcome the model is trying to predict for) so we have a comparison as to how closely our MMMs can recover this value. We know what the true ROI is because we simulated the data from the ground-up and just added statistical noise
- Marketers can generate as much data as they'd like, bypassing problems of insufficient data
- Users can generate data based on how their own business operates, making siMMMulator flexible and adaptable

## Applications of siMMMulator:
- **Validate MMMs** : See how accurate MMMs are by seeing how well they can recover the true ROI of the data set
- **Compare MMMs**: Understand which MMM works better depending on which data sets (i.e. business scenarios) were generated
- **Quantify an Innovation to an MMM**: See how much more accurate an MMM is after a particular innovation

siMMMulator can work with most MMMs.

## Looking for code to build a MMM?

Check out [Robyn](https://facebookexperimental.github.io/Robyn/). Robyn is an experimental, semi-automated and open-sourced Marketing Mix Modeling (MMM) package from Meta Marketing Science. It uses various machine learning techniques (Ridge regression, multi-objective evolutionary algorithm for hyperparameter optimisation, time-series decomposition for trend & season etc.) to define media channel efficiency and effectivity, explore adstock rates and saturation curves. Robyn is built for granular datasets with many independent variables and therefore especially suitable for digital and direct response advertisers with rich data sources.

## Extra Docs
[Download a one-sheeter for siMMMulator](one-sheeter.pdf)

[Download a presentation for siMMMulator](presentation.pdf)
