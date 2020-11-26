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