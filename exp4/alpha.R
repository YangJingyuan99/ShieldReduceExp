rm(list = ls())

exp = "exp7"
exportPath = "C:/Users/杨劲远/Desktop/"
exportName = "exp4-alpha.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
library(showtext)

font_add('Arial','C:/Windows/Fonts/arial.ttf')
showtext_auto()

a0 = c(574, 550, 17.1, 19.5)
a05 = c(407, 346, 14.2, 24.0)
a07 = c(244, 243, 11.0, 24.5)
a09 = c(89.7, 121, 4.72, 24.0)
a1 = c(1.03, 0.93, 0.08, 0.07)

# 禁止科学计数法
options(scipen = 999)

barWidth = 0.4
x3_offset = c(0, 2.2, 4.4, 6.6)
x1_offset = numeric(4)
x2_offset = numeric(4)
x4_offset = numeric(4)
x5_offset = numeric(4)
for(i in 1:4) {
  x1_offset[i] = x3_offset[i] - 2 * barWidth
  x2_offset[i] = x3_offset[i] - 1 * barWidth
  x4_offset[i] = x3_offset[i] + 1 * barWidth
  x5_offset[i] = x3_offset[i] + 2 * barWidth
}

# 设置字体
windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(-0.7, 8), ylim = c(35.5, 750)) +
  # 柱状图
  geom_col(aes(x = x1_offset,y = a0, fill = "α=0"), width = 0.4, 
           color = "black", size = 0.5) +
  geom_col(aes(x = x2_offset,y = a05, fill = "α=0.5"), width = 0.4, 
           color = "black", size = 0.5) +
  geom_col(aes(x = x3_offset,y = a07, fill = "α=0.7"), width = 0.4, 
           color = "black", size = 0.5) +
  geom_col(aes(x = x4_offset,y = a09, fill = "α=0.9"), width = 0.4,
           color = "black", size = 0.5) +
  geom_col(aes(x = x5_offset,y = a1, fill = "α=1"), width = 0.4,
           color = "black", size = 0.5) +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text.x = element_text(size = 22, color = "black")) +
  theme(axis.text.y = element_text(size = 27, color = "black")) +
  # 设置字体样式
  theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 32)) +
  theme(axis.title.y = element_text(size = 25)) +
  # 设置label内容
  labs(y = "Time Duration (s)", x = NULL) +
  # ylabel位置
  theme(axis.title.y = element_text(hjust = 0.85)) +
  # 隐藏x轴label
  theme(axis.title.x = element_blank()) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = x3_offset,
                     labels = c("Linux", "Web", "Docker", "SimOS")) +
  scale_y_continuous(breaks = c(0, 200, 400, 600, 800),
                     labels = c(0, 200, 400, 600, 800)) +
  # 设置文本，hjust和vjust设置对齐基准点
  geom_text(aes(x = x1_offset, y = a0), hjust = 0,
            vjust = 0.5, label=a0, angle = 90, size = 9.5, nudge_y = 5) +
  geom_text(aes(x = x2_offset, y = a05), hjust = 0,
            vjust = 0.5, label=a05, angle = 90, size = 9.5, nudge_y = 5) +
  geom_text(aes(x = x3_offset, y = a07), hjust = 0,
            vjust = 0.5, label=a07, angle = 90, size = 9.5, nudge_y = 5) +
  geom_text(aes(x = x4_offset, y = a09), hjust = 0,
            vjust = 0.5, label=a09, angle = 90, size = 9.5, nudge_y = 5) +
  geom_text(aes(x = x5_offset, y = a1), hjust = 0,
            vjust = 0.5, label=a1, angle = 90, size = 9.5, nudge_y = 5) +
  # 图例
  scale_fill_manual(name=NULL, 
                    values=c("α=0" = "#AD0626",
                             "α=0.5" = "#B79AD1",
                             "α=0.7" = "#F2BE5C",
                             "α=0.9" = "#75B8BF",
                             "α=1" = "#2C3359"),
                    limits=c("α=0",
                             "α=0.5",
                             "α=0.7",
                             "α=0.9",
                             "α=1")) +
  # 图例位置
  theme(legend.position = c(0.7, 0.88)) +
  # 图例背景设置为空
  theme(legend.background = element_rect(fill = "transparent")) +
  # 图例大小
  theme(legend.text = element_text(size = 25)) +
  # 对数坐标轴
  # scale_y_log10() +
  # 图例每行元素个数
  guides(fill=guide_legend(ncol = 3, #根据ncol或者nrow设置图例显示行数或列数（设置一个即可）
                           byrow = T))#默认F，表示升序填充，反之则降序


# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 10, height = 3)
