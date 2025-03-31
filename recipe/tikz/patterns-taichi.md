+++
title = "利用 pattern 填充 (太极)"
icon = "lightbulb-fill"

preamble = raw"""
    \usepackage[T1]{fontenc}
    \usepackage{siunitx}
    \usepackage{tikz}
    \usetikzlibrary{patterns}
  """

options = raw"""
    """
+++


\begin{tikzpicture}{sector}

   \draw[dashed] (-2,0) -- (2,0);
    \draw[pattern=north east lines]
      (-2,0) arc[radius=2,start angle=180,end angle=0]
      arc[radius=1,start angle=0,end angle=180]
      arc[radius=1,start angle=360,end angle=180];

\end{tikzpicture} 

