+++
title = "利用 pattern 填充 (矩形)"
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

    \draw[dashed] (-3.5,-3.5) rectangle (3.5,3.5);
    \draw[pattern=north west lines]
      (-3.5,-3.5) -- (-3.5,0)
      arc[radius=3.5,start angle=270,end angle=360] -- (3.5,3.5)
      arc[radius=3.5,start angle=90,end angle=180]
      arc[radius=3.5,start angle=90,end angle=180];
    \draw[pattern=north west lines]
      (0,-3.5) |- (3.5,0)
      arc[radius=3.5,start angle=90,end angle=180];

    \draw[|<->|] (-3.7,-3.5) -- (-3.7,3.5) node [midway,left] {\SI{14}{\cm}};
    \draw[|<->|] (-3.5,3.7) -- (3.5,3.7) node [midway,above] {\SI{14}{\cm}};

\end{tikzpicture} 

