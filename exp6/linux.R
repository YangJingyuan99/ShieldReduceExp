rm(list = ls())

exp = "exp6"
dataset = "Linux"
exportPath = "C:/Users/pc/Desktop/"
exportName = "exp6-linux.pdf"

datasetPathName = "20230818-data"
root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))
datasetDir <- sprintf("%s/%s/%s", root, datasetPathName, dataset)

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

# 加载数据
ReduceData <- read_excel(sprintf("./%s.xlsx", dataset))
sumData <- read_excel(sprintf("%s/offline-0.03-upload.xlsx", datasetDir))

# 数据计算
dedupList <- numeric(nrow(ReduceData))
inlineList <- numeric(nrow(ReduceData))
offlineList <- numeric(nrow(ReduceData))
for (i in 1:nrow(ReduceData)){
  if (i==1)
    sumSize <- sumData[i,17]
  else 
    sumSize <- sumData[i,17] - sumData[i-1,17]
  dedup = ReduceData[i, 1]
  inline = ReduceData[i, 2]
  offline = ReduceData[i, 3]
  if (dedup < 0)
    dedup = 0
  if (inline < 0)
    inline = 0
  if (offline < 0)
    offline = 0
  dedupList[i] = dedup / sumSize * 100
  inlineList[i] = inline / sumSize * 100 + dedupList[i]
  offlineList[i] = offline / sumSize * 100 + inlineList[i]
}
dedupList = unlist(dedupList)
inlineList = unlist(inlineList)
offlineList = unlist(offlineList)

#x轴数据
xline <- numeric(nrow(ReduceData))
for (i in 1:nrow(ReduceData)){
  xline[i] = i
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
ggplot() +
  # 填充面积
  geom_ribbon(aes(x = xline, ymin = 0, ymax = dedupList - 0.2), 
              fill = "#B79AD1", alpha = 0.7) +
  geom_ribbon(aes(x = xline, ymin = dedupList + 0.2, ymax = inlineList - 0.2), 
              fill = "#75B8BF", alpha = 0.7) +
  geom_ribbon(aes(x = xline, ymin = inlineList + 0.2, ymax = offlineList), 
              fill = "#F2BE5C", alpha = 0.7) +
  # 折线
  geom_line(aes(x = xline, y = dedupList), color = "#B79AD1", size = 2) + 
  geom_line(aes(x = xline, y = inlineList), color = "#75B8BF", size = 2) + 
  geom_line(aes(x = xline, y = offlineList), color = "#F2BE5C", size = 2) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 35)) +
  theme(axis.title.y = element_text(size = 35)) +
  # 设置label内容
  labs(y = "Percentage(%)", x = "Snapshot") +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(1, 51, 101, 151, 210),
                     labels = c(1, 51, 101, 151, 210)) +
  scale_y_continuous(breaks = c(0, 25, 50, 75, 100),
                     labels = c(0, 25, 50, 75, 100)) +
  # 设置坐标轴上字体大小
  theme(axis.text = element_text(size = 30, color = "black")) +
  # 坐标轴显示范围
  coord_cartesian(xlim =c(10.2, 210), ylim = c(4.6, 100))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 5)