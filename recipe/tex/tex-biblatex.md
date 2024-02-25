+++
title = "article 页面"
icon = "lightbulb-fill"
+++


```plaintext

\usepackage[
  style = authoryear, % biblatex-psbasic
	% bibstyle = authoryear, 
	% citestyle = authoryear, 
	maxcitenames = 2, 
	maxbibnames = 100, 
	backend = bibtex]{biblatex}

\AtBeginBibliography{\footnotesize} % Footnotesize for Bibliography entries

\setbeamertemplate{bibliography item}{%
  \ifboolexpr{ test {\ifentrytype{book}} or test {\ifentrytype{mvbook}}
    or test {\ifentrytype{collection}} or test {\ifentrytype{mvcollection}}
    or test {\ifentrytype{reference}} or test {\ifentrytype{mvreference}} }
    {\setbeamertemplate{bibliography item}[book]}
    {\ifentrytype{online}
       {\setbeamertemplate{bibliography item}[online]}
       {\setbeamertemplate{bibliography item}[article]}}%
  \usebeamertemplate{bibliography item}}

\defbibenvironment{bibliography}
  {\list{}
     {\settowidth{\labelwidth}{\usebeamertemplate{bibliography item}}%
      \setlength{\leftmargin}{\labelwidth}%
      \setlength{\labelsep}{\biblabelsep}%
      \addtolength{\leftmargin}{\labelsep}%
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}}}
  {\endlist}
  {\item}


\defbibheading{bibliography}[\refname]{}

\addbibresource{refs.bib}

```