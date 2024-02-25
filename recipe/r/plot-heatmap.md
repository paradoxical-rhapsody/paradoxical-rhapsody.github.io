+++
title = "Heatmap"
date = Date(2019, 02, 18)
icon = "r-project"
tags = ["heatmap", ]
+++

# Heatmap

直接使用 `image()` 或 `heatmap()` 绘制矩阵时, 图像不直接对应矩阵本身的行列位置, 可改为 `image(t(X)[, nrom(X):1])` 或者直接使用 `Matrix::image(Matrix::Matrix(X))`. 


* `melt()` 是 `reshape2` 中的一个主要函数, 可将数据框(矩阵)按照指定变量(通常是因子变量)进行融化, 恰好可用于 `ggplot2` 绘制热力图的数据格式要求.
* `ggplot2` 用到的数据必为 `data.frame`.
    
```r
library(ggplot2)
library(reshape2)
library(dplyr)

set.seed(1213)
mat <- matrix(rnorm(8000), nc=100)
mat <- melt( t(mat) %*% solve(mat %*% t(mat)) %*% mat )
p <- ggplot(data=mat, aes(x=Var1, y=Var2)) +
     geom_tile(aes(fill=value)) +
     theme_classic() +
     theme(axis.ticks = element_blank(),
     axis.line = element_blank()) +
     xlab('') +
     ylab('') +
     scale_x_discrete(1:10, breaks = 1:10) +
     scale_y_discrete(1:10, breaks = 1:10) +
     scale_fill_gradient2('legend name', low = 'white',
                          high = 'red', mid='pink')
print(p) 
```

