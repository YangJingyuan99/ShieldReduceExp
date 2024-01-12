rm(list = ls())

exp = "exp3"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp3-download.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()
UniqueThroughput = c(411.2608358,	694.8722129,	834.368372,	
                   885.2039967,	876.9824063,	872.7960798,	
                   876.8007488,	871.0097504,	883.7736059,	
                   890.4331953,	862.0108768,	849.0209848,	
                   878.1633746,	882.4890648)
TreeThroughput = c(752.3921653,	1160.490758,	1214.744795,	
                     1246.960372,	1245.307977,	1237.486132,	
                     1189.280416,	1159.265632,	1155.884476,	
                     1168.231146,	1152.125655,	1118.334624,	
                     1106.864507,	1069.537178)

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
  coord_cartesian(xlim =c(1.2, 14), ylim = c(0, 1450)) +
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
  theme(axis.title.y = element_text(size = 41)) +
  # 设置label内容
  labs(y = "Download (MiB/s)", x = "Number of clients") +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1.1)) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(1, 5, 10, 14),
                     labels = c(1, 5, 10, 14)) +
  scale_y_continuous(breaks = c(0, 700, 1400),
                     labels = c(0, 700, 1400))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)
