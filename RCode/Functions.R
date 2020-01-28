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

## =========================================
## Create Board
## =========================================

# CreateBoard <- function(seed = 42, debug = FALSE) {
#   
#   # Debugger
#   if (debug) browser()
#   
#   # Create blank board
#   blank.board <- matrix(nrow = 9, ncol = 9)
#   
#   digits.available <- sample(rep(1:9, 9))
#   spots.available  <- do.call(paste0, expand.grid(1:9, 1:9))
#   
#   for (digit in digits.available) {
#     
#     unfilled <- TRUE
#     
#     for (consider.row in sample(1:9)) {
#       for (consider.column in sample(1:9)) {
#         
#         condition.1 <- is.na(blank.board[consider.row, consider.column])
#         condition.2 <- !digit %in% blank.board[, consider.column]
#         condition.3 <- !digit %in% blank.board[consider.row,]
#         condition.4 <- !digit %in% blank.board[1:3 + 3 * (consider.row-1) %/% 3, 
#                                                1:3 + 3 * (consider.column-1) %/% 3]
#         
#         if (condition.1 & condition.2 & condition.3 & condition.4) {
#           # place digit on board
#           blank.board[consider.row, consider.column] <- digit
#           
#           # set flag
#           unfilled <- FALSE
#         }
#         
#         
#       }
#     }
#     
#     if (unfilled) browser()
#   }
# }
