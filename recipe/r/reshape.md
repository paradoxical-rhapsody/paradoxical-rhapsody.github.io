+++
title = "✓ Reshape Data"
icon = "sticky-fill"
icon = "r-project"
tags = ["reshape", ]

link = "https://nbviewer.org/github/paradoxical-rhapsody/jupyterNBs/blob/master/211104-reshape.ipynb"
+++

# Reshape Data
*2021-11-04*

The repeated measurements in observed data can be orginazed as `wide` or `long` format:

* `wide`: the repeated measurements are arranged into sepearated columns of the same row.
* `long`: repeated measurements are arranged into sepearated rows of the same column.

Two ways to tranform the data between long and wide format are considered:

1. Built-in fuction `reshape` is qualified to the conversion.
2. Pkg `data.table` provide function `melt` (wide-to-long) and `dcast` (long-to-wide).


## `stats::reshape`

Let `DF` be a wide data, i.e.


```r
rm(list=ls())
set.seed(2021)
DF <- matrix(rnorm(3*9), 3) |> round(digits=2) |> data.frame()
colnames(DF) <- paste(rep(c('F', 'G', 'H'), each=3), c('a', 'b', 'c'), sep='.')

DF <- data.frame(ID=letters[1:3], DF)
show(DF)
```

```
##   ID   F.a   F.b  F.c   G.a  G.b   G.c   H.a   H.b   H.c
## 1  a -0.12  0.36 0.26  1.73 0.18 -1.84  1.48 -0.19 -1.62
## 2  b  0.55  0.90 0.92 -1.08 1.51  1.62  1.51 -1.10  0.11
## 3  c  0.35 -1.92 0.01 -0.27 1.60  0.13 -0.94  1.21 -1.46
```

In the cell below the `DF` is melted into a long table.


```r
varying <- list(
    c('F.a', 'G.a', 'H.a'),
    c('F.b', 'G.b', 'H.b'),
    c('F.c', 'G.c', 'H.c')
)

times <- c('F', 'G', 'H')

v.names <- c('a', 'b', 'c')
timevar <- 'method'

DF.long <- reshape(DF, direction='long', varying=varying, times=times, v.names=v.names, timevar=timevar)
show(DF.long)
```

```
##     ID method     a     b     c id
## 1.F  a      F -0.12  0.36  0.26  1
## 2.F  b      F  0.55  0.90  0.92  2
## 3.F  c      F  0.35 -1.92  0.01  3
## 1.G  a      G  1.73  0.18 -1.84  1
## 2.G  b      G -1.08  1.51  1.62  2
## 3.G  c      G -0.27  1.60  0.13  3
## 1.H  a      H  1.48 -0.19 -1.62  1
## 2.H  b      H  1.51 -1.10  0.11  2
## 3.H  c      H -0.94  1.21 -1.46  3
```


## `data.table::melt/dcast`


```r
library(data.table)
DT <- copy(DF) |> as.data.table()

DT.long <- melt(DT, id.vars='ID', 
    measure.vars=list(
        a=c('F.a', 'G.a', 'H.a'), 
        b=c('F.b', 'G.b', 'H.b'), 
        c=c('F.c', 'G.c', 'H.c')), 
    variable.name='method')

DT.long[method==1, method:='F']
DT.long[method==2, method:='G']
DT.long[method==3, method:='H']

show(DT.long)
```

```
##    ID method     a     b     c
## 1:  a      F -0.12  0.36  0.26
## 2:  b      F  0.55  0.90  0.92
## 3:  c      F  0.35 -1.92  0.01
## 4:  a      G  1.73  0.18 -1.84
## 5:  b      G -1.08  1.51  1.62
## 6:  c      G -0.27  1.60  0.13
## 7:  a      H  1.48 -0.19 -1.62
## 8:  b      H  1.51 -1.10  0.11
## 9:  c      H -0.94  1.21 -1.46
```


```r
show(dcast(DT.long, ID ~ method, value.var=c('a', 'b', 'c')))
```

```
##    ID   a_F   a_G   a_H   b_F  b_G   b_H  c_F   c_G   c_H
## 1:  a -0.12  1.73  1.48  0.36 0.18 -0.19 0.26 -1.84 -1.62
## 2:  b  0.55 -1.08  1.51  0.90 1.51 -1.10 0.92  1.62  0.11
## 3:  c  0.35 -0.27 -0.94 -1.92 1.60  1.21 0.01  0.13 -1.46
```

