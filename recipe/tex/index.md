+++
title = "LaTeX"
icon = "lightbulb-fill"
toc_sidebar = true
+++


# $\TeX$


## Templates / Pkgs

* \link{usepkgs}{tex-usepackage} / 
  \link{beamer}{tex-beamer} / 
  \link{biblatex}{tex-biblatex} / 
  \link{draft}{preamble}

* \link{adjustbox / graphicx}{adjustbox-and-graphicx}
* \link{listings}{listings}


## Sources

* \link{graphicx}{https://mp.weixin.qq.com/s/hnKGxkV07jSSjhdgJN6j1Q} 是 `graphics` 的扩展, 完全可用作 `graphicx` 的替代及补充. 
  * 它提供了几个有用的操作: 旋转 (`\rotatebox{70}{斜倚}`), 镜面反射 (`\reflectbox{鹦鹉}`), 缩放 (`\scalebox{0.5}[1]{\makebox[2em]{马\hskip-.1em录}}`).
  * `\adjustbox` 或 `\begin{adjustbox}` 的 `key-value` 顺序会影响效果. `{scale=1.5, center}` 比 `{center, scale=1.5}` 效果更好. 

* \link{fancyvrb}{}: `verbatim` 环境.

* \link{pdfpages}{}: 对 pdf 页面操作(合并、插入等), 能准确控制页码、空白页等.
* \link{fontawesome5}{}: \link{图标字体库}{https://fontawesome.dashgame.com}.

* \link{curve}{}: **Cur**ricula **V**ita**e**.

* \link{cleveref}{}: 交叉引用 `\Cref{}`.

* \link{tasks}{}: 把列表 items 排成两列.
* \link{nicematrix}{}: `amsmath` 提供的 `bmatrix/pmatrix/vmatrix` 太简单了, 这个包提供了更简洁且富有表现力的实现.
* \link{callouts}{}: 在图片上添加标注.

* \link{snotez}{}: 带有编号的边注.
* \link{fancypar}{}：预定义了五种段落样式 (穿孔活页笔记本、斑马条纹、段落左右标记、段落下划线).

* \link{witharrows}{}: 展示公式演绎过程 (在多行数学式的右侧添加箭头及说明文字).

* \link{memoir}{}: 书籍/报告/论文等类型文档 (页面布局如大小边距页眉页教 / 章节标题格式 / 完善的脚注支持 / 增强的表格功能 / 引用和文献支持 / 图像支持 / 多语言支持 / 文档结构和章节管理).

* \link{joinbox}{}: 多个 box 垂直/水平拼接 (自动等宽或等高).
* \link{fitbox}{}: 自动将图片缩放到页面限制的尺寸内.

----

`biblatex` 的一些设定: 

* 设置 `style=authoryear` 并开启 `backend=bibtex` 选项后, 引用效果为 `Li et al. 2010`, 默认 `biber` 效果为 `B. Li et al. 2010` (好呆的). [2024-01-18]
* 启用 `natbib` 选项后, 可无缝调用 `\citet` 和 `\citep`, 省心的是旧文档的命令不必修改了, e.g., `\citep[see][Chap. 2]{pan2019covariate-adjusted}`. [2024-01-15]
* 设置 `maxcitenames=2` 可在引用中最多显示两位作者, `maxbibnames=99` 可在 bibliography 中显示很多作者.
* `bibstyle=apa6`下, `maxnames/maxbibnames/maxcitenames` 不起作用, 此时改用 `apamaxprtauth=99` 就能显示所有作者. [\link{参考}{https://tex.stackexchange.com/questions/230452/biblatex-biber-maxbibnames-with-style-apa}] [2021-08-03]
* `\usepackage{ulem}` 会把默认的 `\em{}` 斜体效果覆盖为下划线, 导致文档出现莫名其妙的下划线内容 (例如 `biblatex` 的 `style=apa6` 时, journal 正常会被显示为斜体, 载入 `ulem` 后会被处理为下划线). 可通过 `\usepackage[normalem]{ulem}` 禁止此类现象. [2023-06-17]



## Tips


\list


\item{ [2025-04-24] 安装了 TexLive 和 TinyTeX, 偶然发生 `Emergency stop` 并提示找不到载入的包 (每个包都找不到), `log` 文件显示编译调用了 TinyTeX (它里面安装包). \delete{以后永远只安装一份 TeX 系统, 不然诡异的冲突太多了.} `rmarkdown` 导入了 `tinytex`, 必须要安装它了...}


\item{ [2025-03-31] 使用 $\LaTeX$ 在 2020 之后添加的新功能 `\AddToHook` 结合 TikZ 自定义前景和背景水印:
```bash
\AddToHook{shipout/background}{
    \begin{tikzpicture}[remember picture, overlay]
        % \ifodd\value{page}
            \node[draw, fill=red!30, rotate=45, text=black!50, scale=8, opacity=0.2]
                at (current page.center) {Odd \thepage};
        % \else
        %     \node[draw, fill=red!30, rotate=45, opacity=0.01, scale=3] 
        %         at (current page.center) {Even \thepage};
        % \fi
    \end{tikzpicture}
}

\AddToHook{shipout/foreground}{
    % \put(2cm, -3cm){Test} % absolute position
    \put(\dimexpr\paperwidth-2cm, \dimexpr-\paperheight+1cm){Right Lower}
}
```
}


\item{ [2024-09-28] `tabularray` 内使用 `enumerate` 时需要添加 `measure=vbox`, 此时单元格内容设置居顶无效时 (内容的上下位置有额外空白), 按照文档说明需要添加参数 `stretch=-1`. }


\item{ [2024-09-09] 重置页码: `\setcounter{page}{4}` }
\item{ [2024-09-09] 重置章节号: `\setcounter{section}{2}` }


\item{ [2024-09-02] `TikZ` 绘制光滑不规则封闭曲线: `\draw [smooth cycle] plot coordinates {(a) (b) (c)};`}


\item{ [2024-08-10] `ctex` 下的字体加粗 (如 `\heiti`) 如果用 `\textbf` 没有效果, 可能是系统缺少字体 (可以把 win 的字体文件夹复制到 linux 下并刷新). 如果实在不能解决, 可以在文档类中添加 `AutoFakeBold=true` 选项 (各种文档类都可以: `article / ctexart` 等), 开启伪粗体模式. 类似还有默认关闭的伪斜体选项 `AutoFakeSlant` (汉字排版本来也没有斜体概念).

参考: [xelatex编译加粗楷体为什么会失败？](https://www.zhihu.com/question/58456658)
}


\item{ [2024-07-24] `xcolor` 定义颜色不能设置透明度, 可以用 `tikz` 实现:
```bash
This is a \tikz[baseline=(X.base)] \node[opacity=0.3, blue, inner sep=0pt] (X) {colored} ; text.
```
}

\item{ [2024-05-22] 连续插入两个空白页 `\newpage \null \vfill \newpage` }


\item{ [2024-02-26] `enumitem` 的 `enumerate` 环境第一段充当小标题很好用, 第二段才当成正式内容。主要是注意 `label` 紧跟的段落是 `item`, 后续段落是 `item paragraph`, 是有点区别的.
```bash
\begin{enumerate}[label=\textbf{(\Alph*)}, listparindent=\parindent, itemindent=2em, leftmargin=1ex]
  \item 小标题

  正文内容...
\end{enumerate}
```
}


\item{ [2023-11-29] 

* 文档默认 `\title` 位置太靠下, 可以用 `\title{\vspace{-3em} This is Title}` 纵向上移. 如果不设置 `\author`, 使用 `\maketitle` 默认 `title` 和 `date` 之间的距离过大, 可以用 `\date{\vspace{-3em} \today}` 把日期上移. 
* `\usepackage{titling}` 可以设置 `\setlength{\droptitle}{0pt}` 消除 `title` 的顶部距离, 设置 `\preauthor{} \author{} \postauthor{}` 取消作者并消除相应的纵向间距.
}

\item{ [2023-09-25] `fancyhdr` 不改变 `\maketitle` 默认的 `\pagestyle{plain}` 格式，可以在 `\maketitle` 后面用 `\thispagestyle{fancy}` 设置.}

\item{ [2023-06-17] 在制作简历模板时, 将设置部分放在独立的 `settings.sty` 文件中并 `\usepackage{settings}`, 居然和直接写入主文件的效果不同.... }

\item{ [2023-06-15]

* `rotating` 提供了 `sidewaytable` 和 `sidewayfigure` 环境, 可将表格/图片内容旋转 (页面不旋转). 它还有 `\turnbox{}{}` 旋转小部分内容.
* `landscape` 环境是将页面旋转九十度, 然后渲染内容.
}



\item{ [2023-05-29] 
* `mdframed` 对内容添加边框 (参考 `24杨帆`), 这基本能实现各种细节控制了.

* 对页面添加外边框
```bash
\usepackage{fancybox}
\fancypage{\fbox}{}
```
}

\item{ [2023-03-18] `beamer` 中设置了 `allowframebreaks`, 如果出现某一页开始的内容被放置在一页内, 没有如愿被分页 (即使用 `\framebreak` 也不行), 那就是当前页的内容高度超限, 可以在其中适当设置 `\vspace{-2ex}` 进行调整. }

\item{ [2023-01-15] `tabularray` 的 `tblr` 环境中, 表格元素有 `enumerate` 时, 需要添加 `varwidth` 支持元素具有可变高度. 文档给出的方案如下:

```bash
\usepackage{tabularray}
\UseTblrLibrary{varwidth}

\begin{tblr}{measure=vbox}
...
\end{tblr}
```
}

\item{ [2023-02-15] `enumitem` 的说明 (根据文档的示意图 Figure 1):

* `leftmargin` 是内容距离正文左侧边的缩进距离.
* 每个 `item` 的第一行可以充当后续段落的小标题, 由于 `label` 的存在, 它的缩进的 paragraph 2 更复杂. 具体缩进流程为: 先将整段内容缩进 `leftmargin`, 然后内容开头再向内缩进 `itemindent`, 从开头向左前进 `labelsep`, 然后以宽度 `labelwidth` 填充标签.

}


\item{ [2023-01-03]

`\includegraphics[clip, viewport]{cover.pdf}` 插入文件中特定区域时, 区域外的内容仍然被插入文件中, 只是被设置为不可见 (用 evince 阅读器全选就能看到, 其他阅读器可以选中这部分内容), 所以这不是一个好思路. 此外, 这个方案需要小心确定所需区域的 `viewport` 坐标, 这一点也不让人喜欢.

如下思路更加简单且干净:
1. 将 `doc` 模板中想要独立的段落调整到一页内, 导出为 `pdf` 文件.
2. 使用 `pdfcrop` 工具将 `pdf` 所有页面的边缘裁掉.
3. 将裁出的文件的页码作为变量, 定义插图命令: `\newcommand{\sectiontitle}[1]{ \bigskip \stepcounter{section} \adjustimage{page={#1}, left, noindent, frame}{template.pdf}}`
}



\item{ [2022-10-16] `enumitem` 的环境中添加中文序号标签:

```bash
\usepackage{ctex}
\AddEnumerateCounter{\chinese}{\chinese}{\quad}
```
}

\item{ [2022-08-25] Beamer 的 `\note` 想要实现列表环境, 应使用 `\note[item]{text}`. 文档中的 `\note[enumerate]{text}` 和 `\note{itemize}{text}` 是坏的, 不能用 (参考 \link{stackexchange}{https://tex.stackexchange.com/questions/185431/notes-in-beamer-document-class-lonely-item}). }

\item{ [2022-08-25] `enumitem` 提供了良好的列表环境. 可以对它的环境进行全局默认设置:

```bash
\usepackage[inline]{enumitem}

\setlist[enumerate]{label=\textbullet}

\newlist{homework}{enumerate}{1}
\setlist[homework]{label=\textbf{\thesection.\arabic*}}
```
}

\item{ [2022-08-25] TiKZ 的 `node` 中使用 `equation` 环境时, 需要指定 `text width`. 例如, 定义添加虚线框的小命令:

```bash
\newcommand{\dashedbox}[2][{}]{ \tikz[baseline=(X.base)]{ \node[draw, dashed, text width=#1, ] (X) {#2};} }
```

行内公式使用 `\dashedbox{$p(x)/q(x)$}`, 行间公式使用 `\inline[\linewidth]{\begin{equation} ... \end{equation}}`.
}

\item{ [2022-06-01] 将 `svg` 转为 `pdf` 格式:

```bash
inkscape --export-type=pdf --export-latex figure.svg
```
}

\item{ [2022-05-25] `vscode` 的 latex-workshop 拓展中, 对 `tex` 文件的右上角的绿色编译方式设置:
* [240504] \delete{在设置中搜索 `external build`, 搜索结果有两项关于 `Latex-workshop > Latex > External > Build`.}
* [240504] \delete{在 `Args` 中添加 `-xelatex`, 在 `Command` 中添加 `latexmk` 即可. 另一种方式是仅在 `Command` 中添加 `latexmk -xelatex` (不过既然有使用 `Args` 的规范方式, 就不要偷懒了).}

[240504] 这个小图标是由 `Latex > Recipe:Default` 控制的. 那个 `external build` 相关的另有作用 (要读懂文档再操作).
}

\item{ [2022-05-05] 字体设置:

```text
\usepackage{ctex}
% \setCJKsansfont{LXGWWENKAI-REGULAR.TTF} % [BoldFont=LXGWWENKAI-BOLD.TTF]
\newCJKfontfamily \yozai {YOZAI-REGULAR.TTF}
```

`sans` 和 `main` 分别对应两个字体族.
}

\item{ [2022-04-23] 文献引用分章节的基本用法:

```plaintext
\usepackage[style=biblatex-spbasic]{biblatex}
\addglobalbib{references.bib}

\begin{document}

\begin{refsection}
\cite{xu2021hypothesis}

\printbibliography[heading=none]
\end{refsection}
    

\begin{refsection}
\cite{zhang2019a}

\printbibliography[heading={subbibliography}, title={论文}]
\end{refsection}

\end{document}
```
}

\item{ [2022-04-23] 设置字体: `TTF` 是字体格式, 可直接定义新字体命令(`\yozai`).

```plaintext
\usepackage[]{ctex}
\setCJKmainfont{LXGWWENKAI-REGULAR.TTF}
% \setCJKsansfont{LXGWWENKAI-REGULAR.TTF}
\newCJKfontfamily \yozai {YOZAI-REGULAR.TTF}
```
}

\item{ [2022-04-04]
  `texlive` 自带 pdf 文件裁边小工具: `pdfcrop file.pdf`
}

\item{ [2022-04-04]
  `xeCJKfntef` 是 `xeCJK` 的子宏包 (需要显式载入), 它基于 `ulem`, 提供了丰富的汉语格式修饰 (下划线/删除线和自定义符号). 它还提供了 `CJKfilltwosides` 环境, 用于两端对齐. 此外, 两端对齐 (stretch) 可使用基本命令 `\makebox[0.4\linewidth][s]{content}` , 这里 `s` 可以换成居中或左右.

```plaintext
% \usepackage{tabularray}
% \usepackage{xeCJKfntef}
\begin{tblr}{cl}
    \makebox[0.4\linewidth][s]{姓名}     & \CJKunderline{\makebox[0.6\linewidth][c]{许曾超}}  \\
    \makebox[0.4\linewidth][s]{论文题目} & \CJKunderline{\makebox[0.6\linewidth][c]{高维矩阵变量数据中的统计推断}} 
\end{tblr}

\CJKsout{Bee don't need to explaining flies that }
```
}

\item{ [2022-04-04]
  
}

\item{ 编译出现 *size substitutions with differences* 或 */cmex/m/m in size not available* 警告: `\usepackage{lmodern}` }

\item{ 公式编号全局居左: `\usepackage[leqno]{amsmath}` }

\item{ 公式居左: 使用 `flalign` 环境 (类比 `align` 环境). }

\item{ 编译卡顿在 `euenc/eu1lmr.fd` / 安装新字体则需要刷新 (否则编译也可能卡顿):
  1. 清空 `/texlive/2016/texmf-var/fonts/cache`
  2. 管理员身份运行 `fc-cache` 或 `fc-cache -fsv` (`/texlive/2016/bin/win32/fc-cache.exe`), 等待字体缓存完成即可.
}

\item{ Beamer 添加页码: `\setbeamertemplatefootline[frame number]`. }

\item{ URL 自动换行:
```plaintext
\usepackage{hyperref}
\usepackage[hyphenbreaks]{breakurl}
```
}

\item{ [2022-01-29] 

  在 `beamer` 中通过 `tikz` 使用 `\matrix` 时, 会报错 `\pgf@matrix@last@nextcell@options`. 简单的[方案](https://tex.stackexchange.com/questions/208408/tikz-matrix-undefined-control-sequence)是对 `frame` 添加 `fragile` 选项.
}

\item{ [2021-10-20]

  `beamer / ctexbeamer` 默认使用 sans 字族, 想要修改全文的字体时, `setCJKmainfont` 是不起作用的 (它设置的是 roman 字族, 影响 `\rmfamily` 和`\textrm` 的字体) , 应该使用 `\setCJKsansfont{KaiTi/SimSun}` 修改 (影响 `\sffamily` 和 `\textsf` 的字体) . 另外还有 `setCJKmonofont` 影响 `\ttfamily` 和 `\texttt` 字体. 
}


\item{ [2021-08-20] 
  移除 `pdf` 边缘空白：`pdfcrop blabla.pdf`.
}

\item{ [2020-12-25] 
  TeX 里的 `\bar` 太短,  `\overline` 太宽. 如下自定义命令更恰当:
  ```plaintext
  \newcommand{\overbar}[1]{\mkern 1.5mu\overline{\mkern-1.5mu#1\mkern-1.5mu}\mkern 1.5mu}
  ```
}

\item{ [2020-07-29] TeX 的表格里用 `\multicolumn{3}{c}{Method}`, 错写成 `\multicolumn{3}{c}Method}`, 结果 `XeLaTex` 编译一直在运行但是不出结果. **这种问题没有报错!**
}

\item{ [2021-02-21] 导出已安装的字体: 管理员权限打开 `cmd`, 执行
```plaintext
fc-list -f "%{family}\n" > fonts.txt
```

注意：如果添加 `:lang=zh` 选项, 可能会漏掉一些中文字体.
}

\item{ 设置中文字体
```plaintext
\usepackage{xeCJK}
\newcommand{\shusong}{\CJKfontspec{FZShuSong-Z01S}}%方正书宋
\newcommand{\kaishu}{\CJKfontspec{FZKai-Z03S}}%方正楷体
\newcommand{\xingkai}{\CJKfontspec{STXingkai}}%华文行楷

\begin{document}
\noindent
    \xingkai 这是华文行楷\\
    \kaishu 这是方正楷体\\
    \shusong 这是方正书宋
\end{document}
```
}

\item{ `ctex` 宏包提供的字体命令
```plaintext
\songti 宋体    & SimSun          &\verb|\songti 宋体|   \\
\kaishu 楷体    & KaiTi           &\verb|\kaishu 楷体|   \\
\heiti 黑体     & SimHei          &\verb|\heiti 黑体|    \\
\yahei 微软雅黑  & Microsoft YaHei &\verb|\yahei 微软雅黑| \\
\fangsong 仿宋  & FangSong        &\verb|\fangsong 仿宋| \\ 
\youyuan 幼圆   & YouYuan         &\verb|\youyuan 幼圆|  \\
\lishu 隶书     & LiSu            &\verb|\lishu 隶书|    \\
```     
}

\item{ 字体设置

```plaintext
\usepackage{xeCJK}
\renewcommand{\songti}{\CJKfontspec{STSong}}        % 华文宋体
\newcommand{\zhongsong}{\CJKfontspec{STZhongsong}}  % 华文中宋
\renewcommand{\kaishu}{\CJKfontspec{STKaiti}}       % 华文楷体
\newcommand{\xingkai}{\CJKfontspec{STXingkai}}      % 华文行楷
\newcommand{\xihei}{\CJKfontspec{STXihei}}          % 华文细黑
\renewcommand{\fangsong}{\CJKfontspec{STFangsong}}  % 华文仿宋
\renewcommand{\lishu}{\CJKfontspec{STLiti}}         % 华文隶书
\newcommand{\caiyun}{\CJKfontspec{STCaiyun}}        % 华文彩云
\newcommand{\hupo}{\CJKfontspec{STHupo}}            % 华文琥珀

\renewcommand{\songti}{\CJKfontspec{Adobe Song Std L}}        % adobe 宋体
\renewcommand{\kaishu}{\CJKfontspec{Adobe Kaiti Std R}}       % adobe 楷体
\renewcommand{\heiti}{\CJKfontspec{Adobe Heiti Std R}}        % adobe 黑体
\renewcommand{\fangsong}{\CJKfontspec{Adobe Fangsong Std R}}  % adobe 仿宋
```
}

\item{ \link{关于 `ctex`}{https://www.zhihu.com/question/58656895/answer/157896917}

  全中文的文档, 尽量用 ctex 文档类. 也就是 ctexart、ctexrep、ctexbook、ctexbeamer 这些 (`\documentclass{ctexart}`). 

  比较少见的情形下, 你需要在某个原本不支持中文的文档类中写全中文的文档, 此时用 ctex 包 (`\usepackage{ctex}`) , 如用 `moderncv` 写简历. 

  英文文档中的几段中文, 建议用 `scheme=plain` 选项调用 ctex 包, 即 `\usepackage[scheme=plain]{ctex}`.

  英文文档中的几个汉字 (比如人名) , 建议把汉字做成图片, 插图, 这样不需要限定编译方式. 如果允许用 XeTeX 或 LuaTeX, 也可以直接切成汉字字体写中文, 不加中文相关宏包.

  那么什么时候用 xeCJK 宏包? 当然是写 ctex 包的时候. ctex 包在检测到你使用 XeLaTeX 编译时, 会调用更底层的 xeCJK. 打个比方说的话, ctex 包若是一辆车, xeCJK 就是个轮子. 轮子是车子的重要零件, 但我还是建议你开车, 把装轮胎的事交给工程师.
}


\endlist
