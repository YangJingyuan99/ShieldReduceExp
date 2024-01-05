rm(list = ls())

exp = "exp4"
dataset = "Linux"
exportPath = "C:/Users/pc/Desktop/"
exportName = "exp4-linux.pdf"

datasetPathName = "20230818-data"
root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))
datasetDir <- sprintf("%s/%s/%s", root, datasetPathName, dataset)

library(ggplot2)
library(ggbreak)
library(readxl)
library(extrafont)
library(showtext)  
library(gg.gap)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

inlineTime = c(4.94, 4.93, 5.01, 5.23, 6.31)
offlineTime = c(639, 631, 596, 574, 440)

barWidth = 0.4
x3_offset = c(0, 1, 2, 3, 4)
x1_offset = numeric(5)
x2_offset = numeric(5)
for(i in 1:5) {
  x1_offset[i] = x3_offset[i] - 0.5 * barWidth
  x2_offset[i] = x3_offset[i] + 0.5 * barWidth
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
p1 <- ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(-0.2, 4.5), ylim = c(1.18, 25)) +
  # 设置y坐标标签
  scale_y_continuous(breaks = c(0, 20),
                     labels = c(0, 20)) +
  # 柱状图
  geom_col(aes(x = x1_offset,y = inlineTime), width = 0.4, fill = "#AD0626", 
           color = "black", size = 0.5) +
  geom_col(aes(x = x2_offset,y = offlineTime), width = 0.4, fill = "#2C3359", 
           color = "black", size = 0.5) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text.x = element_text(size = 42, color = "black")) +
  theme(axis.text.y = element_text(size = 42, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 45)) +
  theme(axis.title.y = element_text(size = 41)) +
  # 设置label内容
  labs(y = "Time Duration (s)", x = "Threshold") +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = x3_offset,
                     labels = c("0", "0.01", "0.02", "0.03", "0.04")) +
  theme(axis.title.y = element_text(hjust = 0.32)) +
  # 标签
  geom_text(aes(x = x1_offset, y = round(inlineTime, 1)), hjust = 0,
            vjust = 0.4, label=inlineTime, angle = 90, size = 13, nudge_y = 1)

p2 <- ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(-0.2, 4.5), ylim = c(300, 1100)) +
  # 设置y坐标标签
  scale_y_continuous(breaks = c(500, 1000),
                     labels = c(500, 1000)) +
  # 柱状图
  geom_col(aes(x = x1_offset,y = inlineTime), width = 0.4, fill = "#AD0626", 
           color = "black", size = 0.5) +
  geom_col(aes(x = x2_offset,y = offlineTime), width = 0.4, fill = "#2C3359", 
           color = "black", size = 0.5) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text.x = element_text(size = 42, color = "black")) +
  theme(axis.text.y = element_text(size = 42, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 42)) +
  theme(axis.title.y = element_text(size = 42)) +
  # 设置label内容
  labs(y = NULL, x = NULL) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = x3_offset,
                     labels = c("0", "0.01", "0.02", "0.03", "0.04")) +
  theme(axis.text.x = element_blank()) +
  theme(axis.line.x = element_blank()) +
  theme(axis.ticks.x = element_blank()) +
  theme(panel.grid.major = element_blank()) +
  # 标签
  geom_text(aes(x = x2_offset, y = round(offlineTime, 1)), hjust = 0,
            vjust = 0.4, label=offlineTime, angle = 90, size = 13, nudge_y = 20.5)

p2/p1
  

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)
