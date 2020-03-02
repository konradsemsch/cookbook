
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cookbook

<!-- badges: start -->

<!-- badges: end -->

The goal of cookbook is to …

## Installation

You can install the development version of cookbook from
[Github](https://github.com/konradsemsch/cookbook) with:

``` r
devtools::install_github("konradsemsch/cookbook")
```

## Example usage

This is a basic example which shows you how to solve a common problem:

``` r

library(cookbook)
library(modeldata)
library(tidymodels)
#> Registered S3 method overwritten by 'xts':
#>   method     from
#>   as.zoo.xts zoo
#> ── Attaching packages ───────────────────────────────────────── tidymodels 0.0.3 ──
#> ✓ broom     0.5.2          ✓ purrr     0.3.3     
#> ✓ dials     0.0.4          ✓ recipes   0.1.9     
#> ✓ dplyr     0.8.3          ✓ rsample   0.0.5     
#> ✓ ggplot2   3.2.1          ✓ tibble    2.1.3     
#> ✓ infer     0.5.0          ✓ yardstick 0.0.4     
#> ✓ parsnip   0.0.4.9000
#> ── Conflicts ──────────────────────────────────────────── tidymodels_conflicts() ──
#> x purrr::discard()  masks scales::discard()
#> x dplyr::filter()   masks stats::filter()
#> x dplyr::lag()      masks stats::lag()
#> x ggplot2::margin() masks dials::margin()
#> x recipes::step()   masks stats::step()
library(workflows)

data("okc")
colnames(okc) <- tolower(names(okc))

okc <- sample_n(okc, 1000)

strata <- "class"
split <- initial_split(okc, prop = 0.8, strata = strata)

train <- training(split)
test <- testing(split)

cv <- vfold_cv(
  train,
  v = 5,
  repeats = 1,
  strata = strata
)

# 1) Create a base recipe where training data is provided
# and roles for all variables are defined
recipe_base <- train %>%
  recipe() %>%
  update_role(class, new_role = "outcome") %>%
  update_role(-one_of("class"), new_role = "predictors")

# 2) Pass your base recipe into the apply_recipe function
# and provide the recipe blueprint to bind to it
recipe <- recipe_base %>%
  add_blueprint("v1")

# 3) Run your model as you normally would (single blueprint)
model <- logistic_reg() %>%
  set_mode("classification") %>%
  set_engine("glm")

workflow <- workflow() %>%
  add_recipe(recipe) %>%
  add_model(model) %>%
  fit(data = train)
```
