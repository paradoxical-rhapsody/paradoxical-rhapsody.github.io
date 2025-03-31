+++
title = "极坐标心形曲线内部去掉一个圆形"
icon = "lightbulb-fill"

options = raw"""
    >=latex
    """
preamble = raw"""
  \usepackage{tikz}
  """
+++


\begin{tikzpicture}{polar-heart}

\draw[-] (-1cm,0cm) -- (3cm,0cm) node[right,fill=white] {$x$} ;
\draw[-] (0cm,-2cm) -- (0cm,2cm) node[above,fill=white] {$y$} ;

\foreach \x in {-1,0,...,3}
    \draw(\x,3pt) -- (\x,-3pt) node[fill=white, below] {\footnotesize$\x$} ;

\foreach \y in {-2,-1,...,2}
    \draw(-3pt,\y) -- (3pt,\y) node[fill=white, right] {\footnotesize$\y$} ;

\filldraw [thick, even odd rule, fill=gray!50, fill opacity=.3, domain=0:2*pi, samples=200, smooth] plot (xy polar cs:angle=\x r, radius={1+1*cos(\x r)}) (0.5,0) circle(5mm) ;

\end{tikzpicture} 
