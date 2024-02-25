+++
title = "假设检验示意图"
icon = "lightbulb-fill"

options = raw"""
    """
preamble = raw"""
    \usepackage{pgfplots}
    \pgfplotsset{compat=1.18}
    \usepgfplotslibrary{fillbetween}
    """
+++

\begin{tikzpicture}{hypothesis-test}

\begin{axis}[
    samples = 100,
    declare function = { 
        var = 2.0 ;
        dnorm(\x,\m) = exp(-(\x-\m)^2 / (2.0*var)) / sqrt(2*pi*var) ; 
    }, 
    title=Hypothesis Testing, xlabel=$x$, ylabel=$p(x)$,
    xmin=-5.0, xmax=5.0,
    axis x line = center,
    axis y line = none, 
    xtick align = outside,
    ytick align = outside,]

    \newcommand\xrange{-4.0:4.0}
    \newcommand\xleft{-4.0:-2.5}
    \newcommand\xright{2.5:4.0}
    
    \addplot[name path=x.left, domain=\xleft] { 0.0 } ;
    \addplot[name path=x.right, domain=\xright] { 0.0 } ;

    \addplot[red, domain=\xrange, name path=C1, ]     { dnorm(x, 0.0) } ; 
    \addplot[red, domain=\xleft,  name path=C1.left]  { dnorm(x, 0.0) } ; 
    \addplot[red, domain=\xright, name path=C1.right] { dnorm(x, 0.0) } ; 
    \addplot[red, opacity=0.3] fill between[of=x.left and C1.left] ;
    \addplot[red, opacity=0.3] fill between[of=x.right and C1.right] ;

    \addplot[blue, domain=\xrange, name path=C2]       { dnorm(x, 1.0) } ;
    \addplot[blue, domain=\xleft,  name path=C2.left]  { dnorm(x, 1.0) } ;
    \addplot[blue, domain=\xright, name path=C2.right] { dnorm(x, 1.0) } ;
    \addplot[blue, opacity=0.3] fill between[of=x.left and C2.left] ;
    \addplot[blue, opacity=0.3] fill between[of=x.right and C2.right] ;
\end{axis}

\end{tikzpicture}