+++
title = "Lasso Graph (3D)"
date = Date(2019, 02, 18)
icon = "r-project"
tags = ["lasso", ]
+++

# Lasso 示意图

```r
library(rgl)

f <- function(x, y)(x-7)^2/10 + (y-2)^2/4 + 5

s <- 2
yl <- xl <- seq(-s, s, by=0.1)
z0 <- outer(xl, yl, function(x, y){0*x*y})
z1 <- outer(xl, yl, f)
surface3d(xl, yl, z0, col="cyan", alpha=0.8)
surface3d(xl, yl, z1, col="green", alpha=0.5)

x <- seq(-3, 13, by=0.1)
y <- seq(-3, 7, by=0.1)
z <- outer(x, y, f)
surface3d(x, y, z, col="red", alpha=0.4)

points3d(7, 2, 0, size=10, col="red")
theta <- seq(0, 2*pi, by=0.01)
for(a in c(1, 3, 5)){
  color <- "black"
  if(a == 5)color <- "cyan"
  lines3d(7+a*cos(theta), 2+2*a/sqrt(10)*sin(theta), rep(0, times=length(theta)), lwd=0.7, col=color)
}

tranAxes <- matrix(c(1, 1, 0, -1, 1, 0, 0, 0, 1), nc=3)
abclines3d(0, 0, 0, a=tranAxes)

abclines3d(x=c(2, -2, -2, 2), y=c(2, 2, -2, -2),
           z=rep(0, times=4), a=c(0, 0, 1), col="cyan")

```