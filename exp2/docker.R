rm(list = ls())

exp = "exp2"
dataset = "Linux"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "exp2-docker.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

#shieldReduce数据
Data <- read_excel(sprintf("docker.xlsx"))
ShieldReduceUpload <- numeric(nrow(Data))
DEBEUpload <- numeric(nrow(Data))
ForwardDeltaUpload <- numeric(nrow(Data))
SecureMeGAUpload <- numeric(nrow(Data))
nrow(Data)
for (i in 1:nrow(Data)){
  ShieldReduceUpload[i] = Data[i,1]
  DEBEUpload[i] = Data[i,2]
  ForwardDeltaUpload[i] = Data[i,3]
  SecureMeGAUpload[i] = Data[i,4]
}
ShieldReduceUpload = unlist(ShieldReduceUpload)
DEBEUpload = unlist(DEBEUpload)
ForwardDeltaUpload = unlist(ForwardDeltaUpload)
SecureMeGAUpload = unlist(SecureMeGAUpload)

#x轴数据
xline <- numeric(nrow(Data))
for (i in 1:nrow(Data)){
  xline[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(4, 95), ylim = c(0, 850)) +
  # 折线
  geom_line(aes(x=xline,y=SecureMeGAUpload), color="#F2BE5C", size=2.8) + 
  geom_line(aes(x=xline,y=DEBEUpload), color="#B79AD1", size=2.8) + 
  geom_line(aes(x=xline,y=ForwardDeltaUpload), color="#75B8BF", size=2.8) + 
  geom_line(aes(x=xline,y=ShieldReduceUpload), color="#AD0626", size=2.8) + 
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text = element_text(size = 42, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 48)) +
  theme(axis.title.y = element_text(size = 45)) +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1.2)) +
  # 设置label内容
  labs(y = "Upload (MiB/s)", x = "Snapshot") +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(1, 25, 50, 75, 95),
                     labels = c(1, 25, 50, 75, 95)) +
  scale_y_continuous(breaks = c(0, 400, 800),
                     labels = c(0, 400, 800))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)

