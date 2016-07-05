% !TEX encoding = UTF-8 Unicode
% © 2016 Moritz Brinkmann, CC-by-sa
% http://latexkurs.github.io


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{latexkurs-slides}[2016/06/03 v0.1 beamer slides for LaTeX Course]

\LoadClass[aspectratio=43]{beamer}

\RequirePackage{
	../tex/latexkurs-commands,
	showexpl,
	xspace,
}

%% Language
\RequirePackage{polyglossia}
\setmainlanguage{german}
\setotherlanguage{english}

%% Fonts
\RequirePackage{fontspec, microtype}
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
\SetupKeyvalOptions{
	family=latexkurs,
	prefix=ltxkurs@,
}
\DeclareStringOption{titel}
\DeclareStringOption{datum}
\DeclareBoolOption{vorläufig}
\DeclareBoolOption{web}
\ProcessKeyvalOptions{latexkurs}

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
\author[Mo]{Moritz Brinkmann\\\url{moritz.brinkmann@iwr.uni-heidelberg.de}}
\AtBeginDocument{
	\MakeShortVerb{\|}
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

%% Hypersetup
\RequirePackage{hyperref}
\hypersetup{%
  unicode=true,
  pdfborder={000},
  colorlinks=false,
  pdftitle={Einführung in das Textsatzsystem LaTeX},
  pdfauthor={Moritz Brinkmann},
}
