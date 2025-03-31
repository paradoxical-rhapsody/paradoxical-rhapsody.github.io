+++
title = "Venn Diagram"
date = Date(2022, 4, 24)
icon = "r-project"
tags = ["venn", ]
+++

# Venn Diagram

```r
rm(list=ls())
library(data.table)
set.seed(2022)
n <- 100

DT <- data.table(
    value = sample(letters, n, TRUE),
    X = rbinom(n, 1, 0.3) == 1,
    Y = rbinom(n, 1, 0.2) == 1,
    Z = rbinom(n, 1, 0.4) == 1, 
    U = rbinom(n, 1, 0.4) == 1
)


library(VennDiagram)
# grid.newpage()
draw.triple.venn(area1 = DT[X==1, .N], 
                 area2 = DT[Y==1, .N], 
                 area3 = DT[Z==1, .N], 
                 n12 = DT[X==1 & Y==1, .N], 
                 n23 = DT[Y==1 & Z==1, .N], 
                 n13 = DT[X==1 & Z==1, .N], 
                 n123 = DT[X==1 & Y==1 & Z==1, .N], 
                 category=c("X","Y","Z"),
                 fill=c("Orange","Pink","Blue"), 
                 col="Red",lty='dashed', lwd=1)


library(gplots)
venn(DT[, -1])


library(ggvenn)
ggvenn(DT, c("X", "Y", "Z", "U"))


library(ggVennDiagram)
DTv <- sapply(c('X', 'Y', 'Z', 'U'), function(x) DT[get(x) == 1, value])
ggVennDiagram(DTv)
```
