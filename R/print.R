#' Print Board
#' @export
print_board <- function(board, .debug = FALSE) {
  
  # Debugger
  if (.debug) browser()
  
  # create plot data
  plot.data <- dplyr::mutate(board, fill = is.na(val))
  
  # create base plot
  p <- ggplot2::ggplot(plot.data, ggplot2::aes(x = col, y = row, group = group)) + 
    ggplot2::geom_tile(ggplot2::aes(fill = fill), color = "black") + 
    ggplot2::geom_text(ggplot2::aes(label = val), na.rm = TRUE) + 
    ggplot2::theme_void() + ggplot2::theme(legend.position = "none") + 
    ggplot2::scale_fill_manual(values = c("#eeeeee", "#c94038"))
  
  # add group bars
  gb <- ggplot2::ggplot_build(p) %>% 
    `[[`(1) %>% `[[`(1) %>% 
    dplyr::group_by(group) %>% 
    dplyr::summarize(
      x1 = min(xmin), 
      x2 = max(xmax), 
      y1 = min(ymin), 
      y2 = max(ymax)
    )
  
  # update plot object
  p <- p + ggplot2::geom_rect(
    data = gb
    , ggplot2::aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2)
    , color="black"
    , size = 1
    , fill = NA
    , inherit.aes = FALSE
  )
  
  return(p)
  
}