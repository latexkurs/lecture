% !TEX encoding = UTF-8 Unicode
% © 2016 Moritz Brinkmann, CC-by-sa
% http://latexkurs.github.io


\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{latexkurs-exercise}[2016/06/03 v0.1 Exercise sheets for LaTeX Course]

\LoadClass{scrartcl}

\RequirePackage{
	enumitem,
	fontspec,
	geometry,
	ifthen,
	kvoptions,
	lastpage,
	../tex/latexkurs-commands,
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
\setmonofont[Scale=.85]{Inconsolata}
%\setmonofont[Scale=.99]{Anonymous Pro}

\SetupKeyvalOptions{
	family=latexkurs,
	prefix=ltxkurs@,
}
\DeclareStringOption{blattnr}
\DeclareStringOption{datum}
\DeclareStringOption{ausgabe}
\DeclareStringOption{abgabe}
\DeclareBoolOption{vorläufig}
\ProcessKeyvalOptions{latexkurs}

\geometry{a4paper,vmargin=3cm,head=26.0pt}
\frenchspacing
\reversemarginpar
\hypersetup{
	colorlinks=true,
	linkcolor=blue,
	urlcolor=blue,
}
\renewcommand*{\thefootnote}{\fnsymbol{footnote}}
\pagestyle{scrheadings}
\KOMAoptions{
	headtopline = 1pt,
	headsepline = .6pt,
	footsepline = .6pt,
}
\setkomafont{pagehead}{\normalfont\small\sffamily}
\setkomafont{pagefoot}{\small\itshape}
\ihead{Einführung in das\\Textsatzsystem \LaTeX}
\chead{\bfseries Übungsblatt \ltxkurs@blattnr}
\ohead{\ifthenelse{\equal{\ltxkurs@ausgabe}{}}{\ltxkurs@datum}{Ausgegeben: \ltxkurs@ausgabe}\\\ifthenelse{\equal{\ltxkurs@abgabe}{}}{}{Abgabe: \ltxkurs@abgabe}}
\ifoot{Heidelberg, WS 2016}
\cfoot{}
\ofoot{Seite~\thepage~von~\pageref{LastPage}}

\lstloadlanguages{TeX}
\lstset{% for exercise sheets
	backgroundcolor=\color[rgb]{.9 .9 .9},
	basicstyle=\ttfamily\small,
	breakindent=0em,
	breaklines=true,
	captionpos=b,
	commentstyle=\color{gray},
	%explpreset={numbers=none},
	frame=single,
	%frameround=ffff,
	identifierstyle=,
	keywordstyle=,
	language=[LaTeX]TeX,
	numbers=left,
	pos=r,
	rframe={single},
}

\ifltxkurs@vorläufig
	\AtBeginDocument{\centerline{%
   	\color{red}\Large \sffamily Vorläufige Version}%
		\vspace*{1ex}%
	}
\fi

\providecommand{\abgabe}[1]{\par\noindent\textit{Abgabe:} #1}
