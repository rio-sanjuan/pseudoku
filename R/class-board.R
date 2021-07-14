
#' @importFrom methods setOldClass
#' @exportClass board
setOldClass("board")

#' `board` class
#' @name board-class
#' @aliases board board-class
NULL

# Standard Methods --------------------------------------------------------

#' @export
as.board.board <- function(x, ...) {
  class(x) <- "board"
  x
}
