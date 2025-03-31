+++
title = "利用 pattern 填充 (扇形)"
icon = "lightbulb-fill"

preamble = raw"""
    \usepackage[T1]{fontenc}
    \usepackage{siunitx}
    \usepackage{tikz}
    \usetikzlibrary{patterns}
  """

options = raw"""
    >=stealth
    """
+++


\begin{tikzpicture}{sector}

  \coordinate (0:0) node[above=4pt]{\SI{120}{\degree}};
    \draw[dashed] (0:0) -- (150:2.8) (0:0) -- (30:2.8);
    \draw[pattern=north west lines]
      (150:2.8) -- (150:4.2)
      arc[radius=4.2,start angle=150,end angle=30] -- (30:2.8)
      arc[radius=2.8,start angle=30,end angle=150];

    \draw[|<->|,shift={(300:0.2)}] (0:0) -- (30:2.8) node[midway,sloped,below] {14};
    \draw[|<->|,shift={(300:0.2)},shorten <=-\pgflinewidth] (30:2.8) -- (30:4.2) node[midway,sloped,below] {7};

\end{tikzpicture} 

