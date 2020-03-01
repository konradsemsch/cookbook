
# Blueprint ---------------------------------------------------------------

#' Blueprint
#'
#' This is an exemplary blueprint.
#'
#' @param base_recipe A the basic recipe specified by the user. See (TODO reference).
#' @param recipe_summary A summarized recipes object provided by \code{\link{summarise_recipe}}.
#' @examples
#'
#' TODO examples
#'
#' @importFrom magrittr %>%
#' @export
blueprint <- function(base_recipe, recipe_summary){

  # TODO validation needed

  # TODO some helper function for extraction?
  var_numeric <- recipe_summary$var_info$by_type$numeric
  var_date <- recipe_summary$var_info$by_type$date

  base_recipe %>%
  ### Handling time predictors

  step_date(one_of(var_date)) %>%
  step_holiday(one_of(var_date)) %>%
  step_rm(has_type("date")) %>%

  ### Imputation
  # Numeric predictors
  step_medianimpute(all_numeric(), -all_outcomes()) %>%

  # Categorical predictors
  step_modeimpute(all_nominal(), -all_outcomes()) %>%

  ### Lumping infrequent categories (optional)
  step_other(all_nominal(), -all_outcomes(), other = "infrequent") %>%

  ### Removing zero-variance predictors (optional)

  ### Individual transformations (optional)

  ### Dummyfying (optional features)
  step_dummy(all_nominal(), -all_outcomes()) %>%

  ### Interactions (optional)

  ### Normalization (optional)
  step_normalize(one_of(var_numeric))

  ### Multivariate transformations (optional)

  ### Removing unnecessary predictors

  # TODO
  ### Checks

}
