## code to prepare `DATASET` dataset goes here

p <- 
  create_board(.seed = 42) %>% 
  print_board() +
  ggplot2::annotate("rect", xmin = 3.53, xmax = 6.47, ymin = 5.53, ymax = 6.47, alpha = 1, fill = "#eeeeee") +
  ggplot2::annotate("text", x = 5, y = 6, size = 8, label = "pseudo-ku")

ggplot2::ggsave("man/figures/base.png")
hexSticker::sticker(
  "man/figures/base.png"
  , package=""
  , p_size=6
  , p_y=1.25
  , p_color="#424242"
  , h_fill="#F2F2F2"
  , h_color="#424242"
  , s_x=1
  , s_y=1
  , s_width=1.5
  , s_height=1.5
  , filename="man/figures/pseudoku.png"
  # , url="https://github.com/rtjohnson12/pseudoku"
  # , u_size=3
  , white_around_sticker = TRUE
)
