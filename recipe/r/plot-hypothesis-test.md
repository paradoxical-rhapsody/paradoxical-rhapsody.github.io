+++
title = "Graph Hypothesis Test"
date = Date(2019, 02, 18)
tags = ["hypothesis test", ]
icon = "r-project"
+++


# 假设检验示意图: 使用 `geom_polygon`

```r
library(ggplot2)

alpha <- 0.05;
mu <- 2;
x <- seq(-7, 7, by=0.01);
y_0 <- dcauchy(x);
y_mu <- dcauchy(x, mu);
X <- data.frame(x, y_0, y_mu)
u_bound <- 4;

left_trit <- seq(x[1], -u_bound, by=0.01);
right_trit <- rev(-left_trit);

l_poly_x <- c(left_trit, rev(left_trit));
l_poly_y <- c(dcauchy(left_trit), numeric(length(left_trit)));
l_poly_ymu <- c(dcauchy(left_trit, mu), numeric(length(left_trit)));

r_poly_x <- c(right_trit, rev(right_trit));
r_poly_y <- c(dcauchy(right_trit), numeric(length(right_trit)));
r_poly_ymu <- c(dcauchy(right_trit, mu), numeric(length(left_trit)));

W_area <- data.frame(l_poly_x, r_poly_x, l_poly_y,
                     l_poly_ymu, r_poly_y, r_poly_ymu);

p <- ggplot(X, aes(x=x));
p <- p + geom_line(aes(y=y_0), size=I(0.6), color=I("red")) + 
         geom_line(aes(y=y_mu), size=I(0.6), color=I("blue"))
p <- p + geom_polygon(data=W_area, aes(l_poly_x, l_poly_y), color=I("red"), fill=I("red")) +
         geom_polygon(data=W_area, aes(r_poly_x, r_poly_y), color=I("red"), fill=I("red"))
p <- p + geom_polygon(data=W_area, aes(l_poly_x, l_poly_ymu), 
                      color=I("blue"), fill=I("blue"), alpha=0.4) +
         geom_polygon(data=W_area, aes(r_poly_x, r_poly_ymu),
                      color=I("blue"), fill=I("blue"), alpha=0.4)
print(p);
```