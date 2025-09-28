rm(list = ls())

exp = "exp3"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp3-legend.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

TreeThroughput = c(310.7687479,	
                   310.7687479,	
                   310.7687479,	
                   826.6747101,	
                   711.2425305,
                   628.5992236,
                   605.8242633,	
                   592.7802806,	
                   584.46182,	
                   578.0596691
)
UniqueThroughput = c(76.6938265,	
                     76.6938265,	
                     76.6938265,	
                     211.1928062,	
                     127.3226182,	
                     113.5357878,	
                     110.8021192,	
                     101.9052247,	
                     109.2558475,	
                     107.7886102
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
  coord_cartesian(xlim =c(1.0, 10), ylim = c(0, 870)) +
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
