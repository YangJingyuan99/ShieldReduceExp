rm(list = ls())

exp = "exp7"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp4-linux.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
# library(showtext)

# font_add('Arial','C:/Windows/Fonts/arial.ttf')
# showtext_auto()

timeOn= c(4.899004833,
          4.862226459,
          4.934327225,
          4.991467273,
          5.256048995,
          5.627481722,
          6.097357177,
          6.65157067,
          7.329412201,
          7.835361905,
          8.416476986
          
)

timeOff= c(8.759979188,
           8.487392285,
           8.35944129,
           7.661034156,
           5.620571151,
           4.687957813,
           3.966978837,
           3.239849804,
           2.038037077,
           1.645205468,
           1.4317854
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
  scale_y_continuous(limits = c(0, 10),
                     breaks = seq(0, 10, 5),
                     name = "Time Duration (s)", 
                     sec.axis = sec_axis(trans = ~.*80,
                                         breaks = seq(0, 800, 400)))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10.3, height = 5)
