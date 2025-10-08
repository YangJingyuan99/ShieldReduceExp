rm(list = ls())

exportPath1 = "C:/Users/"
exportPath2 = "/Desktop/"
exportName = "exp-selection_linux.pdf"
username <- Sys.info()[["user"]]

exportPath = sprintf("%s%s%s", exportPath1, username, exportPath2)

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

cdf = c(0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.000,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.001,
        0.002,
        0.002,
        0.002,
        0.002,
        0.002,
        0.002,
        0.002,
        0.003,
        0.003,
        0.003,
        0.003,
        0.003,
        0.004,
        0.004,
        0.004,
        0.005,
        0.005,
        0.005,
        0.006,
        0.006,
        0.007,
        0.008,
        0.009,
        0.010,
        0.011,
        0.011,
        0.012,
        0.013,
        0.015,
        0.016,
        0.018,
        0.020,
        0.020,
        0.021,
        0.023,
        0.025,
        0.026,
        0.027,
        0.030,
        0.032,
        0.034,
        0.036,
        0.039,
        0.041,
        0.044,
        0.047,
        0.051,
        0.055,
        0.059,
        0.064,
        0.069,
        0.074,
        0.080,
        0.086,
        0.092,
        0.097,
        0.104,
        0.110,
        0.117,
        0.126,
        0.135,
        0.143,
        0.153,
        0.165,
        0.180,
        0.191,
        0.202,
        0.217,
        0.232,
        0.246,
        0.265,
        0.279,
        0.298,
        0.317,
        0.338,
        0.359,
        0.380,
        0.406,
        0.432,
        0.461,
        0.489,
        0.522,
        0.553,
        0.586,
        0.620,
        0.661,
        0.698,
        0.738,
        0.781,
        0.825,
        0.872,
        0.920,
        0.976,
        1.032,
        1.090,
        1.153,
        1.217,
        1.280,
        1.348,
        1.419,
        1.491,
        1.563,
        1.639,
        1.717,
        1.802,
        1.883,
        1.976,
        2.072,
        2.168,
        2.271,
        2.381,
        2.485,
        2.600,
        2.726,
        2.852,
        2.978,
        3.109,
        3.253,
        3.398,
        3.546,
        3.708,
        3.868,
        4.035,
        4.210,
        4.399,
        4.591,
        4.793,
        5.012,
        5.230,
        5.463,
        5.717,
        5.979,
        6.268,
        6.541,
        6.844,
        7.165,
        7.496,
        7.851,
        8.232,
        8.640,
        9.073,
        9.546,
        10.050,
        10.588,
        11.167,
        11.804,
        12.495,
        13.245,
        14.075,
        14.985,
        16.015,
        17.175,
        18.512,
        20.017,
        21.817,
        23.974,
        26.679,
        30.167,
        35.043,
        43.668,
        100.000
)

#x轴数据
xline <- numeric(200)
for (i in 1:200){
  xline[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(1.0, 202), ylim = c(0, 110)) +
  # 折线
  geom_line(aes(x=xline,y=cdf), color="#AD0626", size=3) + 
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text = element_text(size = 42, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 48)) +
  theme(axis.title.y = element_text(size = 45)) +
  # 设置label内容
  labs(y = "Upload (MiB/s)", x = "Number of clients") +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1.2)) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(1, 5, 10, 14),
                     labels = c(1, 5, 10, 14)) +
  scale_y_continuous(breaks = c(0, 400, 800),
                     labels = c(0, 400, 800))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)
