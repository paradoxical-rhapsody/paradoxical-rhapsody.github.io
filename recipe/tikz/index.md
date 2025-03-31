+++
title = "TikZ"
icon = "lightbulb-fill"
base = "recipe/tikz"
+++

# Tikz

为了便利 (加速), 将 tikz 独立编译 (\emph{注意编译方式} `xelatex --shell-escape tikz`):


```text
% xelatex --shell-escape tikz
\documentclass[tikz]{article}

\usepackage{tikz}
% \usepackage{tikz-3dplot}
% \usepackage{tikzlings-penguins}
\tikzset{
    global scale/.style={scale=#1, every node/.append style={scale=#1}},
    myline/.style={line width=2pt},
    myblueline/.style={myline, Blue},
    box/.style={rectangle, rounded corners=5pt, minimum width=50pt, minimum height=20pt, inner sep=5pt, draw=Silver, fill=Lavender}
}

% \usetikzlibrary{3d}
% \usetikzlibrary{arrows, arrows.meta}
\usetikzlibrary{babel} % recommend to always load
\usetikzlibrary{backgrounds}
% \usetikzlibrary{calc}
% \usetikzlibrary{chains}
% \usetikzlibrary{decorations.pathreplacing}
\usetikzlibrary{decorations.pathmorphing}
\usetikzlibrary{fit}
\usetikzlibrary{graphs}
% \usetikzlibrary{intersections}
% \usetikzlibrary{matrix}
% \usetikzlibrary{shapes, shapes.arrows, shapes.symbols, shapes.geometric}
\usetikzlibrary{shapes.misc}
% \usetikzlibrary{trees}
% \usetikzlibrary{mindmap}
% \usetikzlibrary{patterns}
% \usetikzlibrary{petri}
\usetikzlibrary{positioning}


% \usepackage{pgfplots}
% \usepackage{pgfplotstable} % 数据表输出
% \usepackage{pst-intersect}
% \usepackage{pst-node}
% \usepackage{pst-fractal}
% \pgfplotsset{
%    compat=newest   % newest
%}
% \usepgfplotslibrary{ternary} 
% \usepgfplotslibrary{groupplots}  % begin{groupplot} 对多图分组显示
% \usepgfplotslibrary{patchplots}  % 指定 patch type(如 cubic/quadratic spline 等), 即两点间连线方式
% \usepgfplotslibrary{ternary}     % 处理三角形坐标相关图形



\usetikzlibrary{external}
\tikzexternalize

\begin{document}

\section{intro}

\tikzsetnextfilename{intro}

\begin{tikzpicture}
    ...
\end{tikzpicture}

\section{...}

\end{document}
```

----


## Tikz Libraries

* \link{wheelchart}{https://www.ctan.org/pkg/wheelchart}: 轮盘图 / 饼图



## Examples

{{ show_md_list }}
