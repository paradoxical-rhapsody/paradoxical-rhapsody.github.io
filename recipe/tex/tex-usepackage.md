+++
title = "usepackage"
icon = "lightbulb-fill"
+++


```plaintext

\usepackage{lipsum}
% \usepackage{zhlipsum}

\usepackage{ctex}
% \usepackage[heading=true]{ctex}
%% \pagestyle{plain}
% \ctexset{
%     section = {
%         name = {,、}, 
%         number = \chinese{section},
%         format = \large\bfseries,
%         aftername = {}
%     }
% }

% \setCJKsansfont{LXGWWENKAI-REGULAR.TTF} % [BoldFont=LXGWWENKAI-BOLD.TTF]
% \newCJKfontfamily \yozai {Yozai}

\usepackage{amsmath, bm}
\usepackage{amsfonts}
\usepackage{amssymb}
\everymath{\displaystyle}
\numberwithin{equation}{section}


% \newtheorem{theorem}{定理}[section]
% \newtheorem{lemma}[theorem]{引理}
% \newtheorem{proposition}[theorem]{命题}
% \newtheorem{corollary}[theorem]{推论}
% \theoremstyle{definition}
% \newtheorem{definition}[theorem]{定义}
% \newtheorem{example}[theorem]{例}
% \numberwithin{equation}{section}


\usepackage{xcolor}
% \definecolor{myred}{RGB}{255,0,0}
% \definecolor{myblue}{rgb}{0,0,1}
% \definecolor{dgreen}{RGB}{63,127,0}
% \definecolor{dred}{RGB}{144,14,3}
% \textcolor{Blue}{蓝色字体}
% \textcolor[RGB]{255,0,0}{红色字体}


\usepackage{graphicx}
\usepackage{adjustbox}


\usepackage{longtable}

\usepackage{tabularray}
\UseTblrLibrary{amsmath}
\UseTblrLibrary{booktabs}
\UseTblrLibrary{diagbox}
\UseTblrLibrary{varwidth}

\usepackage{csvsimple-l3}

\usepackage[normalem]{ulem}
\usepackage{caption}
\usepackage{cleveref}

\usepackage{fancyvrb}

\usepackage{listings}
\lstset{
    language=R,
    morekeywords = {fread, fwrite, readClipboard, write.foreign, readMat, writeMat, read.octave}
}



\usepackage{fontawesome5}
\newcommand{\exampletitle}{\rotatebox{90}{\faThumbtack}~}

\usepackage[inline]{enumitem}
\AddEnumerateCounter{\chinese}{\chinese}{\quad}
\newlist{homework}{enumerate}{1}
\setlist[homework]{label=\textbf{\thesection.\arabic*}}
\setlist[enumerate]{label=\textbullet}

\usepackage{tcolorbox}
\tcbset{colframe=white}

\tcbuselibrary{theorems}
\newtcbtheorem[number within=section]{definition}{定义}{coltitle=black, colbacktitle=black!11, colback=black!11, halign=left}{} % colframe=black!11,
\newtcbtheorem[number within=section]{theorem}{定理}{coltitle=black, colbacktitle=black!11, colback=black!11, halign=left}{} % colframe=black!11,
\newtcbtheorem[number within=section]{lemma}{引理}{coltitle=black, colbacktitle=black!11, colback=black!11, halign=left}{} % colframe=black!11,
\newtcbtheorem[number within=section]{proposition}{命题}{coltitle=black, colbacktitle=black!11, colback=black!11, halign=left}{} % colframe=black!11,
\newtcbtheorem[number within=section]{example}{例}{coltitle=black, colbacktitle=white, colback=white, halign=left}{} % colframe=black!11,


\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\sign}{sign}
\DeclareMathOperator{\diag}{diag}

\DeclareMathOperator{\e}{e}
\DeclareMathOperator{\E}{E}
\DeclareMathOperator{\var}{Var}
\DeclareMathOperator{\corr}{Corr}
\DeclareMathOperator{\cov}{Cov}
\DeclareMathOperator{\ECD}{ECD}

\newcommand{\mailto}[1]{\href{mailto:#1}{#1}}

\renewcommand{\d}{\mbox{d}}
\renewcommand{\P}{\mbox{P}}
\renewcommand{\vec}{\mbox{vec}}

```