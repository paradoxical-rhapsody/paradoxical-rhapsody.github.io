+++
title = "箭头汇集"
icon = "lightbulb-fill"

options = raw"""
    """

preamble = raw"""
    % https://tikz.dev/library-folding
    \usetikzlibrary{positioning, calc}

    \tikzset{
        DynkinNode/.style = {fill=gray!50, circle, draw, minimum size=1em, inner sep=0pt, font=\scriptsize}
    }
    """
+++


\begin{tikzpicture}{tidy-arrows}

\foreach \i in {0, ..., 6} {
    \pgfmathtruncatemacro{\angle}{90-\i*60}
    \ifnum \i < 6
        \node[DynkinNode] (c\i) at (\angle:1) {\i};
        \ifnum \i > 0
            \pgfmathtruncatemacro{\j}{\i-1}
            \draw[thick, blue, -latex] (c\j) to[bend left=18] (c\i);
        \fi
    \fi
}

\draw[thick,blue,-latex] (c5) to[bend left=18] (c0);

\node[DynkinNode] (a0) at (-3, 3) {0};
\foreach \i in {1, ..., 9} {
    \pgfmathtruncatemacro{\j}{\i-1}
    \pgfmathtruncatemacro{\k}{\i*2}
    
    \node[DynkinNode, below=0.3cm of a\j] (a\i){\i};
    \draw[thick, red, -latex](a\j) --  (a\i);
    
    \ifodd \i
        \draw[dotted, -latex] plot[smooth] coordinates{(a\i.east) ($(c3)-(1cm,\k pt)$) (c3.south west)};
    \else
        \draw[dotted, -latex] plot[smooth] coordinates{(a\i.east) ($(c0)-(1.3cm,-1cm)+(0,-\k pt)$) (c0.north west)};
    \fi
}

\draw[dotted, -latex] plot[smooth] coordinates{(a0.east) ($(c0)-(1.3cm,-1cm)$) (c0.north west)};
\draw[thick, red, -latex] plot[smooth] coordinates{(a9.north west) ($(a4)!0.5!(a5)-(0.5cm,0)$)  (a0.south west)};

\end{tikzpicture}

