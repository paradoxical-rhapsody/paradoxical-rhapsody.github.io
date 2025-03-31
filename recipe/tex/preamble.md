+++
title = "preamble"
icon = "lightbulb-fill"
+++

```plaintext
%\usepackage[english]{babel}
\usepackage[no-math]{fontspec}
\usepackage[noindent]{ctex}

\usepackage{amsmath, bm}
\usepackage{amssymb, amsfonts, amsthm}
\usepackage{dsfont, mathrsfs, bbm} % 特殊字体
\usepackage{MnSymbol}
\usepackage{extarrows}
\usepackage[]{graphicx}
\usepackage[]{color}
\usepackage{xcolor}

\setlength\parindent{0pt}   % 取消段首缩进
\setlength{\parskip}{8.0pt} % 设置段后间距

\marginparwidth 0pt
\oddsidemargin 20pt
\evensidemargin 20pt
\marginparsep 0pt
\topmargin 2pt
\headheight 12pt
\headsep 25pt
\topskip 15pt
\footskip 30pt
\textwidth 6.0in
\textheight 8.0in

\theoremstyle{definition}
\newtheorem{defi}{Definition}
\newtheorem{lemm}{Lemma}
\newtheorem{theo}{Theorem}
\newtheorem{coro}{Corollary}
\newtheorem{prop}{Proposition}
\newtheorem{rema}{Remark}
\newtheorem{exam}{Example}
\newtheorem{exer}{Exercise}

\usepackage[colorlinks=true,linkcolor=blue,citecolor=blue,urlcolor=red]{hyperref}  % 超链接 (默认 citecolor=magenta)
\usepackage[]{geometry}
\usepackage{setspace}  %设定行间距 \begin{spacing}{0.2} ...\end{spacing}
\usepackage{mdframed}

\usepackage{marginnote} % \reversemarginpar 可以更改页边注的侧
\usepackage{todonotes}

\usepackage{ulem}
  %\uline{下划线}
  %\uuline{双下划线}
  %\uwave{波浪线}
  %\sout{中间删除线}
  %\xout{斜删除线}
  %\dashuline{虚线}
  %\dotuline{加点}

\usepackage{multirow}               % \multirow{nrows}[bigstructs]{width}[fixup]{text} %合并某一列的多行
\usepackage[figuresright]{rotating} % \begin{sidewaystable} 环境可以旋转表格
\usepackage{booktabs, colortbl}     % for much better looking tables

%\usepackage{animate} % 可以用在 beamer 中插入一列图片形成动画
    % \animategraphics[height=5cm, loop, autoplay, controls]{12}{fig}{0}{n-1}
\usepackage{subfig} % 在一个 float 中添加多个 subfigure/subtable
\usepackage{float}          % 处理浮动图形

\usepackage{pst-node}
\usepackage{tikz}
\usetikzlibrary{
  arrows, backgrounds, calc, chains,
  decorations.pathreplacing, decorations.pathmorphing,
  matrix,
  shapes, shapes.symbols, shapes.geometric,
  trees, mindmap,
  patterns, positioning
}

\usepackage{pgfplots}
\pgfplotsset{compat=newest}  %newest
\usepgfplotslibrary{
  ternary,
  groupplots, % begin{groupplot} 对多图分组显示
  patchplots, % 指定 patch type(如 cubic/quadratic spline 等)，即两点间连线方式
  ternary % 处理三角形坐标相关图形
}
\usepackage{pgfplotstable} % 数据表输出

\usepackage[ruled, vlined]{algorithm2e}
\usepackage{algorithmic}
\algsetup{indent=2em} %设置算法缩进

\usepackage{listings} % 代码块 \begin{lstings}[language=C, title=Myfile, frame=shadowbox] ... \end{lstings}
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}
% 在 overleaf 上有更多的 style 参数
\lstdefinestyle{mystyle}{
    backgroundcolor = \color{backcolour},
    commentstyle    = \color{codegreen},
    keywordstyle    = \color{magenta},
    numberstyle     = \tiny\color{codegray},
    stringstyle     = \color{codepurple},
    basicstyle      = \footnotesize,
    breakatwhitespace = false,
    breaklines  = true,
    captionpos  = b,
    keepspaces  = true,
    numbers     = left,
    numbersep   = 5pt,
    showspaces  = false,
    showstringspaces = false,
    showtabs = false,
    tabsize  = 2
}
\lstset{style=mystyle}

% ToC (table of contents)
\usepackage[nottoc,notlof,notlot]{tocbibind} % Put the bibliography in the ToC
\usepackage[titles,subfigure]{tocloft}       % Alter the style of the Table of Contents
\setlength{\cftbeforesecskip}{1pt} %\setlength{\cftbeforeXskip}{1pt}，这里 X 用 sec, chap 代替

% HEADERS & FOOTERS
\usepackage{fancyhdr}   % This should be set AFTER setting up the page geometry
\pagestyle{fancy}       % options: empty , plain , fancy
\renewcommand{\headrulewidth}{0pt} % customise the layout...
\lhead{}\chead{}\rhead{}
\lfoot{}\cfoot{\thepage}\rfoot{}
% 脚注的编号风格
\renewcommand{\thefootnote}{\alph{footnote}} % 包括 arabic, Roman, alph, Alph, fnsymbol

```