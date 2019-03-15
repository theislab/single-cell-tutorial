# This script plots extended view figure 1.

library(ggplot2)

data <- read.table("../HVGs.csv", header=T, sep=';')
data$Log.Cell.Number = log(data$Cells, 10)

image=ggplot(data, aes(x=Log.Cell.Number, y=HVGs, color=Technology.type)) +
geom_point() +
labs(x="Log 10 Number of Cells", y="Number of HVGs", color="Technology type") +
theme_bw()

ggsave("HVG_plot.svg", plot=image)
