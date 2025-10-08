rm(list = ls())

exportPath1 = "C:/Users/"
exportPath2 = "/Desktop/"
exportName = "exp-selection_web.pdf"
username <- Sys.info()[["user"]]

exportPath = sprintf("%s%s%s", exportPath1, username, exportPath2)

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

under = c(2.69)
main = c(0.340,
         0.438,
         0.517,
         0.591,
         0.653,
         0.736,
         0.858,
         0.962,
         1.092,
         1.302,
         1.602,
         1.861,
         2.067,
         2.596,
         3.000,
         3.773,
         5.114,
         6.122,
         8.949,
         54.740)

# 禁止科学计数法
options(scipen = 999)

barWidth = 1
x3_offset = c(0)
x1_offset = numeric(20)
for(i in 1:20) {
  x1_offset[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
p1 <- ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(0, 21), ylim = c(0, 12)) +
  # 柱状图
  geom_col(aes(x = x3_offset,y = under, fill = "under"), width = barWidth, 
           color = "black", size = 0.25) +
  geom_col(aes(x = x1_offset,y = main, fill = "main"), width = barWidth, 
           color = "black", size = 0.25) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text.x = element_text(size = 40, color = "black")) +
  theme(axis.text.y = element_text(size = 40, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 40)) +
  theme(axis.title.y = element_text(size = 40)) +
  # 设置label内容
  labs(y = "Percentage (%)", x = "Efficiency score") +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 0.14)) +
  # 隐藏x轴label
  # theme(axis.title.x = element_blank()) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(0.5, 10.5, 20.5),
                     labels = c("0.8", "0.9", "1.0")) +
  scale_y_continuous(breaks = c(0, 10),
                     labels = c(0, 10),
                     expand = c(0, 0)) +
  # 图例
  scale_fill_manual(name=NULL, 
                    values=c("under" = "gray",
                             "main" = "#B79AD1"),
                    limits=c("under",
                             "main")) +
  theme(legend.position = "none")

p2 <- ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(0, 21), ylim = c(36, 85)) +
  # 柱状图
  geom_col(aes(x = x3_offset,y = under, fill = "under"), width = barWidth, 
           color = "black", size = 0.25) +
  geom_col(aes(x = x1_offset,y = main, fill = "main"), width = barWidth, 
           color = "black", size = 0.25) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text.x = element_text(size = 40, color = "black")) +
  theme(axis.text.y = element_text(size = 40, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 40)) +
  theme(axis.title.y = element_text(size = 40)) +
  # 设置label内容
  labs(y = NULL, x = NULL) +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1.14)) +
  # 隐藏x轴label
  # theme(axis.title.x = element_blank()) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(0.5, 10.5, 20.5),
                     labels = c("0.8", "0.9", "1.0")) +
  scale_y_continuous(breaks = c(0, 40, 80),
                     labels = c(0, 40, 80)) +
  # 图例
  scale_fill_manual(name=NULL, 
                    values=c("under" = "gray",
                             "main" = "#B79AD1"),
                    limits=c("under",
                             "main")) +
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        axis.line.x = element_blank())

p2/p1

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)
