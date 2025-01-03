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
UniqueThroughput = c(302.955622,	
                     548.5730204,
                     629.5684444,	
                     700.9250037,	
                     737.803191,	
                     738.1069898,	
                     732.2160773,
                     735.9434862,	
                     727.8515278,	
                     697.9939864


)
TreeThroughput = c(732.2491481,	
                   952.408246,
                   1029.554317,	
                   1013.542929,	
                   1024.616102,	
                   992.3178544,	
                   1026.550428,	
                   980.5707219,	
                   937.0588234,	
                   862.7067682

)

#x轴数据
xline <- numeric(10)
for (i in 1:10){
  xline[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(1.0, 10), ylim = c(0, 1080)) +
  # 折线
  geom_line(aes(x=xline,y=TreeThroughput), color="#AD0626", size=3) + 
  geom_line(aes(x=xline,y=UniqueThroughput), color="#2C3359", size=3) + 
  # 散点
  geom_point(aes(x=xline,y=TreeThroughput), color = "#AD0626", 
             size = 9, stroke=4.5, shape = 23) +
  geom_point(aes(x=xline,y=UniqueThroughput), color = "#2C3359", 
             size = 9, stroke=4.5, shape = 24) +
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
  scale_y_continuous(breaks = c(0, 500, 1000),
                     labels = c(0, 500, 1000))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)
