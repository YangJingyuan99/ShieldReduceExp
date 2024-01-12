rm(list = ls())

exp = "exp3"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp3-upload.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

TreeThroughput = c(298.2973093,	578.1948956,	768.9988574,	
                   859.0624296,	894.0806686,	920.6089242,	
                   930.9182792,	934.8045036,	907.627852,	
                   908.5585707,	911.2134015,	912.4279238,	
                   923.8718925,	919.5351354)
UniqueThroughput = c(76.5387131,	146.2803803,	184.7399786,	
                     207.7408522,	193.8038597,	197.8772703,	
                     191.1004127,	189.4179879,	206.1617464,	
                     185.9333436,	185.6470947,	188.5068488,	
                     188.2387158,	187.0547541)

#x轴数据
xline <- numeric(14)
for (i in 1:14){
  xline[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(1.2, 14), ylim = c(0, 1050)) +
  # 折线
  geom_line(aes(x=xline,y=TreeThroughput), color="#AD0626", size=3) + 
  geom_line(aes(x=xline,y=UniqueThroughput), color="#2C3359", size=3) + 
  # 散点
  geom_point(aes(x=xline,y=TreeThroughput), color = "#AD0626", 
             size = 12) +
  geom_point(aes(x=xline,y=UniqueThroughput), color = "#2C3359", 
             size = 14, shape = "X") +
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
  scale_y_continuous(breaks = c(0, 500, 1000),
                     labels = c(0, 500, 1000))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)
