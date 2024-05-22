rm(list = ls())

exp = "exp7"
exportPath = "C:/Users/YangJingyuan/Desktop/"
exportName = "uk.pdf"

root = "D:/RProject/tmp"
setwd(sprintf("%s/%s", root, exp))

library(ggplot2)
library(readxl)
library(extrafont)
# library(showtext)

# font_add('Arial','C:/Windows/Fonts/arial.ttf')
# showtext_auto()

exchangeRate= c(2.359856,
                1.978064,
                2.097744,
                2.2328,
                1.717648,
                2.471056,
                3.848944,
                4.427056,
                4.002368,
                4.538432,
                4.471904,
                3.638944,
                4.981552,
                4.869888)

inflation= c(2.5,
             3.8,
             2.6,
             2.3,
             1.5,
             0.4,
             1,
             2.6,
             2.3,
             1.7,
             1,
             2.5,
             7.9,
             6.8)

xline <- numeric(14)
for (i in 1:14){
  xline[i] = 2009 + i
}


# 禁止科学计数法
options(scipen = 999)

# 设置字体
# windowsFonts(Arial=windowsFont("Arial"))
#绘图
ggplot() + 
  # 坐标轴显示范围
  coord_cartesian(xlim =c(2010.5, 2022.5), ylim = c(0.3, 8)) +
  # 折线
  geom_line(aes(x=xline,y=exchangeRate), color="#AD0626", size=3) + 
  geom_line(aes(x=xline,y=inflation), color="#2C3359", size=3) + 
  # 散点
  geom_point(aes(x=xline,y=exchangeRate), color = "#AD0626", 
             size = 5) +
  geom_point(aes(x=xline,y=inflation), color = "#2C3359", 
             size = 5, shape = "X") +
  # 白底，没有上边框和右边框
  theme_classic() +
  # 设置坐标轴上字体大小
  theme(axis.text = element_text(size = 20, color = "black")) +
  # 设置字体样式
  # theme(text = element_text(family = "Arial")) +
  # 设置label字体大小
  theme(axis.title.x = element_text(size = 25)) +
  theme(axis.title.y = element_text(size = 25)) +
  # 设置label内容
  labs(x = "Years") +
  # ylabel位置
  # theme(axis.title.y = element_text(hjust = 1.1)) +
  # 设置刻度内容及位置
  scale_x_continuous(breaks = c(2010, 2011, 2012, 2013,
                                2014, 2015, 2016, 2017,
                                2018, 2019, 2020, 2021, 
                                2022, 2023),
                     labels = c(2010, 2011, 2012, 2013,
                                2014, 2015, 2016, 2017,
                                2018, 2019, 2020, 2021, 
                                2022, 2023)) +
  # 设置Y轴以及双Y轴
  scale_y_continuous(breaks = c(0, 2.5, 5, 7.5, 10),
                     labels = c(0, 2.5, 5, 7.5, 10),
                     name = "Inflation (%)", 
                     sec.axis = sec_axis(~./16 + 0.5, name = "Exchange Rate (%)"))

# 保存文件
ggsave(paste(exportPath, exportName, sep=""), plot = last_plot(), width = 12, height = 5)
