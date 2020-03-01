
# Summarise recipe --------------------------------------------------------

#' Summarise base recipe
#'
#' This is a helper function extracts essential information from the base recipe
#' and passes it further into the selected bluprint(s).
#'
#' @param base_recipe A the basic recipe specified by the user. See (TODO reference).
#' @examples
#'
#' TODO examples
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter pull
#' @export
summarise_recipe <- function(base_recipe){

  # TODO validation needed

  # Recipe summary
  summary <- summary(base_recipe)

  # Collecting individual variable information, by role
  var_outcome <- summary %>%
    filter(role == "outcome") %>%
    pull(variable)

  var_predictor <- summary %>%
    filter(role == "predictors") %>%
    pull(variable)

  var_other <- summary %>%
    filter(!(role %in% c("outcome", "predictors"))) %>%
    pull(variable)

  # Collecting individual variable information, by type
  var_numeric <- summary %>%
    filter(type == "numeric") %>%
    pull(variable)

  var_nominal <- summary %>%
    filter(type == "nominal") %>%
    pull(variable)
  var_date <- summary %>%
    filter(type == "date") %>%
    pull(variable)

  # Putting it all together
  list(
    base_recipe = base_recipe,
    var_info = list(
      by_role = list(
        outcome = var_outcome,
        predictor = var_predictor,
        other = var_other
      ),
      by_type = list(
        numeric = var_numeric,
        nominal = var_nominal,
        date = var_date
      )
    )
  )

}

# Select blueprint --------------------------------------------------------

#' Select a given blueprint
#'
#' This is a helper function that evaluates to a selected blueprint id
#' and binds it with the base recipe.
#'
#' @param recipe_summary A summarized recipes object provided by \code{\link{summarise_recipe}}.
#' @param blueprint A blueprint id. Use \code{\link{TODO function}} for a list of available blueprints.
#' @examples
#'
#' TODO examples
#'
#' @export
select_blueprint <- function(recipe_summary, blueprint){

  # TODO validation needed

  if(blueprint == "v1"){
    blueprint(recipe_base, recipe_summary)
  } else {
    stop("Blueprint id not available")
  }

}

# Add blueprint -----------------------------------------------------------

#' Add blueprint to a recipe
#'
#' This function binds together the base definition of the recipe
#' specified by the user with a selected blueprint id.
#'
#' @param base_recipe A the basic recipe specified by the user. See (TODO reference).
#' @param blueprint A blueprint id. Use \code{\link{TODO function}} for a list of available blueprints.
#' @examples
#'
#' TODO examples
#'
#' @export
add_blueprint <- function(base_recipe, blueprint){

  recipe_summary <- summarise_recipe(base_recipe)

  # Binding the base recipe with the selected blueprint
  recipe <- select_blueprint(recipe_summary, blueprint)

  return(recipe)

}
