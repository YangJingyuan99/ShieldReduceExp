rm(list = ls())

exp = "exp7"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp4-docker.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
# library(showtext)

# font_add('Arial','C:/Windows/Fonts/arial.ttf')
# showtext_auto()

timeOn= c(1.20,
          1.19,
                1.23,
                1.25,
                1.28,
                1.31,
                1.30,
                1.36,
                1.40,
          1.53,
          1.58)

timeOff= c(1.5424,
           1.4784,
           1.28,
           1.0496,
           0.6848,
           0.5376,
           0.41728,
           0.30272,
           0.176,
           0.13696,
           0.1088
)

xline = c(0,
         0.01,
         0.02,
         0.03,
         0.04,
         0.05,
         0.06,
         0.07,
         0.08,
         0.09,
         0.10)


# 禁止科学计数法
options(scipen = 999)

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
# 绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(0.0, 0.1)) +
  # 折线
  geom_line(aes(x=xline,y=timeOn), color="#AD0626", size=3) + 
  geom_point(aes(x=xline,y=timeOn), 
             size = 9, stroke=4.5, color="#AD0626", shape = 23) +
  geom_line(aes(x=xline,y=timeOff), color="#2C3359", size=3) + 
  geom_point(aes(x=xline,y=timeOff), 
             size = 9, stroke=4.5, color="#2C3359", shape=24) +
  # 散点
  # geom_point(aes(x=xline,y=timeOn), color = "#AD0626", 
  #   size = 12) +
  # geom_point(aes(x=xline,y=timeOff), color = "#2C3359", 
  #   size = 14, shape = "X") +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text = element_text(size = 45, color = "black")) +
  # 设置字体样式
  # theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 45)) +
  theme(axis.title.y = element_text(size = 42)) +
  # 设置label内容
  labs(x = "Threshold t") +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1)) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(0, 0.05, 0.1),
                     labels = c(0, 0.05, 0.1)) +
  # 设置Y轴以及双Y轴
  scale_y_continuous(limits = c(0, 1.62),
                      breaks = seq(0, 1.6, 0.8),
                     name = "Time Duration (s)", 
                     sec.axis = sec_axis(~.*25/1.6,
                                        breaks = seq(0, 24, 12)))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10.3, height = 5)
