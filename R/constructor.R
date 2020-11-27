
#' Create Empty Board
#' @export
create_board <- function(.seed = NA, .debug = FALSE) {
  
  if (!is.na(.seed)) set.seed(.seed)
  if (.debug) browser()
  
  board <- 
    expand.grid(1:9, 1:9) %>% 
    dplyr::transmute(row = Var1, col = Var2, val = NA) %>% 
    dplyr::mutate(
      group = dplyr::case_when(
        dplyr::between(row, 1, 3) & dplyr::between(col, 1, 3) ~ 1,
        dplyr::between(row, 1, 3) & dplyr::between(col, 4, 6) ~ 2,
        dplyr::between(row, 1, 3) & dplyr::between(col, 7, 9) ~ 3,
        dplyr::between(row, 4, 6) & dplyr::between(col, 1, 3) ~ 4,
        dplyr::between(row, 4, 6) & dplyr::between(col, 4, 6) ~ 5,
        dplyr::between(row, 4, 6) & dplyr::between(col, 7, 9) ~ 6,
        dplyr::between(row, 7, 9) & dplyr::between(col, 1, 3) ~ 7,
        dplyr::between(row, 7, 9) & dplyr::between(col, 4, 6) ~ 8,
        dplyr::between(row, 7, 9) & dplyr::between(col, 7, 9) ~ 9
      )
    )
  
  digit.queue <- sample(rep(1:9, 9))
  for (digit in digit.queue) {
    
    considerations <- board %>% 
      dplyr::filter(
        is.na(val)
        , !row %in% board[board$val == digit, "row"]
        , !col %in% board[board$val == digit, "col"]
        , !group  %in% board[board$val == digit, "group"]
      )
    
    if (nrow(considerations) >= 1) {
      insert.spot <- dplyr::sample_n(considerations, 1)
      
      board$val <- 
        ifelse(
          test = board$row == insert.spot$row & board$col == insert.spot$col
          , yes = digit
          , no  = board$val
        )
    }
  }
  
  board
}