+++
title = "R"
icon = "r-project"
toc_sidebar = true
base = "recipe/r"
+++


@@log
* 生态、社区和应用场景都相当成熟.
* 即便用 \link{Armadillo}{http://arma.sourceforge.net/} 加速, 它在矩阵变量相关的计算中依旧效率不足.
@@


# R

## Ecosystem / Pkgs

"data.table", "glue", "xtable", "Rcpp", "RcppArmadillo", "knitr", "devtools", 

"tikzDevice", "Cairo",

"glmnet", "brglm2", "betareg", 

"PLFD", "PPSFS",

-----

\link{TaskViews::WebTechnologies}{https://cran.r-project.org/web/views/WebTechnologies.html} 有 `publications` 模块可直接调用各出版商和文献的元数据.



## Sources

{{ show_md_list }}



## Tips

\list


\item{ [2025-04-25] `rmarkdown` 依赖 `tinytex`, 即使不使用 `tinytex` 作为系统上的 TeX 编译环境, 也需要安装它.}


\item{ [2025-04-25] Ubuntu 上在 Rstudio 和 Terminal R 中的 `Sys.getenv("PATH")` 结果不同. Rstudio 包含了从 `/etc/environment` 中读取的全局环境变量, 也从目前尚未确定的位置载入了一些环境变量.}


\item{ [2025-03-07] `knitr` 的 `child` 文件默认路径是自身所在位置处, 但是生成 `tex` 是在主文件的位置处. 如果其中涉及文件读取 (比如 `\includegraphics / \csvreader`), 就需要将 `child` 文件的生成的各种数据放在主文件可直接读取的路径下, 可在 `child` 文件开始加入设置:
```bash
<<include=FALSE>>=
knitr::opts_knit$set(root.dir=dirname(getwd()))
@
```
}


\item{ [2025-03-05] `knitr` 设置代码块渲染时不额外添加环境 (保持原封不动输出)和头文件插入位点:

```bash
%% knitr settings

<<setup, include=FALSE>>=
rm(list=ls())
# options(width=105)
library(magrittr)
library(data.table)
library(MASS)
library(knitr)

knit_patterns$set(header.begin="%% knitr settings\n")
opts_chunk$set(comment="", fig.path="tikzexternalization")

opts_chunk$set(raw=FALSE)
hook_chunk <- function(x, options) ifelse(options$raw, x, hooks_latex()$chunk(x, options))
hook_output <- function(x, options) ifelse(options$raw, x, hooks_latex()$output(x, options))
knit_hooks$set(chunk=hook_chunk)
knit_hooks$set(output=hook_output)

baseDir <- "tikzexternalization"
@
```
}


\item{ [2025-02-26] knitr 的代码块里中文显示为 <U+XXXX>, 需要在文档中设置 
```bash
Sys.setlocale("LC_ALL", "zh_CN.UTF-8")
```
此外可通过 `Sys.getlocale()` 查看当前环境的区域语言, 各操作系统的终端也支持 `locale` 直接查看.
}


\item{ [2024-12-23] 在 Win 下使用 `devtools::build(binary=TRUE)` 时抛出 `Rcmd.exe` 找不到的错误, 按照 `CRAN` 的文档推荐的 [build binary package](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Building-binary-packages) 的操作如下:
```bash
R CMD build pkg
R CMD INSTALL --build pkg # `pkg` 可以为 tar.gz 或在源文件夹下
```
}


\item{ \delete{[2024-11-10]}[2025-03-05 有更恰当的方案] `knitr` 的 `1.46 & 1.47` 版在执行带有 `knitr::knit_hooks$set(hooks_markdown(fence_char=""))` 的 `Rnw` 文件时会卡顿, 目前退回 `1.45` 没有问题.
}

\item{ \delete{[2024-06-24]}[2025-03-05 有更恰当的方案] `knitr` 输出代码块时有它私有的环境. 如果不想要这些环境, 只希望**保留原样输出不添加额外修饰**, 可在 `Rnw` 中添加预设置: 
```bash
<<setup, include=FALSE>>=
rm(list=ls())
library(knitr)

# options(width=105)
knitr::knit_hooks$set(hooks_markdown(fence_char=""))
knitr::opts_chunk$set(echo=FALSE, comment="")
@
```

`opts_chunk$set` 中有很多值得注意的设置, 如 `fig.width / fig.height / size (="scriptsize")`.
}

\item{ \delete{[2024-06-21]}[2025-03-05 有更恰当的方案] `knitr` 处理 `Rnw` 时会在输出的 `tex` 文档中很快插入一段自定义环境, 过程很呆, 甚至不能识别 `\documentclass` 的多行结构还没有结束就插入新环境了. 

[解决方案](https://stackoverflow.com/questions/57618641/how-to-stop-knitr-from-adding-tex-packages-based-on-documentclass): `knitr` 插入的头文件是通过 `knitr:::make_header_latex` 进行的, 把它屏蔽掉就好了.
```bash
assignInNamespace("make_header_latex", function(...) "", "knitr")
```

这很适合添加在 `vscode` 的链式编译中:
```bash
{
    "name": "rnw2tex",
    "command": "Rscript",
    "args": [
        "-e",
        "assignInNamespace('make_header_latex', function(...)'', 'knitr'); knitr::knit('%DOCFILE_EXT%')"
    ],
    "env": {}
}
```

然后在 `Rnw` 合适的位置插入 `knitr` 默认设定对 `tex` 添加的内容. 当前版本的内容如下:
```tex
\usepackage[]{graphicx}
\usepackage[]{xcolor}
% maxwidth is the original width if it is less than linewidth
% otherwise use linewidth (to make sure the graphics do not exceed the margin)
\makeatletter
\def\maxwidth{ %
  \ifdim\Gin@nat@width>\linewidth
    \linewidth
  \else
    \Gin@nat@width
  \fi
}
\makeatother

\definecolor{fgcolor}{rgb}{0.345, 0.345, 0.345}
\newcommand{\hlnum}[1]{\textcolor[rgb]{0.686,0.059,0.569}{#1}}%
\newcommand{\hlstr}[1]{\textcolor[rgb]{0.192,0.494,0.8}{#1}}%
\newcommand{\hlcom}[1]{\textcolor[rgb]{0.678,0.584,0.686}{\textit{#1}}}%
\newcommand{\hlopt}[1]{\textcolor[rgb]{0,0,0}{#1}}%
\newcommand{\hlstd}[1]{\textcolor[rgb]{0.345,0.345,0.345}{#1}}%
\newcommand{\hlkwa}[1]{\textcolor[rgb]{0.161,0.373,0.58}{\textbf{#1}}}%
\newcommand{\hlkwb}[1]{\textcolor[rgb]{0.69,0.353,0.396}{#1}}%
\newcommand{\hlkwc}[1]{\textcolor[rgb]{0.333,0.667,0.333}{#1}}%
\newcommand{\hlkwd}[1]{\textcolor[rgb]{0.737,0.353,0.396}{\textbf{#1}}}%
\let\hlipl\hlkwb

\usepackage{framed}
\makeatletter
\newenvironment{kframe}{%
 \def\at@end@of@kframe{}%
 \ifinner\ifhmode%
  \def\at@end@of@kframe{\end{minipage}}%
  \begin{minipage}{\columnwidth}%
 \fi\fi%
 \def\FrameCommand##1{\hskip\@totalleftmargin \hskip-\fboxsep
 \colorbox{shadecolor}{##1}\hskip-\fboxsep
     % There is no \\@totalrightmargin, so:
     \hskip-\linewidth \hskip-\@totalleftmargin \hskip\columnwidth}%
 \MakeFramed {\advance\hsize-\width
   \@totalleftmargin\z@ \linewidth\hsize
   \@setminipage}}%
 {\par\unskip\endMakeFramed%
 \at@end@of@kframe}
\makeatother

\definecolor{shadecolor}{rgb}{.97, .97, .97}
\definecolor{messagecolor}{rgb}{0, 0, 0}
\definecolor{warningcolor}{rgb}{1, 0, 1}
\definecolor{errorcolor}{rgb}{1, 0, 0}
\newenvironment{knitrout}{}{} % an empty environment to be redefined in TeX

\usepackage{alltt}
```
}

\item{ [2024-05-24] `sub` 的 `fixed=TRUE` 不使用通配符做匹配, 是很棒的参数. }


\item{ [2024-05-04] `latex-workshop` 编译 `Rnw` 文件时总是报 `Latexmk: No file name specified`, 现在确定是 `Latex > External > Build: Command` 里添加了 `latexmk` 这个多余的东西! (要理解配置说明啊)

另外, 可以把 `tools` 中 `rnw2tex` 的 `knit` 改为 `knit2pdf`, 这样 `recipe` 里可以相应简化.
}


\item{ [2024-04-15] `knitr` 的全局选项设置：
```R
%% knitr options
<<setup, include=FALSE>>=
rm(list=ls())
options(width=70)
knitr::opts_chunk$set(
    size="scriptsize",
    fig.align = "center", 
    fig.path = "figures/",
    fig.width = 6, 
    fit.height=6,
    out.width = ".45\\linewidth"
)
@
```
}


\item{ 
[2023-10-04] 从**源文件**编译安装 `R` 时的依赖可以快速解决:
```bash
sudo sed -i.bak "/^#.*deb-src.*universe$/s/^# //g" /etc/apt/sources.list
sudo apt update
sudo apt build-dep r-base
```  
  
[2023-10-03] R-4.3.1 没有提供安装源, 目前用 rstudio 提供的 `deb` 文件或者**源文件**安装. 

**源文件配置/编译/安装**时遇到的依赖:
```bash
sudo apt-get install build-essential
sudo apt-get install fort77
sudo apt-get install xorg-dev
sudo apt-get install liblzma-dev  libblas-dev gfortran
sudo apt-get install libbz2-dev
sudo apt-get install gcc-multilib
sudo apt-get install gobjc++
sudo apt-get install aptitude
sudo apt-get install libreadline-dev
```
}


\item{ [2023-09-03] `split-by-combine`

```bash
set.seed(2023)
library(data.table)
library(microbenchmark)

DT <- data.table(x=matrix(rnorm(1000*4), 1000), g=sample(letters[1:6], 1000, TRUE))
names(DT) <- sub("[.]V", "", names(DT))

microbenchmark(
    M11 = DT[, lapply(.SD, mean), by=g], 
    M12 = DT[, colMeans(.SD), by=g], 
    M2 = aggregate(DT[, -c("g")], by=DT[, "g"], "mean"), 
    M3 = lapply(split(DT[, -c("g")], DT[, g]), colMeans),
    M4 = by(DT[, -c("g")], DT[, g], colMeans)
)

```
}

\item{ [2023-09-01] 管道操作 `%>%` 的链式对象是函数, 不是组合函数, 例如 `"A" %>% rep(c(., "B"), 3)` 是不奏效的, 准确形式是 `"A" %>% c(., "B") %>% rep(., 3)` }

\item{ [2023-08-31] `backsolve(mat(4, 4), vec(6))` 不报错!!! 它根本不检查矩阵和向量的维数是否匹配... }


\item{ [2023-08-15] 
```plaintext
set_f <- function(n, p) {
    A <- .row(c(n, p))
    # f <- function(x) x * get("A", envir=parent.frame())
    f <- function(x) x * A

    return(f)
}

A <- matrix(rnorm(3*5), 3)
f <- set_f(3, 4)
```
}


\item{ [2023-07-13] 正则表达式: (移除不是字母或数字的内容) `gsub("[^[:digit:][:alpha:]]", "", x)` }


\item{ [2023-07-02] 从 pdf 文件中提取内容 (文字/表格)

* `tabulizer::extract_tables / extract_text / extract_areas / extract_metadata` is quite easy and flexible to extract the contents.

* `pdftools::pdf_text` extracts the contents in all pages. For each page, the content splitted by `\n` can be anchored by the column positions, then it is rather easy to extract the column data using `substr` and regex (`data.table` is helpful)

* `tesseract` is heavy but powerful for OCR (maybe it is applicable to scanned files)
}


\item{ [2023-05-02] `Reduce` 能把二元函数 `f(x, y)` 通过序贯方式拓展到一般数量上.

* inner-join: `Reduce(merge, list(DTx, DTy, DTz))`. 
* full-join: `Reduce(\(...) merge(..., by, all), list(DTx, DTy, DTz))`
* 需要显示指定拼接键 `by` 才能避免它添加 `suffix` 前缀: `Reduce(\(...) merge(..., by=intersect(names(..1), names(..2))), list(DTx, DTy, DTz))`
* **注意:** 如果拼接结构为 `merge(x, rbind(y1, y2))`, 那就不能使用 `Reduce(merge, list(x, y1, y2))`. 这是因为如果 `x` 中的某些样本在 `y2` 中时, 在 `merge(x, y1, fill=TRUE)` 时会将这部分样本填充为 `NA`, 此时再对 `y2` 进行拼接时, 两者重复的样本由于取值差异, `y2` 中的样本会被重新分配列名.

* bind: `Reduce(rbind, list(matrix))`
}

\item{ [2023-03-08] `deparse` 将表达式逆向操作转为字符串 (可以用来获取变量的名字). }

\item{ [2023-02-07] `glmpath` 不能移除截距项, `glmnet` 就能. 而且 `glmpath` 适用的模型少多了.}

\item{ [2023-02-04] 移除向量元素名: `c(x, use.names=FALSE)`}

\item{ [2023-02-04] RcppArmadillo 的 `uvec` 用法:

```bash
//' @rdname center.samples
//' @export
// [[Rcpp::export]]
arma::cube cxx_center_data (const arma::vec & y, const arma::cube & x) {
    int n=x.n_slices, r=x.n_rows, c=x.n_cols, iN ;
    arma::cube x0(r, c, n, arma::fill::zeros) ;
    arma::uvec idx01=arma::find(y == 1.0), idx02=arma::find(y == 2.0) ;
    arma::mat m1 = arma::mean(x.slices(idx01), 2) ;
    arma::mat m2 = arma::mean(x.slices(idx02), 2) ;
    for (iN=0; iN < n; iN++) {
        if (y(iN) == 1.0)
            x0.slice(iN) = x.slice(iN) - m1 ;
        else 
            x0.slice(iN) = x.slice(iN) - m2 ;
    }
    return x0 ;
}
```
}


\item{ [2023-01-08] 计算 `logLik` 时 (AIC/BIC), 尽可能避免自己写公式, 务必优先使用内置函数.

```bash
mu <- drop(x %*% b.hat)
nullmodel <- lm(y ~ 0, offset=mu)
bic <- -2*logLik(nullmodel) + log(N)*dof
aic <- -2*logLik(nullmodel) + 2*dof
```
}



\item{ [2022-12-20] 在 Ubuntu 的 terminal 中打开帮助文档时, 如果直接打印在终端里, 可以对 `help` 添加 `help_type="html"` 参数, 在浏览器中打开. 在 `Rprofile.site` 中添加如下选项可更改全局设置:

```bash
options(help_type="html")
```
}



\item{ [2022-11-26] Ubuntu 下安装 `RcppArmadillo` 等 R 包时, 提示缺少 `-llapack` / `lblas` / `-lgfortran` 时, 或缺少一些系统文件:

```bash
sudo apt-get install g++ gfortran libblas-dev liblapack-dev libssl-dev libxml2-dev libz-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev 
```
}


\item{ [2022-10-20] **服务器安装 Rstudio Server**:
1. 需要先安装 \link{r-base}{https://cran.r-project.org/bin/linux/}.
2. 根据系统类型\link{选择相应系统的最新版本安装命令}{https://www.rstudio.com/products/rstudio/download-server/}, 结尾会有绿色的 `active` 提示.
3. Rstudio server 默认端口是 8787, 需在防火墙中开启. 可在它的设置文件中修改.

**注意**: Rstudio server 只能通过**非管理员**账户作登录 (若没有, 可执行 `sudo adduser xxx` 添加新用户).
}


\item{ 关于 `system.time()`:
* 它的第二个参数 `gcFirst=TRUE` 默认发生. 此前在 `repFun(ss, ...)` 最后写入 `data.table` 时发生的错误有可能就是因为 `system.time()` 的回收机制造成的. 
* 返回的三个时间中, 第一个 CPU 时间是我们通常需要的. 在并行中, 平台对最后一项 eslapse 时间影响很大, 这是额外开销 (IO / 通信等) 造成的.
}

\item{ R 包 `eggkit` 包含了 EGG Data ($256 \times 64$), 不过这个数据集有小问题. }

\item{ `Rcpp` 创建包

把要打包的数据和 R 编写的函数(不包括 C++ 定义的那些函数, 否则第一步就会报错)都放进内存中, 以下命令将生成一个架构很全面的文件夹 `test`:
```r
library(Rcpp)
Rcpp.package.skeleton("test", list=ls(), cpp_files=c("1.cpp", "2.cpp"), example_code=FALSE)
```
R 函数如果不导入内存的话, 可使用参数 "R_files".


`test/man` 中只包含了 R 函数和数据的 "Rd" 文件, 还有 `cpp` 文件中的函数需要手动生成 "Rd" 文件:
```r
rm(list=ls())
sourceCpp("1.cpp")
sourceCpp("2.cpp")
for(fun in ls()){
  prompt(fun)
}
```
}

\item{ `require()` 和 `library()` 的区别

  两者的帮助文档被归在同一页面中, 文档指出 `require()` 在导入一个不存在的包时, 会输出一个 `warning` 并返回 `FALSE`, 不因为导入失败而终止程序, 所以适合放在函数中. `library()` 在导入失败时会抛出 `error`. 
  
  在 \url{https://stackoverflow.com/questions/5595512/what-is-the-difference-between-require-and-library} 上给出了这两者的区别和使用技巧. 
  
  在 \url{https://www.r-bloggers.com/library-vs-require-in-r/} 上有人反对用 `require()` 执行导入. 如果就为了导入一个包, 用 `library()` 会有效规避所有意外. `require()` 可以用在一些更基础的程序中, 比如包的编写中或者为了在导入失败时自动安装等情况下使用.

```r
if(require("lme4")){
  print("lme4 is loaded correctly")
} else {
  print("trying to install lme4")
  install.packages("lme4")
  if(require(lme4)){
    print("lme4 installed and loaded")
  } else {
    stop("could not install lme4")
  }
}

for (package in c('PLFD', 'PPSFS')) {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package)
    library(package, character.only=T)
  }
}
```
}

\item{ 计算结果为 `NaN` 可能是得到了 $Inf/Inf$ 或者 $Inf - Inf$. 例如, 在计算 sigmoid 函数 $S(\beta, x) = \frac{1}{1 + exp(- x' \beta)}$ 的梯度或 Hessian 时, 需要计算 $\frac{exp(- x' \beta)}{(1+exp(- x' \beta))^2}$ 或 $\frac{exp(- x' \beta) (1 - exp(- x' \beta))}{(1+exp(- x' \beta))^3}$, 当 $x' \beta$ 很大就会返回 `NaN` (这个在高维下太容易发生了), 这时候需要对式子进行整理清洗.}

\item{ 绘图参数带有中文时, 提示找不到字体或字体不显示, 较好且简洁的方案 `showtext` 包:
```r
library(showtext)
showtext.auto(enable=TRUE)
font.add('SimSun', 'simsun.ttc')

pdf("text.pdf")
plot(c(1:10), xlab="横轴", ylab="纵轴",
      main="中文标题 title", family="SimSun")
dev.off()
```
}

\item{ 安装 `IRkernel` 提示 \emph{kernel --version} 不能验证: 原因是在安装 `Anaconda/Miniconda` 时没有勾选添加环境变量 (提示说如果勾选会遇到一些问题), 导致安装失败. 可以手动添加环境变量后重新安装 `IRkernel`, 然后再把环境变量删掉.}

\item{ [2022-03-19]
  对 `egg <- brglmFit(...)` 进行 `class(egg) <- 'glm` 后, `BIC(egg)` 确实就是标准的 BIC, 它等于
  ```r
  -2*logLik(egg) + attr(logLik(egg), 'df) * log( attr(logLik(egg), 'nobs') )
  ```
  注意 `attr(logLik(egg), 'df')` 在 `gaussian` 等情况下比线性预测器的系数数量多 1 (存在散布参数), 在 `logistic / Poisson` 等情形 下与预测器的变量数目相同.
  
  因此可以直接利用 `BIC(egg) + ebic.penalty` 得到 EBIC 的取值. 这里 `ebic.penalty = 2 * gamma * lchoose(P, s)`, **需要仔细确认** `P` 和 `s` 的取值 (根据 EBIC 的原始想法).
}

\item{ [2022-02-02]
  迭代循环中涉及 `svd` 时抛出了 `Error in La.svd(x, nu, nv) : error code 1 from Lapack routine 'dgesdd'` 错误. 目前测试良好的方式是工具包提供的函数, 但计算速度相对较慢, 将原生函数和工具函数结合使用如下:
  ```r
  tryCatch(svd(x), error=function(e) svd::propack.svd(x))
  ```
}


\item{ [2021-10-30]
  写包的时候，所有的 `import` 都可以放在 `*-package.R` 里面，不必分散在各个函数中。
}

\item{ [2021-09-30]
  使用 `for(i in 1:length(x))` 或 `for(i in seq(x))` 得到的索引序列都有问题：
  * \emph{最保险的方式是 `seq_along(x)` 或 `seq_len(k)`.}
  * 当 `x <- c()` 时, `1:length(x)` 和 `seq(length(x))` 都会得到 `1:0`.
  * 当 `x <- c(22)` 时, `seq(x)` 会得到 `1:22`（不是 `1`）.
}

\item{ [2021-08-24]
  在模拟计算中，生成的 `X` 如果不是中心化的，建议添加一步 `scale` 操作。一个例子是，在模拟 `binomial/poison` 的模型中，如果使用偏态数据（例如 $\chi^2(4)$）和非负系数生成 $\eta$，此时 `family$linkinv(eta)` 在 `binomial` 下全为一。
}


\item{ [2021-07-01] 内置函数 `boxplot` 的 `group-by` 用法：
```r
A1 <- c(1,2,9,6,4)
A2 <- c(5,1,9,2,3)
A3 <- c(1,2,3,4,5)
B1 <- c(2,4,6,8,10)
B2 <- c(0,3,6,9,12)
B3 <- c(1,1,2,8,7)

DF2 <- data.frame(
  x = c(c(A1, A2, A3), c(B1, B2, B3)),
  y = rep(c("A", "B"), each = 15),
  z = rep(rep(1:3, each=5), 2),
  stringsAsFactors = FALSE
)
str(DF2)
# 'data.frame': 30 obs. of  3 variables:
#  $ x: num  1 2 9 6 4 5 1 9 2 3 ...
#  $ y: chr  "A" "A" "A" "A" ...
#  $ z: int  1 1 1 1 1 2 2 2 2 2 ...

cols <- rainbow(3, s = 0.5)
boxplot(x ~ z + y, data = DF2,
        at = c(1:3, 5:7), col = cols,
        names = c("", "A", "", "", "B", ""), xaxs = FALSE)
legend("topleft", fill = cols, legend = c(1,2,3), horiz = T)
```
}

\item{ [2021-06-30] `sub` 替换字符串时，只能替换第一个匹配到的内容。用 `gsub` 可以替换所有匹配到的内容。}

\item{ [2021-60-30] 把正则表达式匹配的内容替换成指定内容：
```r
# replace the `0.1=0.1` with `rho=0.1` in file names
gsub('([[:digit:].]{3})[.]csv', '#rho=\\1.csv', resultFiles)
```
}

\item{ [2021-06-08] `message(Sys.time())` 比 `print(Sys.time())` 更加干净. }

\item{ [2021-05-10] 禁用 rstudio 的内置帮助浏览器: 注释掉 `R/Options.R` 里如下内容
```R
# .rs.setOption("browser", function(url)
# {
#    .Call("rs_browseURL", url, PACKAGE = "(embedding)")
# })
```
}

\item{ [2021-05-10] 禁用 rstudio 的绘图窗口: 修改 `R/Tools.R` 里的如下内容
```R
.rs.addFunction( "initGraphicsDevice", function()
{
    # options(device="RStudioGD")
    # grDevices::deviceIsInteractive("RStudioGD")
grDevices::deviceIsInteractive()
})
```
}

\item{ [2021-04-28] 关于 `write.table` 在 simulation 中 `repFun` 中的示范用法
```R
write.table(result, file=savefile, append=file.exists(saveFile), sep=',', row.names=FALSE, col.names=!file.exists(saveFile),  fileEncoding='UTF-8')
```
}

\item{ [2021-06-07] `na.fail(x)` / `complete.cases(y, x)` 可以用来检查数据中的缺失值. }

\item{ [2021-04-23] `data.table` 的变量名通过管道更新时，尽量直接改变到 `data.table` 上面, 不要将结果保存到 `cnames` 然后用 `names(DT) <- cnames`。在逐行测试脚本时，如果做了 `setcolorder` 操作，如果手误重执行了 `names(DT) <- cnames`，变量名字就混乱了，相应的属性也不匹配了。 }

\item{ [2021-04-22] `R` 里的短路运算 `&&` 和 `||` 在使用时, 如果两边都是向量，帮助文档中指出只有第一个元素参与运算，返回值是**标量**. }

\item{ [2021-04-17] 数值模拟在保存模拟结果时，要保持紧凑一致。如果最后需要补充一些分析内容（添加图像），这样有极大便利！ }

\item{ [2021-04-09] 关于文件和路径的截取、拼接等操作, 一定使用内置方法（可靠、简洁且跨平台，太省心了）。
```R
file.path(dirname(saveDir), saveFile)
```
}

\item{ [2021-03-12] `identical(c(r0, c0), dim(x))` 返回 `FALSE`，因为前者是简单向量，后者有额外属性。可以用 `all.equal` 仅对数值进行比较。 }

\item{ [2021-03-07] `slurm` 任务里如果其中载入了 `anaconda` 虚拟环境进行计算，那就需要先激活虚拟环境，在环境中进行 `sbatch` 才可以。 }

\item{ [2021-02-25] `R / Julia` 的幂运算都是后缀操作符，`2^3^2 = 2^(3^2)`。`Matlab` 是前缀操作符 `2^3^2 = (2^3)^2`。 }

\item{ [2021-02-24] `mathjaxr` 渲染帮助文档效果优秀。注意：每个用到的文档都需要在 `description` 添加 `\loadmathjax`。 }

\item{ [2021-02-20] 
  * pkg 里有 `cpp` 时, 在 `check` 的时候如果 `cpp` 函数抛出了 `undocumented/documented` 这种文档信息警告, 那就是改动了 `cpp` 函数的文档信息, 但是忘记 `compileAttributes` 了。
  * 如果一个 `rdname` 包含的所有函数都没有用到某个 `param`, `check` 的时候会对排在最后的那个函数抛出一个警告, 表明参数没有被这个函数使用.
  * **为了尽可能避免这两个问题，在 `check` 之前执行一遍 `compileAttributes() / document()`，不要偷懒！**
}

\item{ [2021-02-04] `data.table` 的 `DT` 在语法一致性上很好, 但是 `DT[, fun(.SD)]` 的效率没有优势。一个 `287 x 20532` 的 `DT`, 测试维数
```R
> microbenchmark(DT[, dim(.SD)], dim(DT), times=10)
Unit: nanoseconds
        expr        min         lq       mean     median         uq        max neval
DT[, dim(.SD)] 1999441400 2029103400 2070402640 2057064800 2088228700 2160831800    10
        dim(DT)        800       1100       6570       8900       9900      13300    10


> microbenchmark(DT[, sum(sapply(.SD, sd))], sum(sapply(DT, sd)), times=10)
Unit: milliseconds
                    expr       min        lq      mean    median        uq       max neval
DT[, sum(sapply(.SD, sd))] 2242.2378 2274.5062 2442.1339 2346.2941 2473.6010 2963.7093    10
        sum(sapply(DT, sd))  159.6909  179.8594  208.0267  196.3342  226.7658  313.3951    10
```
}

\item{ [2020-12-10] 模拟的几个规范点: 
  * `repFun` 里用 \delete{`data.table::fwrite(DT, file=savefile, append=file.exists(savefile))` 保存}。在 `DT` 中, 它的 `names` 直接由各种模拟方法提供（所以模拟方法的返回值的名字要细心设计）。在两次大规模计算中, `fwrite` 总是出现个别漏写 (这在小型计算中倒是可以补救), 以后改用 `write.table`, 还能减少一个依赖。
  * 由于样本量和维数等可能不断变化, 在保存模拟结果时, 文件名需要包含模拟设定的详细信息。
  * [2020-11-13] 生成的数据中, 记得进行精度验证: `ifelse(A > .Machine$double.eps, A, 0.0)`
}

\item{ [2020-12-07] `duplicated` 和 `unique` 的作用: 前者找出重复/不重复的记录后, 可以对记录里的其他变量操作；后者就是为了找出不重复的记录(直接返回记录). }

\item{ [2020-12-05] 对每一份与 `r` 对应地 `cxx` 函数, 在 `@examples` 里添加 `stopifnot` 对结果判断, 把代码测试交给程序做。 }

\item{ [2020-12-02] \delete{`Rcpp` 的 `cpp` 文件之间不要互项调用, 不然不好处理.} 用头文件 (`.h`) 可以实现互相调用. }

\item{ [2020-08-24] `sort(c('2', '13'))` 和 `sort(c(2, 13))` 是不同的. 前者按照逐个字符排序, 后者按照数字大小排序. }

\item{ [2020-08-23] `glm` 的参数 `singular.ok` 慎用. 如果需要严格精确拟合模型, 这个参数显式设置成 `FALSE`. }

\item{ `glm` 拟合时, 区分如下两条警告:
  1. `glm.fit: algorithm did not converge` (算法不收敛, 表明结果不可信, 需要尝试其他初始值, 得到收敛结果. )
  2. `glm.fit: fitted probabilities numerically 0 or 1 occurred` (表示 `binomial` 模型拟合的 `mu` 与 `0/1` 的误差小于 `10 * .Machine$double.eps`, **目前看来没啥问题**).
}

\item{ [2020-08-20]
   * \delete{`glm` 和 `glm.fit` 的结果不一样? 而且计算一个 `binomial` 时, 前者发散, 后者收敛.} `glm` 用默认 `mehtod="glm.fit"` 时, 两者的结果完全一样(同时收敛或不收敛, 拟合结果也完全相同). 两者的区别是: `glm.fit` 的截距项必须手动添加到 `x` 中, 它的 `intercept` 参数不是设置是否包含截距项(回看 2020-04-26).
  * 如果已经有矩阵 `x`(或通过 `model.matrix` 算好了), 那么 `glm.fit` 比 `glm` 要高效(避免了 `glm` 重新生成 `model.matrix` 的操作).
}

\item{ [2020-08-19] `nanset` 是一个索引向量, `x[, -nanset]` 在 `length(nanset) != 0` 时才有效. 如果 `nanset` 是 `integer(0)`, 那 `x[, -nanset]` 是空矩阵(`NCOL(x[, -nanset]` 为零). }
\item{ [2020-08-17]
  * `rpois(1, exp(21.5))` 会报错.
  * 在 `canonical poisson` 回归的模拟里(`log-linear`), 只要 `eta=x'b` 超过 `21.5`, 随机数就不能生成了. 
  * 一种解决方式是修改设定, 使得 `x'b` 不能超过 `21.5`. 另一种方式是 `pmin(x'b, 21)`, 对过分大的 `eta` 截断.
}
\item{ `MASS::mvrnorm` 是基础功能包提供的内容, 它包含了详细的参数有效性检查, 其中用到了特征值分解和奇异值分解, 哪怕效率稍差, 但是可靠性很好. 就不要自己重造多元正态的生成函数了(用 `cholesky` 对协差阵进行分解的方式虽然原理上可用, 但是 ...) **当 $p$ 很大时($\approx 10000$), `MASS::mvrnorm` 需要对协差阵进行特征分解(这是 `R` 不够快, 也是因为这么大矩阵的分解本身也不快), 速度奇慢. 尽量避免这么大的模拟设定.**
```R
w1 <- 0.1
s2 <- sqrt(1 - w1^2)
A <- outer(seq(300), seq(300), function(i, j) w1^(i-j) * w2 * (i >= j))
```
  这段代码出现了两个问题:
  * `i << j` 时, `w1^(i-j) = Inf`, 导致 `Inf * (i >= j) = NaN`. 一种可靠的方式: `ifelse(i>=j, w1^(i-j) * w2, 0.0)`.
  * 当 `i >> j` 时, 比如 `i=100, j=1`, 此时 `w1^(i-j) = 1e-99`, 这个数字参与计算是不准确的. **在多数情况下**, 可以对上述矩阵 `A` 进行误差截断: `A <- ifelse(A > .Machine$double.eps, A, 0.0)`. 
  * 如果计算需要保留高精度, 上述截断方式太粗暴了, 需要使用高精度的数据类型(`R` 和 `python` 都有 `decimal` 类型).
  * `.Machine` 提供了很多基本精度和范围, 按需要进行选择. 这里是因为 `A` 的元素确定非负, 所以用 `.Machine$double.eps` 作为截断下界.
}

\item{ [2020-08-14] 想要对一个已有的 `GLM` 涉及的 `x` 和 `y` 进行进一步分析, 不需要从原始数据集里找变量, 把 `GLM` 里 `x` 和 `y` 的参数设为 `TRUE`, 自然可以提取其中的数据. }

\item{ [2020-08-11] 在并行计算中将每份执行结果都写入文件, 是很好的习惯. 但是文件存储的方式要设计成高效有序的形式(方便整理和打开阅读), 目前良好的方式如下:
* 每次 replicate 的结果整理成向量.
* 同一个设定的 replicates 结果写进同一个文件中.
* 不同设定的结果存放在不同的文件中.
}

\item{ [2020-08-11] 在 `R` 里创建临时文件夹 `tempdir()` 和临时文件 `tempfile()`. 临时文件先返回文件名, 有数据写入时, 才会创建文件. 退出当前 `R` 进程时, 临时文件夹连同下面的临时文件都会被删除. }

\item{ [2020-08-09]
* 用 `write.table` 的 `col.names=FALSE` 控制不输出列名(没有列名时, 不自动生成). 
* `write.csv` 的 `col.names` **不能用来控制列名称是否输出**.
* 以后都用 `write.table` 吧, `col.names/row.names` 设置行列名称是否输出, `sep=','` 输出 `csv` 文件, `quote=FALSE` 确保字符串/因子变量输出时没有引号.
}

\item{ [2020-08-04]
* `R` 的 `gaussian()` 等 `family` 函数会提供 `dev.resids(y, mu, weights)` 函数, 其中 `mu` 是对每个样本的 `fitted.values`, 等于 `linkinv(linear.predictor)`. 
* `dev.resids` 计算了 `y` 中每个样本在给定 `mu` 时的 `-2*logLik`, 按道理它和 `-2*sum(log f(yi, mui))` 相差一个常数, 这个常数与数据 `y` 有关. 当 `y` 给定时, 当 `y` 给定时, 这个常数是固定的. \emph{但是, 拟合线性模型时(`lm/glm`), 用 `deviance` 的到的结果不是 `-2logLik`, 这太坑了！！！}

* `GLM` 中, 在得到 `mu=family()$linkenv(eta)`(eta 就是 linear.predictor) 之后, 可以计算出分布族中其他参数, 进一步使用 `-2*sum(f(y, paras, log=TRUE))` 计算完整的 `-2*logLik`. 例如, 在 `binomial` 和 `poisson` 中, `mu` 就是这两个分布的唯一参数(期望), 可以直接调用 `-2*sum(dbinom(y, size=1, prob=mu, log=TRUE)` 和 `-2*sum(dpois(y, lambda=mu, log=TRUE))`. \emph{模型的结果精确等于 `-2*logLik`, 对 `poisson` 模型的结果与 `-2*logLik` 相差一个定值常数(与 `y` 有关).}
}

\item{ [2020-11-23] `R` 提供了 `stats::logLik` 和 `stats4::logLik` , 可靠性很好. }

\item{ [2020-11-12]
  * `RcppArmadillo/RcppEigen` 的 cpp 文件里, 如果使用了 `using Eigen::MatrixXd ;` 这样的内容, 直接 `compileAttributes()` 时不会把这些内容写入 `RcppExports.cpp` 中, 导致编译错误。
  * 可以手动将这部分内容写到 `RcppExports.cpp` 里面.
  * 但是 Dirk 建议使用完整的类型 (https://stackoverflow.com/questions/55403651/how-can-i-use-using-namespace-eigen-in-an-rcppeigen-based-r-package)
  * 再次强调: `Rcpp` 函数需要 `@export` 才能导出外部使用. `[[Rcpp::export]] 可以在包内部使用`.
  * `RcppEigen` 和 `RcppArmadillo` 各自生成的 `src/Makevars` 和 `src/Makevars.win` 不同。前者生成的这两个文件里都是注释，后者生成的文件中有编译设置。目前测试结果表明，如果同时需要两者，使用 `RcppArmadillo.package.skeleton(.)`。
  * 自己写的 package 使用 `Rcpp*` 系列时, 不管是否用到了 package `Rcpp` 自身的内容, 都要添加如下两项内容:
      1. `@useDynLib fastEigen, .registration=TRUE`
      2. `@importFrom Rcpp evalCpp` 【缺少这一项时, 编译安装没问题，调用函数时抛出 `RNG` 有关的错误。这个问题是用 `R CMD check ...` 发现的, 用 `devtools::document(...)` 没有发现有用的提示.】
}

\item{ [2020-11-11]
从文件读入的数据(`readxl::read_xlsx` 等), 可能不会设置列名称（比如列名称以数字开头），可以用 `R` 提供的函数进行设置:
```R
names(DT) <- make.names(names(DT))
```
}

\item{ [2020-10-30]
  * 双层 `for` 循环, 一定要小心边界位置是否与逻辑相同.
  * 就我们遇到的代码来说, 不要为了一点点性能提升而过分优化代码(导致可读性降低很多).
}

\item{ [2020-10-29]
  * 目前遇到的机器报错，都是自己写错了。
  * Armadillo 里, `symmatu()/symmatl()` 可以从用一个矩阵的上三角/下三角部分创建对称矩阵。这比手工进行对称赋值要简单稳定多了(检查了好几遍都自信满满没查出来)。
}

\item{ [2020-10-24]
  * `roxygenize(.)` 生成 `Rd` 文档时, 要求函数内部不能用 `#'` 格式注释, 否则 `export` 会有警告 `@export may only span a single line`, 而且这个函数也不会被导出.
  * `function 'enterRNGScope' not provided by package 'Rcpp'`: 需要在 package 中添加 `@importFrom Rcpp evalCpp`.
}

\item{ [2020-10-23]
  * 在 interaction feature selection 时, 用 `scale(x)` 和 `x` 生成的 interaction feature 在 selection 中的结果差别很大. 测试使用 `scale(x)` 时, 选了好多 false interaction feature.
  * \delete{`residuals(.)` 在 `glm`(non-Gaussian) 下的结果与 $y - \hat{\mu}$ 不一样, 这是坑.} 经过测试, 又发现这两者是相同的.
}

\item{ [2020-10-06] `make.names` 检查 data.frame 里变量的名字是否合法. }

\item{ [2020-10-05] `binomial-beta 分布`: 假定 binomial 分布的参数 `p` 服从 `beta` 分布, 可以 capture the overdispersion in binomial type distributed data. }

\item{ [2020-07-22] `R` 的 `stats::formula` 用法:
  * **连续变量的交互项就是数值相乘**, **类别变量的交互项是 dummy 的组合**.
  * `y ~ x1 + x2`: 标准的 linear predictor.
  * `y ~ x1:x2`: `x1` 与 `x2` 的交互项.
  * `y ~ x1*x2`: `x1*x2` 等价于 `x1 + x2 + x1:x2`.
  * `y ~ (x1+x2)^2`: 等价于 `x1 + x2 + x1:x2`, 这里的幂次表示 **至多 p-order 交互项**.
  * `y ~ (x1+x2)^3`: 等价于 `x1 + x2 + x1:x2`
  * `y ~ (x1+x2+x3)^2`: 等价于 `x1 + x2 + x3 + x1:x2 + x1:x3 + x2:x3`
  * `y ~ (x1+x2+x3)^2`: 等价于 `x1 + x2 + x3 + x1:x2 + x1:x3 + x2:x3 + x1:x2:x3`.
  * 可以用 `-` 去掉上述方式结果中的某一项.
  * `y ~ x1 + log(x2)`: `log(x2)` 作为 predictor 进入模型.
  * `y ~ x1 + I(x2+x3)`: `x2+x3` 作为 predictor 进入模型.
  * `y ~ x1 + offset(z)`: `z` 作为 `offset` 进入 linear predictor(系数固定为 1).
  * 可以用 `as.formula(str)` 将字符串转换成公式, 此时 `str` 可以通过 `paste/glue` 等字符串函数生成.
}

\item{ [2020-07-18] `glm` 拟合结果中, 
  * `linear.predictor` 是 `eta`. 
  * `fitted.values` 是 `mu`, 可以用 `fitted(result)` 提取
  * `residuals` 是 `working residuals`, 等于 $(y - \mu) / h'(\mu)$, 可以用 `residuals(result, 'working')` 提取.
  * `y - fitted(result)` 被称为 `response residuals`, 可以用 `residuals(result, 'response')` 提取.
  * 查看 `resudials.glm/residuals.lm` 源码, 它提供了五种 `residuals`.
}

\item{ [2020-06-19] `source` 在 `win` 下对文件名的大小写不敏感, 在服务器上必须准确. }

\item{ [2020-06-16] \emph{在 cmd 里执行 matlab 脚本文件, 文件名需要用`双引号`或者不用引号, 单引号不行.} }

\item{ [2020-06-08]
  * 计算除法时, 小心分母是否低于机器精度(如果分母低于机器精度, 结果失真), 此时可以添加 ridge 项保留精度(\emph{着重考虑分子是否近零, 添加合适的 ridge 项或者其他处理}).
  * `R` 的 `cor(x, y)` 等价于 `cov(x, y) / sd(x) / sd(y)`, 没有解决 `sd(x)` 低于小于机器精度的问题.
}

\item{ [2020-05-12] 在 `glue('{mean(.)}({sd(.)})'` 中, 为了均值和标准差能够在 `xtable` 之后对齐, 需要对它们的小数点后长度进行设置, 使用 `format(.)` 实现.
```R
glue('{format(mean(.), digits=3, nsmall=3)}({format(sd(.), digits=3, nsmall=3)})')
```
}

\item{ [2020-04-30] 在 HPC 上从源码安装配置 R:
1. 从 CRAN 或清华镜像上用 `wget` 下载 R-3.6.3 的源码, 解压. 尝试用 `./configure`, `make`, `make install` 进行编译安装. 目前在 `./configure` 的时候报错, 提示需要 `libcurl`.
2. 安装配置 `curl`.
```bash
wget https://curl.haxx.se/download/curl-7.61.0.tar.gz
tar -zxvf curl-7.61.0.tar.gz
./configure --prefix=/lustre/home/acct-matls/matls/depends/curl-7.61.0
make 
make install
```
  然后把 `curl` 的 `bin` 路径添加到 `~/.bash_profile` 中, 并且要 `source` 一下.
3. 进入解压的 `R` 源码文件夹, 编译安装. 中间遇到了 `jni.h` 的一个错误, 不用管他, 仍然能安装成功.
4. 把 `R` 的 `bin` 添加到路径中,  `source` 一下. 
}

\item{ [2020-04-30] `RcppArmadillo` 不完全是值传递(还没有理清原理)
  下面的函数在 `x <- array(1:24, 2:4)` 时, `cxx_Sigma(x)` 不改变 `x` 的值. 当 `x <- array(1:24, 2:4) / 2` 时, `cxx_Sigma(x)` 会改变 `x` 的值.
```R
// [[Rcpp::export]]
arma::mat cxx_Sigma (arma::cube x) {
  unsigned int n0=x.n_slices, r0=x.n_rows, c0=x.n_cols, i=0 ;
  double A0 = (double) (n0-1)*r0 ;
  x = x / A0 ;
  arma::mat Sig = arma::zeros(c0, c0) ;
  for (i=0; i < n0; i++) {
    Sig += arma::trans(x.slice(i)) * x.slice(i) ;
  }
  return A0 * Sig ;
}
```
}

\item{ [2020-04-26] `glm.fit()` 的参数 `intercept` 是指 Null model 中是否引入截距项. 想要拟合截距项的话, 需要将截距项放到 `x` 中. }

\item{ [2020-04-19] 使用 `RcppArmadillo` 的 `mat/cube` 提取子部分是 `submat/subcube`类型, 不能直接与 `vec` 进行运算, 需要用 `(vec)x(span(0), span(0), span::all)` 将 `x[0, 0, ]` 显式进行类型转换. 与 `NumericVector` 类型的互相转换是类似的.  }

\item{ [2020-04-19] 使用`Rcpp::NumericVector` 作为函数参数是引用传递,  使用`RcppArmadillo::vec` 作为函数参数是值传递. \emph{可以在函数中利用 `Rcpp::NumericVector xnew(x.begin(), x.end())` 对变量进行值传递, 然后用 `xnew` 进行计算即可.} 
}

\item{ [2020-04-10] 线性回归的信噪比(可能要除以 $n$):
  @@no-number
  \begin{equation*}
    \text{SNR} = \frac{\lVert X\beta\rVert^2}{\sigma^2} ,
  \end{equation*}
  @@
  其中 $X \beta$ 是 $n$ 个样本的真实值.
}

\item{ [2020-03-18]

绘制倾斜的坐标标签(不是坐标轴标签)
```R
x <- barplot(table(mtcars$cyl), xaxt="n")
labs <- paste(names(table(mtcars$cyl)), "cylinders")
# text(cex=1, x=x-.25, y=-1.25, labs, xpd=TRUE, srt=45)
text(cex=1, x=x-.25, y=par("usr")[3]-1, labs, xpd=TRUE, srt=45)
```
根据[介绍](https://www.r-graph-gallery.com/4-barplot-with-error-bar/), 设有向量 $x$, 它的 `sd`, `se`, `CI` 分别为:
* `sd = sd(x) = sqrt(var(x))`
* `se = sd / sqrt(length(x))`
* 给定 alpha, `CI = qt(1-alpha/2, length(x)-1) * se`

---
绘制 error-bar 图像 (设 `fit` 是用 `optim` 得到的结果, 其中包含 `Hessian`. 样本量为 `n`)
```R
x <- fit$par
x.se <- 1 / sqrt(diag(fit$hessian)) / sqrt(n)
ant <- function (x, x.se, alpha=0.05) {
  x.se <- qt(1-alpha/2, n-1) * x.se
  plot(x, type='p', pch=20, ylim=range(c(x-x.se, x+x.se)))
  arrows(seq(x), x-x.se, seq(x), x+x.se, angle=90, code=3, length=0.05)
  # segments(seq(x), x-x.se, seq(x), x+x.se)
}
windows(); ant(x, x.se)
```
注意, `arraws` 函数比 `segments` 函数多了箭头, 能控制箭头的角度, 长度.
}

\item{`nliminb`, `optim`

如果用 `nlminb` 寻优, 结果中不含有 `Hessian`, 可以调用包 `numDeriv` 计算出来, 其余步骤相同. 

---
* `optim` 和 `nlminb` 好用, 前者可以返回 Hessian 矩阵, 后者不行. 但是可以通过 `numDeriv` 包对似然函数定义 Hessian, 并带入优化结果, 仍然可以得到 Hessian 矩阵.
* 目前用钱小邪的数据测试, 是否提供梯度函数对 `optim` 的结果有明显影响, 对 `nlminb` 的影响不大.
* 测试中, `nlm` 报警告, 而且寻优结果不理想.
* `numDeriv` 只能计算数值梯度, 不能对目标函数返回梯度函数, 所以用它包装出的梯度函数放到 `optim/nlminb` 中比显式梯度函数的速度显著降低.
}


\item{ [2020-03-17] 制作 R 包如果需要内置一些 `rds` 格式数据, 在程序内部调用, 不需要暴露给用户, 可以把数据放在 `inst` 文件夹下. 暴露给用户的数据大概要求是 `rda/rdata`  格式.
}

\item{ [2020-03-16]
R 提供的 `optim` 和 `nlminb` 都是最小化目标函数, 如果是计算 MLE, 那么目标函数需要**负对数似然**. 能提供梯度函数会加快计算, 但是也要注意使用**负梯度**.

验证收敛性, 需要看参数估计指定梯度是否接近零.
}


\item{ [2020-03-09]
制作 R-pkg 时, 在 `R CMD build ...` 后会生成 `tar.gz` 文件. 接下来执行 `R CMD check ...` 时, 以前对包所在的整个文件夹进行, 这样的检查信息中总是会有几个 `Note` 无法消除, 包括 `Checking should be performed on sources prepared by 'R CMD build'` 和 `Found the following sources/headers with CR or CRLF line endings`. 

查看 `R CMD check --help`, 这个检查可以对文件夹进行, 也可以对 `tar` 类型的文件执行. 以后还是运行 `R CMD check *.tar.gz` 更好, 一个好处是避免编译 `*.cxx` 生成的文件出现在源代码的 `src` 文件夹下, 不然每次要手动删除.
}

\item{ [2020-03-08]
编写 R-pkg 时, 如果把模型的返回结果设为 `S3` class, 可以提供一些泛型函数(`predict`, `print`), 这样看起来更简洁和正式. 泛型函数要包含原函数所有的参数, 另外可根据需要自行添加参数. 以 `predict(object, ...)` 和 `print(x, ...)` 为例, `PLFD` 中自行编写的函数格式为
```
predict.plfd <- function(object, x, ...) {...}
print.plfd <- function(x, ...) {...}
```
}

\item{ [2017-05-04] 
**[Carmer's theorem](https://en.wikipedia.org/wiki/Cram%C3%A9r%27s_theorem "Carmer's theorem")**
> 如果 $X$ 和 $Y$ 是两个 **独立** 实值随机变量，满足 $X+Y$ 是正态随机变量，那么 $X$ 和 $Y$ 必定正态.(通过归纳法，可以推广至任意**有限独立**实值随机变量的和)

中心极限定理表明：均值方差有限的独立同分布随机变量的均值渐近正态. Carmer's theorem 表明：除非各个随机变量服从正态，否则 **有限** 的平均值不是正态.
}


\endlist
