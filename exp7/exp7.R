rm(list = ls())

exp = "exp7"
exportPath = "C:/Users/pc/Desktop/"
exportName = "exp7.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

FingerprintIndex = c(0.39, 0.11, 0.2, 0.009)
FeatureIndex = c(0.14, 0.02, 0.24, 0.02)
DeltaIndex = c(0.14, 0.03, 0.04, 0.001)

# 禁止科学计数法
options(scipen = 999)

barWidth = 0.4
x2_offset = c(0, 1.4, 2.8, 4.2)
x1_offset = numeric(4)
x3_offset = numeric(4)
for(i in 1:4) {
  x1_offset[i] = x2_offset[i] - 1 * barWidth
  x3_offset[i] = x2_offset[i] + 1 * barWidth
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(-0.5, 5), ylim = c(0.036, 0.77)) +
  # 柱状图
  geom_col(aes(x = x1_offset,y = FingerprintIndex, fill = "Fingerprint Index"), width = 0.4, 
           color = "black", size = 0.5) +
  geom_col(aes(x = x2_offset,y = FeatureIndex, fill = "Feature Index"), width = 0.4, 
           color = "black", size = 0.5) +
  geom_col(aes(x = x3_offset,y = DeltaIndex, fill = "Delta Index"), width = 0.4, 
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
  theme(axis.title.y = element_text(size = 38)) +
  # 设置label内容
  labs(y = "Index Overhead (%)", x = NULL) +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 1)) +
  # 隐藏x轴label
  theme(axis.title.x = element_blank()) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = x2_offset,
                     labels = c("Linux", "Web", "Docker", "SimOS")) +
  scale_y_continuous(breaks = c(0, 0.3, 0.6),
                     labels = c(0, 0.3, 0.6)) +
  # 设置文本，hjust和vjust设置对齐基准点
  geom_text(aes(x = x1_offset, y = FingerprintIndex), hjust = 0,
            vjust = 0.5, label=FingerprintIndex, angle = 90, size = 12, nudge_y = 0.008) +
  geom_text(aes(x = x2_offset, y = FeatureIndex), hjust = 0,
            vjust = 0.5, label=FeatureIndex, angle = 90, size = 12, nudge_y = 0.008) +
  geom_text(aes(x = x3_offset, y = DeltaIndex), hjust = 0,
            vjust = 0.5, label=DeltaIndex, angle = 90, size = 12, nudge_y = 0.008) +
  # 图例
  scale_fill_manual(name=NULL, 
                    values=c("Fingerprint Index" = "#AD0626",
                             "Feature Index" = "#B79AD1",
                             "Delta Index" = "#F2BE5C"),
                    limits=c("Fingerprint Index",
                             "Feature Index",
                             "Delta Index")) +
  # 图例位置
  theme(legend.position = c(0.42, 0.88)) +
  # 图例背景设置为空
  theme(legend.background = element_rect(fill = "transparent")) +
  # 图例大小
  theme(legend.text = element_text(size = 38)) +
  # 图例每行元素个数
  guides(fill=guide_legend(ncol = 2, #根据ncol或者nrow设置图例显示行数或列数（设置一个即可）
                           byrow = T))#默认F，表示升序填充，反之则降序


# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 12, height = 5)
