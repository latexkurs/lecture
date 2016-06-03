% !TEX encoding = UTF-8 Unicode
% © 2016 Moritz Brinkmann, CC-by-sa
% http://latexkurs.github.io


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{latexkurs-slides}[2016/06/03 v0.1 beamer slides for LaTeX Course]

\LoadClassWithOptions{beamer}


\RequirePackage{
	fontspec,
	geometry,
	lastpage,
	microtype,
	polyglossia,
	scrlayer-scrpage,
	showexpl,
	xspace,
	hyperref,
}


\setmainlanguage{german}
\setotherlanguage{english}

\setsansfont{Linux Biolinum O}
\setromanfont{Linux Libertine O}
\setmonofont[Scale=.95,AutoFakeSlant]{Inconsolata}
%\setmonofont[Scale=.99]{Anonymous Pro}


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