%% hgbthesis.cls
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wilhelm Burger (wilhelm.burger@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

\NeedsTeXFormat{LaTeX2e}
\newcommand{\hgbthesisDate}{2017/02/28} %version string
\ProvidesClass{hgbthesis}[\hgbthesisDate\space LaTeX template for creating diploma theses, masters's theses, bachelor's theses and other term papers.]


\RequirePackage{ifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbthesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbthesis: *** LaTeX NOT running in PDF mode ***}}
\fi

\newcommand{\hgb@MainLanguage}{german}	% also referenced in hgb.sty
\newcommand{\@mastertitlepages}{}
\newcommand{\@diplomatitlepages}{}
\newcommand{\@bachelortitlepages}{}
\newcommand{\@internshiptitlepages}{}
\newcommand{\@maketitlepages}{\@mastertitlepages}  %Default: Master's thesis


%% Begin class options ---------------------------------------------
\DeclareOption{master}{
	\renewcommand{\@maketitlepages}{\@mastertitlepages}
}

\DeclareOption{diplom}{%
	\renewcommand{\@maketitlepages}{\@diplomatitlepages}
	\ClassWarning{hgbthesis}{Deprecated: Document option '\CurrentOption' is deprecated. Use Use 'diploma' instead.}
}

\DeclareOption{diploma}{%
	\renewcommand{\@maketitlepages}{\@diplomatitlepages}
}

\DeclareOption{bachelor}{%
	\renewcommand{\@maketitlepages}{\@bachelortitlepages}
}

\DeclareOption{praktikum}{%
	\renewcommand{\@maketitlepages}{\@internshiptitlepages}
	\ClassWarning{hgbthesis}{Deprecated: Document option '\CurrentOption' is deprecated. Use Use 'internship' instead.}
}

\DeclareOption{internship}{%
	\renewcommand{\@maketitlepages}{\@internshiptitlepages}
}

\DeclareOption{english}{%
	\renewcommand{\hgb@MainLanguage}{english}
}

\DeclareOption{german}{%
	\renewcommand{\hgb@MainLanguage}{german}
}

\DeclareOption*{%
	\ClassWarning{hgbthesis}{Unknown document option '\CurrentOption'.}
}

\ProcessOptions
%% End class options ---------------------------------------------
 
\LoadClass[a4paper,11pt,oneside]{book}
 
\RequirePackage{hgb}	% load associated style file hgb.sty


%-------------- Setup for pages in the front matter --------------------

