+++
title = "beamer 设置"
icon = "lightbulb-fill"
+++


```plaintext

% \documentclass{article}
% \usepackage[notheorems]{beamerarticle}
% \input{../article-preamble.tex}

\documentclass[aspectratio=169, notheorems, slidecentered, compress, handout]{beamer}
\setbeameroption{show notes} % show notes / hide notes / show notes on second screen / show only notes

\numberwithin{page}{section}
\renewcommand{\thepage}{\thesection-\arabic{page}}

\mode<presentation>{
	\usefonttheme{professionalfonts} % normal font for math formulas
	% \usefonttheme[onlymath]{serif}
	% \setbeamerfont{title}{shape=\itshape, family=\rmfamily}

	\setbeamercolor{title}{fg=black}
	\setbeamercolor{frametitle}{fg=black}
	\setbeamercolor{block title}{fg=black}
	\setbeamercolor{foot}{fg=black}
	\setbeamercolor{section in toc}{fg=black}
	\setbeamercolor{background canvas}{bg=white}
	\setbeamercolor{alerted text}{fg=red}
	\setbeamercolor{caption name}{fg=black}
	% \setbeamercolor{section number projected}{bg=black, fg=white}

	\setbeamerfont{frametitle}{series=\bfseries}

	\AtBeginSection[]{ % insert section page
        \begin{frame}[plain] %[noframenumbering]
			\vfill
			\centering
			\begin{beamercolorbox}[sep=8pt, center, shadow=true, rounded=true]{title}
				\usebeamerfont{title}
				\thesection. \insertsectionhead
				\par
			\end{beamercolorbox}
			\vfill
        \end{frame}
    }

	% \logo{
	% 	\begin{tikzpicture}[remember picture, overlay]
	% 	  \fill[gray] (current page.north west) -- +(1.618, 0) -- +(0, -0.809) -- cycle ;
	% 	  \draw[black] (current page.north west) ++(0.403, -0.35) node {\rotatebox{30}{STAT}} ;
	% 	\end{tikzpicture}
	% }

	\setbeamertemplate{theorems}[numbered] % numbering theorem environment
	\setbeamertemplate{navigation symbols}{} % % <<beamer>> Page 74
	\setbeamertemplate{frametitle continuation}[from second][] % <<beamer>> Page 60

	\setbeamertemplate{frametitle}{
		% \leavevmode
		\begin{beamercolorbox}[shadow=true, center]{section in head/foot}
			\usebeamerfont{title}
			\insertframetitle
		\end{beamercolorbox}
	}
	
	\setbeamertemplate{footline}{
		\leavevmode
		\hbox{
			\begin{beamercolorbox}[wd=.5\paperwidth, left]{section in head/foot}%
				\hspace*{20pt}
				\insertsection
			\end{beamercolorbox}
			\begin{beamercolorbox}[wd=.5\paperwidth, right]{section in head/foot}%
				\thepage
				\hspace*{40pt}
				% \hspace*{20pt}
				% \rotatebox{30}{xzc}
				% \hspace*{20pt}
			\end{beamercolorbox}
		}
		\vskip 12pt
	}
}

\usepackage{hyperref}
\hypersetup{
    unicode = true,         % non-Latin characters in Acrobat’s bookmarks
    pdfencoding = unicode,
    pdftoolbar = true,      % show Acrobat’s toolbar?
    pdfmenubar = true,      % show Acrobat’s menu?
    pdffitwindow = false,   % window fit to page when opened
    pdfstartview = {FitH},  % fits the width of the page to the window
    pdftitle = {Workflow of Data Analysis},
    pdfauthor = {Zengchao XU},
    pdfsubject = {lecture notes},
    pdfcreator = {Zengchao XU},
    pdfproducer = {XeLaTeX},
	allbordercolors = 1 1 1, % set all border color as white
    pdfnewwindow = true,    % links in new window
    colorlinks = false,     % false: boxed links; true: colored links
    linkcolor = false,      % color of internal links (change box color with linkbordercolor)
    urlcolor = false
}

\usepackgage{...}
\usepackage{biblatex}
\addbibresource{refs.bib}

\logo{
    \begin{tikzpicture}[remember picture, overlay]
        \fill[gray] (current page.north west) -- +(1.618, 0) -- +(0, -0.809) -- cycle ;
        \draw[black] (current page.north west) ++(0.403, -0.35) node {\rotatebox{30}{STAT}} ;
    \end{tikzpicture}
}


\title{...}
\author{...}
\institute[SHNU]{...}
\date[\today]{\today}

\begin{document}
\baselineskip 6mm

...

\end{document}

```