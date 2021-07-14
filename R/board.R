#' Build a board
#' @export
board <- function(..., nrow = 9, ncol = 9, grp_dim = c(3, 3), .rules = c("col_unique", "row_unique", "grp_unique"), .seed = NULL) {
  if (!is.null(.seed)) set.seed(.seed)
  
  b <- empty_board(..., .rules = .rules)
  
}

#' Build an empty board
#' @export
empty_board <- function(..., nrow = 9, ncol = 9, grp_dim = c(3, 3), .rules = c("col_unique", "row_unique", "grp_unique")) {
  
  b <- 
    list(
      data = matrix(nrow = nrow, ncol = ncol)
      , grp_dim = grp_dim
      , rules = .rules
    )
  
  class(b) <- "board"
  b
  
}

#' Test if the object is a board
#' @export
is_board <- function(x) inherits(x, "board")
