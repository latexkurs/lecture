% !TEX encoding = UTF-8 Unicode
% 
% © 2015–2017 Moritz Brinkmann, CC-by-sa
% http://latexkurs.github.io


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{latexkurs-slides}[2017/07/20 v1.0 beamer slides for LaTeX Course]

\LoadClassWithOptions{beamer}

%% Language
\RequirePackage{polyglossia}
\setmainlanguage{german}
\setotherlanguage{english}

%% Fonts
\RequirePackage{csquotes, fontspec, microtype}
\setsansfont{Linux Biolinum O}
\setromanfont{Linux Libertine O}
\setmonofont[Scale=.95,AutoFakeSlant]{Inconsolata}
%\setmonofont[Scale=.95]{Anonymous Pro}

%% Layout
\mode<presentation>{
	\useinnertheme{circles}
	\usecolortheme[rgb={0,0,.5}]{structure}
	\usecolortheme{whale}
	\usecolortheme{orchid}
	\beamertemplatenavigationsymbolsempty
	\setbeamercolor{alerted text}{fg=blue}
	\renewcommand{\thefootnote}{\fnsymbol{footnote}}
	\setbeamertemplate{footline}[frame number]
}

%% Listings
\RequirePackage{showexpl}
\lstloadlanguages{TeX}
\lstset{% for slides
	language=TeX,
	backgroundcolor=\color[RGB]{229, 229, 239},
	basicstyle=\ttfamily\small,
	breakindent=0em,
	breaklines=true,
	captionpos=b,
	commentstyle=\color{blue},
	explpreset={numbers=none},
	frame=lines,
	frameround=ffff,
	identifierstyle=,
	keywordstyle=,
	language=[LaTeX]TeX,
	numbers=none,
	pos=r,
	rframe={single},
}

%% Option Handling
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=latexkurs,
	prefix=ltxkurs@,
}
\DeclareStringOption{titel}
\DeclareStringOption{datum}
\DeclareBoolOption{vorläufig}
\DeclareBoolOption{web}
\DeclareBoolOption{noshortverb}
\DeclareBoolOption{max}
\DeclareBoolOption{mo}
\ProcessKeyvalOptions{latexkurs}

\ifltxkurs@noshortverb
	\PassOptionsToPackage{shortverb=false}{../tex/latexkurs-commands}
\else
	\PassOptionsToPackage{shortverb=true}{../tex/latexkurs-commands}
\fi

%% Preliminal Version
\ifltxkurs@vorläufig
	\institute{\color{red}\Large Vorläufige Version}
\fi

%% Date Formating
\RequirePackage[useregional]{datetime2}
\DTMusemodule{german}{german}
\date{\DTMdate{\ltxkurs@datum}}

%% Titlepage
\title{Einführung in das Textsatzsystem \LaTeX{}}
\subtitle{\ltxkurs@titel}
\let\authorstring\@empty
\ifltxkurs@mo
	\g@addto@macro{\authorstring}{Moritz Brinkmann\\{\small\url{moritz.brinkmann@iwr.uni-heidelberg.de}}\ifltxkurs@max\\[1em]\fi}
\fi
\ifltxkurs@max
	\g@addto@macro{\authorstring}{Maximilian Jalea\\{\small\url{max@mathphys.stura.uni-heidelberg.de}}}
\fi
\author{\authorstring}
\AtBeginDocument{
	\frame{\thispagestyle{empty}\titlepage}
}

%% overleaf
\RequirePackage{tikz,qrcode}
\usetikzlibrary{calc}
\tikzset{ href node/.style={alias=sourcenode,append after command={let \p1 = (sourcenode.north west),  \p2=(sourcenode.south east),\n1={\x2-\x1},\n2={\y1-\y2} in node [inner sep=0pt, outer sep=0pt,anchor=north west,at=(\p1)] {\href{#1}{\phantom{\rule{\n1}{\n2}}}}}}} % http://tex.stackexchange.com/a/36111
\providecommand{\overleaf}[1]{
	\thispagestyle{empty}
	\begin{tikzpicture}[remember picture,overlay]
		\node [xshift=-1.2cm,yshift=1.5cm, href node={http://polr.me/#1}] at (current page.south east)
		{
			\scalebox{.55}{\parbox{4.1cm}{
				In Overleaf ausprobieren:\\[.8ex]
				\qrcode[height=4cm]{http://polr.me/#1}\\[1ex]
				\url{http://polr.me/#1}
			}}
		};
	\end{tikzpicture}
}
% provide column layout for pages containing overleaf QRcode:
\newenvironment{olcol}{
	\begin{columns}\begin{column}{.8\textwidth}
}{
	\end{column}\begin{column}{.108\textwidth}\relax\end{column}\end{columns}
}

%% PDF Annotations for web release
\ifltxkurs@web
	\RequirePackage{pdfcomment}
	\providecommand{\pdfmarginpar}[2][]{\pdfmargincomment[#1]{#2}}
\else
	\providecommand{\pdfmarginpar}[2][]{\null}
\fi

%% Bibliography
\usepackage[backend=biber, style=numeric, sorting=none, doi=false, url=false, isbn=false, block=par]{biblatex}
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
  
\newbibmacro{string+doiurlisbn}[1]{%
  \iffieldundef{url}{%
    \iffieldundef{doi}{%
      \iffieldundef{isbn}{%
        \iffieldundef{issn}{%
          #1%
        }{%
          \href{http://books.google.com/books?vid=ISSN\thefield{issn}}{#1}%
        }%
      }{%
        \href{http://books.google.com/books?vid=ISBN\thefield{isbn}}{#1}%
      }%
    }{%
      \href{http://dx.doi.org/\thefield{doi}}{#1}%
    }%
  }{%
    \href{\thefield{url}}{#1}%
  }%
}

\renewbibmacro*{issue+date}{%
  \setunit{\addcomma\space}% NEW
%  \printtext[parens]{% DELETED
    \iffieldundef{issue}
      {\usebibmacro{date}}
      {\printfield{issue}%
       \setunit*{\addspace}%
%       \usebibmacro{date}}}% DELETED
       \usebibmacro{date}}% NEW
  \newunit}

\DeclareFieldFormat{title}{\usebibmacro{string+doiurlisbn}{\mkbibquote{#1}}\nopunct}
\DeclareFieldFormat[article,incollection]{title}%
    {\usebibmacro{string+doiurlisbn}{\mkbibquote{#1}}\nopunct}
\DeclareFieldFormat[article,book]{author}{#1\nopunct}
\DeclareFieldFormat{note}{\usebibmacro{string+doiurlisbn}{\texttt{#1}}\nopunct}

\renewbibmacro{in:}{}
\renewbibmacro{isdot}{}

\addbibresource{literatur.bib}
%\AtEndDocument{
\newcommand{\weiterführendeliteratur}{\frame[allowframebreaks]{\frametitle{Weiterführende Literatur}\printbibliography}}

%% Hypersetup
\RequirePackage{hyperref}
\hypersetup{%
  unicode=true,
  pdfborder={000},
  colorlinks=false,
  pdftitle={Einführung in das Textsatzsystem LaTeX},
  pdfauthor={Moritz Brinkmann},
}


%% load shared package
\RequirePackage{../tex/latexkurs-commands}
