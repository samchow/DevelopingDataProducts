# DevelopingDataProducts

## Overview
This project is an exercise in estimating the price of diamond based on its size (in carat), cut, and color using a combinations of linear models. 

## Challenges
The challenge is that a linear model is not ideal for estimating the price of diamonds, e.g., an 8 carat diamond will cost more than twice a 4 carat one. Factoring in the cut and color makes the problem more difficult. 

## Linear models
After some fine tuning we came up with using a combination of the following 4 linear models based on the diamonds dataset.

1. Linear fit through the origin based solely on the size
2. linear fit (with intercept) based solely on size
3. linear fit based on size and color
4. linear fit based on size and cut

## Estimate Heuristics
For diamond of size less than  1.0 carat, we use the maximum the first two estimates as the price.

And for diamond 1.0 carat or more, we compute average of the latter two estimates an use it only when it gives a higher estimate.
