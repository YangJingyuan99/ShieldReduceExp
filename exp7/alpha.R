rm(list = ls())

exp = "exp3"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp7-alpha.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

Linux = c(0.146,	0.085,	0.052,	0.020,	0.003)
Web = c(0.042,	0.027,	0.018,	0.008,	0.0003)
Docker = c(0.043,	0.040,	0.028,	0.015,	0.007)
SimOS = c(0.002,	0.002,	0.002,	0.002,	0.001)

#x轴数据
xline <- numeric(5)
for (i in 1:5){
  xline[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(1, 5), ylim = c(0, 0.15)) +
  # 折线和散点
  geom_line(aes(x=xline,y=Docker,color="Docker"), size=3) + 
  geom_point(aes(x=xline,y=Docker), color = "#F2BE5C", 
             size = 10, shape = 21, stroke=4.5) +
  geom_line(aes(x=xline,y=Web,color="Web"), size=3) + 
  geom_point(aes(x=xline,y=Web), color = "#B79AD1", 
             size = 10, shape = 25, stroke=4.5) +
  geom_line(aes(x=xline,y=SimOS,color="SimOS"), size=3) + 
  geom_point(aes(x=xline,y=SimOS), color = "#75B8BF", 
             size = 10, shape = 24, stroke=4.5) +
  geom_line(aes(x=xline,y=Linux,color="Linux"), size=3) + 
  geom_point(aes(x=xline,y=Linux), color = "#AD0626", 
             size = 10, shape = 23, stroke=4.5) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text = element_text(size = 37, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 45)) +
  theme(axis.title.y = element_text(size = 38)) +
  # 设置label内容
  labs(y = "Index Overhead (%)", x = NULL) +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1)) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5),
                     labels = c("α=0", "α=0.5", "α=0.7", "α=0.9", "α=1")) +
  scale_y_continuous(breaks = c(0, 0.05, 0.1, 0.15),
                     labels = c(0, 0.05, 0.1, 0.15)) +
  # 图例
  scale_color_manual(name=NULL, 
                    values=c("Linux" = "#AD0626",
                             "Web" = "#B79AD1",
                             "Docker" = "#F2BE5C",
                             "SimOS" = "#75B8BF"),
                    limits=c("Linux",
                             "Web",
                             "Docker",
                             "SimOS")) +
  # 图例位置
  theme(legend.position = c(0.75, 0.75)) +
  # 图例背景设置为空
  theme(legend.background = element_rect(fill = "transparent")) +
  # 图例大小
  theme(legend.text = element_text(size = 37)) +
  # 图例每行元素个数
  guides(color=guide_legend(ncol = 1, #根据ncol或者nrow设置图例显示行数或列数（设置一个即可）
                           byrow = T))#默认F，表示升序填充，反之则降序

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 8, height = 5)
