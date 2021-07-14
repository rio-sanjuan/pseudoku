
validate_board <- function(b) {
  
  validate_grp_dim(nrow(b$data), ncol(b$data), b$grp_dim)
  
}

validate_grp_dim <- function(nrow, ncol, grp_dim) {
  
  
  
}

invalid_board <- function(problem, vars, ...) {
  if (is.character(vars)) {
    vars <- tick(vars)
  }
  
  pluralise_commas(
    "Column(s) ",
    vars,
    paste0(" ", problem, ".", ...)
  )
}

board_error_class <- function(class) {
  c(paste0("board_error_", class), "board_error")
}

# Errors get a class name derived from the name of the calling function
board_error <- function(x, ..., parent = NULL) {
  call <- sys.call(-1)
  fn_name <- as_name(call[[1]])
  class <- board_error_class(gsub("^error_", "", fn_name))
  error_cnd(class, ..., message = x, parent = parent)
}
