###############################################
##
##  Pseudo-Ku Functions
## 
##  author: Ryan Johnson
##  created: Jan 2020
##  
###############################################

## =========================================
## Create Board
## =========================================

CreateBoard <- function(seed = 42, debug = FALSE) {
  
  # Debugger
  if (debug) browser()
  # set.seed(seed)
  
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
  
  return(board)
}

## =========================================
## Print Board
## =========================================

PrintBoard <- function(board, debug = FALSE) {
  
  # Debugger
  if (debug) browser()
  
  # create plot data
  plot.data <- mutate(board, Fill = is.na(Value))
  
  # create base plot
  p <- ggplot(plot.data, aes(x = Column, y = Row, group = Group)) + 
    geom_tile(aes(fill = Fill), color = "black") + 
    geom_text(aes(label = Value), na.rm = TRUE) + 
    theme_void() + theme(legend.position = "none") + 
    scale_fill_manual(values = c("#eeeeee", "#c94038"))
  
  # add group bars
  gb <- ggplot_build(p) %>% 
    `[[`(1) %>% `[[`(1) %>% 
    group_by(group) %>% 
    summarize(
      x1 = min(xmin), 
      x2 = max(xmax), 
      y1 = min(ymin), 
      y2 = max(ymax))
  
  # update plot object
  p <- p + geom_rect(
    data = gb
    , aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2)
    , color="black"
    , size = 1
    , fill = NA
    , inherit.aes = FALSE)
  
  return(p)
  
}
