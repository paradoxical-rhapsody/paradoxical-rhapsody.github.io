<!-- Add here global page variables to use throughout your website. -->
+++
author = "Zengchao XU"
mintoclevel = 2

# default variables
title = ""
icon = "house-fill"
tag_page_path = "group-by"

toc_sidebar = false
# prepath = ""


# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = [
    ".vscode/", 
    "pgp-mail/index.md",
]
robots_disallow = [
    "archived-expo/", 
    "cv",
    "dataexpo/", 
    "pgp-mail",
    "recipe/", 
    "research",
    "tales/", 
    "teaching",
]

# RSS (the website_{title, descr, url} must be defined to get RSS)
website_title = "xu-zc"
website_descr = "Zengchao's site"
website_url   = "xu-zc.site"


generate_sitemap = false
generate_rss = false


+++

<!-- Add here global latex commands to use throughout your pages. -->
\newcommand{\scal}[1]{\langle #1 \rangle}

\newcommand{\icon}[1]{~~~<embed src="/assets/icons/!#1.svg"/>~~~}

\newcommand{\list}{~~~<ul>~~~}
\newcommand{\item}[1]{~~~<li class="blank">~~~ #1 ~~~</li>~~~}
\newcommand{\itemcolor}[1]{~~~<li class="colorful">~~~ #1 ~~~</li>~~~}
\newcommand{\endlist}{~~~</ul>~~~}

\newcommand{\link}[2]{~~~<a class="href" href="#2">~~~ #1 ~~~</a>~~~}
\newcommand{\url}[1]{\link{#1}{#1}}
\newcommand{\rpkg}[1]{~~~<a class="href" href="https://mirrors.tuna.tsinghua.edu.cn/CRAN/web/packages/#1">~~~ #1 ~~~</a>~~~}
\newcommand{\underline}[1]{~~~<a class="underline">~~~ #1 ~~~</a>~~~}
\newcommand{\delete}[1]{~~~<a class="delete">~~~ #1 ~~~</a>~~~}
\newcommand{\emph}[1]{~~~<a class="emph">~~~ #1 ~~~</a>~~~}

\newcommand{\includegraphics}[2]{
    ~~~
    <figure style="
        display: flex;
        flex-direction: row;
        align-items: center;
        text-align: left; 
        background-color: #F9F9F9; 
        border: 1px solid #D3D3D3;
        border-radius: 1em;">
    <img src="!#1" style="padding:2em; width:50%;" alt="#1"/>
    <figcaption style="font-size:smaller;">#2</figcaption>
    </figure>
    ~~~
}

<!-- math symbols -->
\newcommand{\rmnum}[1]{\romannumeral #1}
\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}

\newcommand{\vzero}{\mathbf{0}}
\newcommand{\vone}{\mathbf{1}}

\newcommand{\d}{\mathrm{d}}
\newcommand{\E}{\mathrm{E}}
\newcommand{\P}{\mathrm{P}}
\newcommand{\R}{\mathbb R}
\newcommand{\var}{\mathrm{Var}}
\newcommand{\cov}{\mathrm{Cov}}
\newcommand{\cor}{\mathrm{Cor}}
\newcommand{\tr}{\mathrm{tr}}
\newcommand{\sign}{\mathrm{sign}}
\newcommand{\rank}{\mathrm{rank}}
\newcommand{\diag}{\mathrm{diag}}
\newcommand{\dim}{\mathrm{dim}}
\newcommand{\det}{\mathrm{det}}
\newcommand{\max}{\mathrm{max}}
\newcommand{\min}{\mathrm{min}}


\newcommand{\vr}{\mathbf{r}}
\newcommand{\vs}{\mathbf{s}}
\newcommand{\vu}{\mathbf{u}}
\newcommand{\vv}{\mathbf{v}}
\newcommand{\vx}{\mathbf{x}}
\newcommand{\vy}{\mathbf{y}}
\newcommand{\vz}{\mathbf{z}}

\newcommand{\vE}{\mathbf{E}}
\newcommand{\vG}{\mathbf{G}}
\newcommand{\vH}{\mathbf{H}}
\newcommand{\vI}{\mathbf{I}}
\newcommand{\vQ}{\mathbf{Q}}
\newcommand{\vR}{\mathbf{R}}
\newcommand{\vU}{\mathbf{U}}
\newcommand{\vV}{\mathbf{V}}
\newcommand{\vX}{\mathbf{X}}
\newcommand{\vZ}{\mathbf{Z}}


\newcommand{\valpha}{\bm{\alpha}}
\newcommand{\vbeta}{\bm{\beta}}
\newcommand{\vtheta}{\bm{\theta}}
\newcommand{\vmu}{\bm{\mu}}

\newcommand{\vPsi}{\bm{\Psi}}
\newcommand{\vSigma}{\bm{\Sigma}}

# `Actuarial Symbols`
# In TeX, add `\usepackage{actuarialangle}` to use `\angl`
\newcommand{\actsymb}[5]{{_{#1}^{#2}{#3}_{#4}^{#5}}}

<!-- math env -->