\newcommand{\@studiengang}{\@MissingArg{Degree program not specified!}}
\newcommand{\studiengang}[1]{%
	\renewcommand{\@studiengang}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\studiengang' is deprecated. Use '\string\degreeprogram' instead.}
}
\newcommand{\degreeprogram}[1]{%
	\renewcommand{\@studiengang}{#1}
}

\newcommand{\@studienort}{\@MissingArg{Place of study not specified!}}
\newcommand{\studienort}[1]{%
	\renewcommand{\@studienort}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\studienort' is deprecated. Use '\string\placeofstudy' instead.}
}
\newcommand{\placeofstudy}[1]{%
	\renewcommand{\@studienort}{#1}
}

\newcommand{\@betreuerName}{\@MissingArg{Advisor not specified!}}

\newcommand{\betreuer}[1]{%
  \renewcommand{\@betreuerName}{#1}
  \ClassWarning{hgbthesis}{Deprecated: '\string\betreuer' is deprecated. Use '\string\advisor' instead.}
}
\newcommand{\betreuerin}[1]{%
  \renewcommand{\@betreuerName}{#1}
  \ClassWarning{hgbthesis}{Deprecated: '\string\betreuerin' is deprecated. Use '\string\advisor' instead.}
}
\newcommand{\advisor}[1]{%
  \renewcommand{\@betreuerName}{#1}
}

\newcommand{\@nummer}{\@MissingArg{Thesis number not specified!}}
\newcommand{\nummer}[1]{%
	\renewcommand{\@nummer}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\nummer' is deprecated. Use '\string\thesisnumber' instead.}
}
\newcommand{\thesisnumber}[1]{%
	\renewcommand{\@nummer}{#1}
}

\newcommand{\@gegenstand}{\@MissingArg{Course not specified!}}
\newcommand{\gegenstand}[1]{%
	\renewcommand{\@gegenstand}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\gegenstand' is deprecated. Use '\string\course' instead.}
}
\newcommand{\course}[1]{%
	\renewcommand{\@gegenstand}{#1}
}

\newcommand{\@semester}{\@MissingArg{Semester not specified!}}
\newcommand{\semester}[1]{%
	\renewcommand{\@semester}{#1}
}

\newcommand{\@logofile}[0]{}
\newcommand{\logofile}[1]{%
	\renewcommand{\@logofile}{#1}
}

\newcommand{\makelogo}[0]{%
\ifthenelse{\equal{\@logofile}{}}%
	{\vspace*{30mm}}%
	{\includegraphics[height=30mm]{\@logofile}}%
}

%% -------------------------------------------------

\newcounter{@abgabetag}
\newcounter{@abgabemonat}
\newcounter{@abgabejahr}

\setcounter{@abgabetag}{\the\day}
\setcounter{@abgabemonat}{\the\month}
\setcounter{@abgabejahr}{\the\year}

\newcommand{\abgabedatum}[3]{%	%\abgabedatum{yyyy}{mm}{dd}
	\setcounter{@abgabejahr}{#1}
	\setcounter{@abgabemonat}{#2}
	\setcounter{@abgabetag}{#3}
	\ClassWarning{hgbthesis}{Deprecated: '\string\abgabedatum' is deprecated. Use '\string\dateofsubmission' instead.}
}
\newcommand{\dateofsubmission}[3]{%	%\dateofsubmission{yyyy}{mm}{dd}
	\setcounter{@abgabejahr}{#1}
	\setcounter{@abgabemonat}{#2}
	\setcounter{@abgabetag}{#3}
}

\newcommand{\abgabemonat}[1]{%
	\ClassWarning{hgbthesis}{Deprecated: '\string\abgabemonat' is deprecated. Use '\string\dateofsubmission' instead.}
}

\newcommand{\abgabejahr}[1]{%
	\ClassWarning{hgbthesis}{Deprecated: '\string\abgabejahr' is deprecated. Use '\string\dateofsubmission' instead.}
}

%% ----------------------------------------------------------

\newcommand{\@firma}{\@MissingArg{Company not specified!}}
\newcommand{\firma}[1]{%
	\renewcommand{\@firma}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\firma' is deprecated. Use '\string\company' instead.}
}
\newcommand{\company}[1]{%
	\renewcommand{\@firma}{#1}
}

\newcommand{\@firmenUrl}{\@MissingArg{Company URL not specified!}}
\newcommand{\firmenUrl}[1]{%
	\renewcommand{\@firmenUrl}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\firmenUrl' is deprecated. Use '\string\companyUrl' instead.}
}
\newcommand{\companyUrl}[1]{%
	\renewcommand{\@firmenUrl}{#1}
}

\newcommand{\@firmenTel}{\@MissingArg{Company phone number not specified!}}
\newcommand{\firmenTel}[1]{%
	\renewcommand{\@firmenTel}{#1}
	\ClassWarning{hgbthesis}{Deprecated: '\string\firmenTel' is deprecated. Use '\string\companyPhone' instead.}
}
\newcommand{\companyPhone}[1]{%
	\renewcommand{\@firmenTel}{#1}
}

\newcommand{\@license}{\@MissingArg{License information is missing!}}
\newcommand{\license}[1]{%
	\renewcommand{\@license}{#1}
}

%------------------ Titelseiten -------------------

%% deprecated - use \maketitle instead!
\newcommand{\titelseite}{ 
  \ClassWarning{hgbthesis}{\noexpand\titelseite is deprecated - use \noexpand\maketitle instead}
  \maketitle
}

%% adds blank space after each letter (http://stackoverflow.com/a/3951837)
\newcommand{\@addspaces}[1]{%  
  \@tfor\letter:=#1\do{%
    \letter\thinspace%	%\space
  }%
}

\newcommand{\@batitel}{%
\begin{titlepage}%
\begin{german}
\rule{0mm}{1mm}
\vspace*{0mm}
\begin{center}%
	\normalfont
  \setlength{\unitlength}{1cm}
	\parbox[c][5cm][c]{12cm}{\centering\LARGE\bfseries%
    \setlength{\baselineskip}{25pt}%
    \@title}
	\vskip 15mm%
	{\large\scshape\@author}%
	\vskip 15mm%
	\makelogo%
	\vskip 15mm%
	{\Large\uppercase{\@addspaces{Bachelorarbeit}}}%
	\vskip 4mm%
  {\large Nr.~\@nummer}
	\vskip 4mm%
	{\large eingereicht am} \vskip 1mm {Fachhochschul-Bachelorstudiengang}%
	\vskip 4mm%
	{\large\@studiengang}%
	\vskip 4mm%
	{\large in \@studienort}%
	\vskip 16mm%
	{\large im \monthname[\value{@abgabemonat}] \arabic{@abgabejahr}}%
\end{center}%
  \vfil%
\end{german}
\end{titlepage}%
}

\newcommand{\@matitel}{%
\begin{titlepage}%
\begin{german}
\rule{0mm}{1mm}
\vspace*{0mm}
\begin{center}%
	\normalfont
  \setlength{\unitlength}{1cm}
	\parbox[c][5cm][c]{12cm}{\centering\LARGE\bfseries%%
    \setlength{\baselineskip}{25pt}%
    \@title}
	\vskip 15mm%
	{\large\scshape\@author}%
	\vskip 15mm%
	\makelogo%
	\vskip 15mm%
	{\Large\uppercase{\@addspaces{Masterarbeit}}}%
	\vskip 4mm%
	{\large eingereicht am} \vskip 1mm {Fachhochschul-Masterstudiengang}%
	\vskip 4mm%
	{\large\@studiengang}%
	\vskip 4mm%
	{\large in \@studienort}%
	\vskip 16mm%
	{\large im \monthname[\value{@abgabemonat}] \arabic{@abgabejahr}}%
\end{center}%
  \vfil%
\end{german}
\end{titlepage}%
}

\newcommand{\@datitel}{%
\begin{titlepage}%
\begin{german}
\rule{0mm}{1mm}
\vspace*{0mm}
\begin{center}%
	\normalfont
  \setlength{\unitlength}{1cm}
	\parbox[c][5cm][c]{12cm}{\centering\LARGE\bfseries%
    \setlength{\baselineskip}{25pt}%
    \@title}
	\vskip 15mm%
	{\large\scshape\@author}%
	\vskip 15mm%
	\makelogo%
	\vskip 15mm%
	{\Large\uppercase{\@addspaces{Diplomarbeit}}}%
	\vskip 4mm%
	{\large eingereicht am} \vskip 1mm {Fachhochschul-Diplomstudiengang}%
	\vskip 4mm%
	{\large\@studiengang}%
	\vskip 4mm%
	{\large in \@studienort}%
	\vskip 16mm%
	{\large im \monthname[\value{@abgabemonat}] \arabic{@abgabejahr}}%
\end{center}%
  \vfil%
\end{german}
\end{titlepage}%
}

\newcommand{\@prtitel}{%
\begin{titlepage}%
\begin{german}
\rule{0mm}{1mm}
\vspace*{0mm}
\begin{center}%
	\normalfont
  \setlength{\unitlength}{1cm}
	\parbox[c][5cm][c]{12cm}{\centering\LARGE\bfseries%
    \setlength{\baselineskip}{25pt}%
    Endbericht zum Berufspraktikum}
	\vskip 15mm%
	{\large\scshape\@author}%
	\vskip 15mm%
	\makelogo%
	\vskip 15mm%
	{\Large\uppercase{\@addspaces{Bachelorarbeit}}}%
	\vskip 4mm%
  {\large Nr.~\@nummer}
	\vskip 4mm%
	{\large eingereicht am} \vskip 1mm {Fachhochschul-Bachelorstudiengang}%
	\vskip 4mm%
	{\large\@studiengang}%
	\vskip 4mm%
	{\large in \@studienort}%
	\vskip 16mm%
	{\large im \monthname[\value{@abgabemonat}] \arabic{@abgabejahr}}%
\end{center}%
  \vfil%
\end{german}
\end{titlepage}%
}


%------------------ Copyright-Seite -------------------

\newcommand{\strictlicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\license{Alle Rechte vorbehalten}}%
	{\license{All Rights Reserved}}
}

\newcommand{\@ccLicenseAt}{%
Diese Arbeit wird unter den Bedingungen der \textsl{Creative Commons Lizenz} 
\emph{Namens\-nennung--NichtKommerziell--Keine\-Bearbeitung \"Osterreich} 
(CC BY-NC-ND) ver\"offentlicht --
siehe \url{http://creativecommons.org/licenses/by-nc-nd/3.0/at/}.}

\newcommand{\@ccLicenseEn}{%
This work is published under the conditions of the 
\textsl{Creative Commons License Attribution--Non\-Commercial--No\-Derivatives} 
(CC BY-NC-ND)---see
\url{http://creativecommons.org/licenses/by-nc-nd/3.0/}.}

\newcommand{\cclicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
{\license{\@ccLicenseAt}} % german CC license text
{\license{\@ccLicenseEn}} % english CC license text (default)
}
	
%\strictlicense
\cclicense	% Creative Commons License (default)

\newcommand{\@makelicense}{ 
  \sbox\@tempboxa{\@license}%
  \ifdim \wd\@tempboxa >\hsize
    \begin{sloppypar}\noindent\@license\end{sloppypar}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
} 

\newcommand{\@copyrightseite}{%
\newpage
\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\vspace*{75mm}
\begin{center}
\copyright\ Copyright\ \arabic{@abgabejahr}\ \@author
\end{center}
\vspace{8mm}
\@makelicense
%\begin{center}
%\includegraphics[width=2.0cm]{images/by-nc-nd-eu}
%\end{center}
}

%------------------ Firmen-Seite -------------------
\newcommand{\@firmenseite}{%
\newpage
\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\begin{center}
\vspace{25mm} 
{Praktikumsstelle:}
\\
\vspace{3mm}
{\Large\sf\@firma\\ \mbox{}}
\\
{\sf \@firmenTel}
\\
{\sf \@firmenUrl}
\\
\vspace{45mm} 
{Kontaktperson:}
\\
\vspace{3mm} 
{\Large\sf\@betreuerName\\ \mbox{}}
\end{center}
}

%------------------ Betreuer-Seite -------------------

\newcommand{\@babetreuerseiteDe}{%
\newpage
\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\begin{center}
%
\vspace{40mm} 
{Diese Arbeit entstand im Rahmen des Gegenstands}\\
\vspace{6mm} 
{\Large\sf \@gegenstand\\ \mbox{}}\\
\medskip
im\\
\bigskip
{\@semester}\\
%
\vspace{45mm} 
{Betreut durch:}\\
\vspace{3mm} 
{\Large\sf \@betreuerName\\ \mbox{}}
\end{center}
}

\newcommand{\@babetreuerseiteEn}{%
\newpage
\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\begin{center}
%
\vspace{40mm} 
{This thesis was created as part of the course}\\
\vspace{6mm} 
{\Large\sf \@gegenstand\\ \mbox{}}\\
\medskip
during\\
\bigskip
{\@semester}\\
%
\vspace{45mm} 
{Advisor:}\\
\vspace{3mm} 
{\Large\sf \@betreuerName\\ \mbox{}}
\end{center}
}

\newcommand{\@babetreuerseite}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\@babetreuerseiteDe}%
	{\@babetreuerseiteEn}
}

%% -------------- Erklaerung / Declaration ---------

\newcommand{\@erklaerungsseiteDe}{%
\begin{german}
\chapter{Erkl\"arung}
\noindent
%Standardfassung der FH-OOe ab 04.04.2012:
Ich erkl\"are eidesstattlich, dass ich die vorliegende Arbeit selbstst\"andig und ohne fremde Hilfe verfasst, 
andere als die angegebenen Quellen nicht benutzt und die den benutzten Quellen entnommenen Stellen als 
solche gekennzeichnet habe. Die Arbeit wurde bisher in gleicher oder \"ahnlicher Form keiner anderen 
Pr\"ufungsbeh\"orde vorgelegt.
\par
\vspace{10mm}
\noindent
\@studienort, am \formatdate{\value{@abgabetag}}{\value{@abgabemonat}}{\value{@abgabejahr}}
\par
\vspace{12mm}
\noindent
\@author
\end{german}
}

\newcommand{\leadingzero}[1]{\ifnum #1<10 0\the#1\else\the#1\fi}

\newcommand{\@erklaerungsseiteEn}{%
\begin{english}
\chapter{Declaration}
\noindent
I hereby declare and confirm that this thesis is entirely the result of my own original work. 
Where other sources of information have been used, they have been indicated as such and properly 
acknowledged. I further declare that this or similar work has not been submitted for credit elsewhere.
\par
\vspace{10mm}
\noindent
%\@studienort, \the\year-\leadingzero{\month}-\leadingzero{\day} %http://de.wikibooks.org/wiki/LaTeX-W%F6rterbuch:_today 
\@studienort, {\usdate\formatdate{\value{@abgabetag}}{\value{@abgabemonat}}{\value{@abgabejahr}}}
\par
\vspace{12mm}
\noindent
\@author
\end{english}
}

\newcommand{\@erklaerungsseite}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\@erklaerungsseiteDe}%
	{\@erklaerungsseiteEn}
}


%------------ Struktur der Frontseiten -------------------

\renewcommand{\@mastertitlepages}{
\@matitel
\@copyrightseite
\@erklaerungsseite
}
     
\renewcommand{\@diplomatitlepages}{
\@datitel
\@copyrightseite
\@erklaerungsseite
}

\renewcommand{\@bachelortitlepages}{
\@batitel
\@babetreuerseite
\@erklaerungsseite
}

\renewcommand{\@internshiptitlepages}{
\@prtitel
\@firmenseite
\@erklaerungsseite
}

%------------ Automatischer Eintrag der PDF Metadaten ------------

\renewcommand{\maketitle}{	%replace standard LaTeX-command
\hypersetup{
		pdftitle={\@title},
		pdfauthor={\@author},
		pdfsubject={\@studiengang, \@studienort},
		pdfcreator={LaTeX using class hgbthesis},
		pdfproducer={},
		pdfkeywords={}
}%
\@maketitlepages
}

%%-------------------------------------------------------------

\usepackage{hgbheadings}
\usepackage{hgbabbrev}
\usepackage{hgblistings}
\usepackage{hgbbib}

%%-------------------------------------------------------------

\endinput

