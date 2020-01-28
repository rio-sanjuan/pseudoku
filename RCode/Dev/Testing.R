library(tidyverse)
library(ggrepel)

source("RCode/Functions.R")

## ===========================================
## Create Board
## ===========================================
board <- expand.grid(1:9, 1:9) %>% 
  transmute(Row = Var1, Column = Var2, Value = NA) %>% 
  mutate(
    Group = case_when(
      between(Row, 1, 3) & between(Column, 1, 3) ~ 1,
      between(Row, 1, 3) & between(Column, 4, 6) ~ 2,
      between(Row, 1, 3) & between(Column, 7, 9) ~ 3,
      between(Row, 4, 6) & between(Column, 1, 3) ~ 4,
      between(Row, 4, 6) & between(Column, 4, 6) ~ 5,
      between(Row, 4, 6) & between(Column, 7, 9) ~ 6,
      between(Row, 7, 9) & between(Column, 1, 3) ~ 7,
      between(Row, 7, 9) & between(Column, 4, 6) ~ 8,
      between(Row, 7, 9) & between(Column, 7, 9) ~ 9))

digit.queue <- sample(rep(1:9, 9))
for (digit in digit.queue) {
  
  considerations <- board %>% 
    filter(
      is.na(Value)
      , !Row    %in% board[board$Value == digit, "Row"]
      , !Column %in% board[board$Value == digit, "Column"]
      , !Group  %in% board[board$Value == digit, "Group"])
  
  if (nrow(considerations) >= 1) {
    insert.spot <- sample_n(considerations, 1)
    
    board$Value <- ifelse(
      test = board$Row == insert.spot$Row & board$Column == insert.spot$Column,
      yes  = digit, 
      no   = board$Value
    )

  } # else browser()
  
  
}

## ===========================================
## Print Board
## ===========================================
PrintBoard(board)

















