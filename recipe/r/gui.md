+++
title = "GUI / Progressbar"
date = Date(2019, 02, 18)
icon = "r-project"
tags = ["gui", "progressbar", ]
+++

# 进度条 GUI

R 默认的进度条的函数为 `winProgressbar()`, 它的参数与 `tcltk::tkProgressBar()` 没有区别, 前者需要代码关闭, `tcltk` 本身有最大最小化的功能.

```r
# winProgressbar
N <- 30
pb <- winProgressBar("进度", "已完成 %", 0, N)
for(i in 1:N){
    Sys.sleep(0.1)
    info<- sprintf("进度%.1f%%", i*100/N)
    setWinProgressBar(pb, i, "进度", info)
}
close(pb)
```

```r
# tkProgressBar
library(tcltk)
N <- 30
pb <- tkProgressBar("进度", "已完成 %", 0, N)
for(i in 1:N){
    Sys.sleep(0.1)
    info<- sprintf("进度%.2f%%", i*100/N, 2)
    setTkProgressBar(pb, i, "进度", info)
}
close(pb)
```

在脚本文件中使用上述代码并通过 `source()` 载入时, 会出现 `multibyte string` 错误, 原因在于进度条参数中有中文, 可通过指定 `source(encoding="utf-8")` 解决. 不过还是尽量避免在脚本内使用中文, 不然惊喜不断.

R 的 `tcltk` 和 `tcltk2` 能快速设计 GUI, 前者是内置的. `tcltk2` 目前没有进度条, 但是示例中有很多很棒的功能.
