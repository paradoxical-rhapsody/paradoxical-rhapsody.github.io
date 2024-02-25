+++
title = "listings"
icon = "lightbulb-fill"
+++

\link{listings}{https://www.ctan.org/pkg/listings} 提供了丰富清晰的源码打印方式, 包括独立文件、代码环境和自定义命令片段.

```latex
\usepackage{listings}

\lstloadlanguages{R, [LaTeX]TeX}

\lstdefinestyle{R-code}{
    basicstyle = {\footnotesize\ttfamily},
    stringstyle  = \ttfamily,
    commentstyle = \color{red!50!green!50!blue!50}, % light gray
    keywordstyle = \color{blue!90}, % blue with bold
    fontadjust,
    breaklines = true, 
    %% caption
    captionpos = t,
    abovecaptionskip = -9pt,
    belowcaptionskip = 9pt,
    %% frame
    frame = leftline, % shadowbox
    rulesepcolor = \color{red!20!green!20!blue!20},
    framextopmargin = 2pt,
    framexbottommargin = 2pt,
    %% line number
    numbers = left,
    stepnumber = 1,
    numberstyle = \tiny,
    numbersep  = 5pt,
    %% space and tabulator
    showstringspaces = false, % show space ?
    keepspaces   = true, 
    breakindent  = 4em, 
    breakatwhitespace = false,
    showspaces      = false,
    keepspaces = true,
    showstringspaces= false,
    showtabs = false,
    tabsize  = 2,
    %% margin    
    aboveskip    = 1em,
    xleftmargin = 4em,
    xrightmargin = 4em,
    %% fixed and flexible columns
    flexiblecolumns = true, 
    columns = flexible,
    %% misc
    extendedchars = false,
    mathescape = false,
    literate = {"}{\textquotedbl}1,
    upquote = true
}

\lstset{style=R-code}

\renewcommand*{\lstlistingname}{代码}
```
