%% hgbthesis.cls
%% LaTeX template for creating diploma theses, masters's theses, bachelor's theses and other term papers.
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wilhelm Burger (wilhelm.burger@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbthesis}[2021/06/24]%%AUTO

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbthesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbthesis: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Commands for Title Pages (used in class options) ---------------------------

\newcommand{\hgb@MainLanguage}{german}	% also referenced in hgb.sty
\newcommand{\@mastertitlepages}{}
\newcommand{\@diplomatitlepages}{}
\newcommand{\@bachelortitlepages}{}
\newcommand{\@internshiptitlepages}{}
\newcommand{\@maketitlepages}{\@mastertitlepages}  %Default: Master's thesis


\newcommand{\@titlepagefont}{\sffamily}

%% Handling class options --------------------------------------------------------------

\DeclareOption{master}{\renewcommand{\@maketitlepages}{\@mastertitlepages}}
\DeclareOption{bachelor}{\renewcommand{\@maketitlepages}{\@bachelortitlepages}}
\DeclareOption{diploma}{\renewcommand{\@maketitlepages}{\@diplomatitlepages}}
\DeclareOption{internship}{\renewcommand{\@maketitlepages}{\@internshiptitlepages}}
\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
% pass all other options to hgb.sty
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
\ProcessOptions*

%% Paper Options and Style File -----------------------------------------------

\LoadClass[a4paper,11pt,oneside]{book}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
 
\RequirePackage{hgb}	% load style file hgb.sty with options registered above


%% Setup for Pages in the Front Matter ----------------------------------------

% General Commands

\newcommand{\@programtype}{\@MissingArg{Type of degree program not specified!}}
\newcommand{\programtype}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\@programtype}{#1}}
}

\newcommand{\@programname}{\@MissingArg{Name of degree program not specified!}}
\newcommand{\programname}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\@programname}{#1}}
}

\newcommand{\@placeofstudy}{\@MissingArg{Place of study not specified!}}
\newcommand{\placeofstudy}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\@placeofstudy}{#1}}
}

\newcommand{\@advisor}{}					% empty by default
\newcommand{\advisor}[1]{%
	\renewcommand{\@advisor}{#1}		
}

\newcommand{\thesisnumber}[1]{%
	\ClassWarning{hgbthesis}{command '\protect\thesisnumber' is not supported any longer.}
}

\newcommand{\coursetitle}[1]{%
	\ClassWarning{hgbthesis}{command '\protect\coursetitle' is not supported any longer.}
}

\newcommand{\semester}[1]{%
	\ClassWarning{hgbthesis}{command '\protect\semester' is not supported any longer.}
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

% Submission Commands

\newcounter{@dayofsubmission}
\newcounter{@monthofsubmission}
\newcounter{@yearofsubmission}

\setcounter{@dayofsubmission}{\the\day}
\setcounter{@monthofsubmission}{\the\month}
\setcounter{@yearofsubmission}{\the\year}

\newcommand{\dateofsubmission}[3]{%	%\dateofsubmission{yyyy}{mm}{dd}
	\setcounter{@yearofsubmission}{#1}
	\setcounter{@monthofsubmission}{#2}
	\setcounter{@dayofsubmission}{#3}
}

% Internship Report Commands

\newcommand{\@companyName}{\@MissingArg{Company not specified!}}
\newcommand{\companyName}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\@companyName}{#1}}
}

\newcommand{\@companyUrl}{\@MissingArg{Company URL not specified!}}
\newcommand{\companyUrl}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\@companyUrl}{#1}}
}

\newcommand{\companyPhone}[1]{%
	\ClassWarning{hgbthesis}{command '\protect\companyPhone' is not supported any longer.}
}

%% ----------------------------------------------------------------------------

\newcommand{\@license}{\@MissingArg{License information is missing!}}
\newcommand{\license}[1]{%
	\renewcommand{\@license}{#1}
}

%% Commands for Creating the Title Pages --------------------------------------



%% adds blank space after each letter (http://stackoverflow.com/a/3951837)
\newcommand{\@addspaces}[1]{%  
  \@tfor\letter:=#1\do{%
    \letter\thinspace%	%\space
  }%
}

\newcommand{\@bachelortitle}{%
\begin{titlepage}%
	\begin{german}
		\rule{0mm}{1mm}
		\vspace*{0mm}
		\begin{center}%
			\@titlepagefont %\normalfont
			\setlength{\unitlength}{1cm}
			\parbox[c][5cm][c]{12cm}{%
				\centering\LARGE\bfseries%
				\setlength{\baselineskip}{25pt}%
				\@title%
			}
			\vskip 15mm%
			{\large\@author}%{\large\scshape\@author}%
			\vskip 15mm%
			\makelogo%
			\vskip 15mm%
			{\Large\uppercase{\@addspaces{Bachelorarbeit}}}%
			\vskip 4mm%
			%{\large Nr.~\@thesisnumber}
			%\vskip 4mm%
			{\large eingereicht am} \vskip 1mm {\@programtype}%
			\vskip 4mm%
			{\large\@programname}%
			\vskip 4mm%
			{\large in \@placeofstudy}%
			\vskip 16mm%
			{\large im \DTMgermanmonthname{\value{@monthofsubmission}} \arabic{@yearofsubmission}}%
		\end{center}%
		\vfil%
	\end{german}
\end{titlepage}%
}

\newcommand{\@mastertitle}{%
\begin{titlepage}%
	\begin{german}
		\rule{0mm}{1mm}
		\vspace*{0mm}
		\begin{center}%
			\@titlepagefont %\normalfont
			\setlength{\unitlength}{1cm}
			\parbox[c][5cm][c]{12cm}{%
				\centering\LARGE\bfseries%%
				\setlength{\baselineskip}{25pt}%
				\@title%
			}
			\vskip 15mm%
			{\large\@author}%{\large\scshape\@author}%
			\vskip 15mm%
			\makelogo%
			\vskip 15mm%
			{\Large\uppercase{\@addspaces{Masterarbeit}}}%
			\vskip 4mm%
			{\large eingereicht am} \vskip 1mm {\@programtype}%
			\vskip 4mm%
			{\large\@programname}%
			\vskip 4mm%
			{\large in \@placeofstudy}%
			\vskip 16mm%
			%{\large im \monthname[\value{@monthofsubmission}] \arabic{@yearofsubmission}}%
			{\large im \DTMgermanmonthname{\value{@monthofsubmission}} \arabic{@yearofsubmission}}%
		\end{center}%
		\vfil%
	\end{german}
\end{titlepage}%
}

\newcommand{\@diplomatitle}{%
\begin{titlepage}%
	\begin{german}
		\rule{0mm}{1mm}
		\vspace*{0mm}
		\begin{center}%
			\@titlepagefont %\normalfont
			\setlength{\unitlength}{1cm}
			\parbox[c][5cm][c]{12cm}{%
				\centering\LARGE\bfseries%
				\setlength{\baselineskip}{25pt}%
				\@title%
			}
			\vskip 15mm%
			{\large\@author}%{\large\scshape\@author}%
			\vskip 15mm%
			\makelogo%
			\vskip 15mm%
			{\Large\uppercase{\@addspaces{Diplomarbeit}}}%
			\vskip 4mm%
			{\large eingereicht am} \vskip 1mm {\@programtype}%
			\vskip 4mm%
			{\large\@programname}%
			\vskip 4mm%
			{\large in \@placeofstudy}%
			\vskip 16mm%
			%{\large im \monthname[\value{@monthofsubmission}] \arabic{@yearofsubmission}}%
			{\large im \DTMgermanmonthname{\value{@monthofsubmission}} \arabic{@yearofsubmission}}%
		\end{center}%
		\vfil%
	\end{german}
\end{titlepage}%
}

\newcommand{\@internshiptitle}{%
\begin{titlepage}%
	\begin{german}
		\rule{0mm}{1mm}
		\vspace*{0mm}
		\begin{center}%
			\@titlepagefont %\normalfont
			\setlength{\unitlength}{1cm}
			\parbox[c][5cm][c]{12cm}{%
				\centering\LARGE\bfseries%
				\setlength{\baselineskip}{25pt}%
				\@title%
			}
			\vskip 15mm%
			{\large\@author}%{\large\scshape\@author}%
			\vskip 15mm%
			\makelogo%
			\vskip 15mm%
			{\Large\uppercase{\@addspaces{Praktikumsbericht}}}%
			\vskip 4mm%
			%{\large Nr.~\@thesisnumber}
			%\vskip 4mm%
			{\large eingereicht am} \vskip 1mm {\@programtype}%
			\vskip 4mm%
			{\large\@programname}%
			\vskip 4mm%
			{\large in \@placeofstudy}%
			\vskip 16mm%
			%{\large im \monthname[\value{@monthofsubmission}] \arabic{@yearofsubmission}}%
			{\large im \DTMgermanmonthname{\value{@monthofsubmission}} \arabic{@yearofsubmission}}%
		\end{center}%
		\vfil%
	\end{german}
\end{titlepage}%
}


% Copyright and License Page --------------------------------------------------

\newcommand{\strictlicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\license{Alle Rechte vorbehalten}}%
	{\license{All Rights Reserved}}
}

\newcommand{\@ccLicenseAt}{%
Diese Arbeit wird unter den Bedingungen der 
\textsf{Creative Commons Lizenz} 
\emph{Attribution-NonCommercial-NoDerivatives 4.0 International} 
(CC BY-NC-ND 4.0) ver\"offentlicht --
siehe \url{https://creativecommons.org/licenses/by-nc-nd/4.0/}.}

\newcommand{\@ccLicenseEn}{%
This work is published under the conditions of the 
\textsf{Creative Commons License} 
\emph{Attribution-NonCommercial-NoDerivatives 4.0 International} 
(CC BY-NC-ND 4.0)---see
\url{https://creativecommons.org/licenses/by-nc-nd/4.0/}.}

\newcommand{\cclicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\license{\@ccLicenseAt}} % german CC license text
	{\license{\@ccLicenseEn}} % english CC license text (default)
}
	
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

\newcommand{\@copyrightpage}{%
\newpage
%\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\vspace*{75mm}
\begin{center}
\textsf{\copyright\ Copyright\ \arabic{@yearofsubmission}\ \@author}
\end{center}
\vspace{8mm}
\@makelicense
}


%% Company Page for Internship Report -----------------------------------------

\newcommand{\@companypage}{%
\newpage
\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\begin{center}
\vspace{25mm} 
{Praktikumsstelle:}
\\
\vspace{3mm}
{\Large\sf\@companyName\\ \mbox{}}
\\
{\sf \@companyUrl}
\\
\vspace{45mm} 
{Kontaktperson:}
\\
\vspace{3mm}
{\Large\sf\@advisor\\ \mbox{}}
\end{center}
}


%% Advisor Page ----------------------------------------

\newcommand{\@advisorpage}{%
	\newpage
	\setcounter{page}{2}
	\thispagestyle{plain}
	\rule{0mm}{1mm}
	\vspace{90mm}
	\begin{center}
		\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
			{Betreuung:}%
			{Advisor:}%
		\\
		\vspace{3mm} 
		{\Large\sf \@advisor\\ \mbox{}}
	\end{center}
}

%% Declaration Pages in German and English ------------------------------------

% German

\newcommand{\@declarationpageDe}{%
	\begin{german}
		\chapter{Erkl\"arung}
		\noindent
		%Standardfassung der FH-OOe ab 04.04.2012:
		Ich erkl\"are eidesstattlich, dass ich die vorliegende Arbeit selbstst\"andig und ohne fremde Hilfe verfasst, 
		andere als die angegebenen Quellen nicht benutzt und die den benutzten Quellen entnommenen Stellen als 
		solche gekennzeichnet habe. Die Arbeit wurde bisher in gleicher oder \"ahnlicher Form keiner anderen 
		Pr\"ufungsbeh\"orde vorgelegt.
		Die vorliegende, gedruckte Arbeit ist mit dem elektronisch \"ubermittelten Textdokument identisch.
		\par
		\vspace{10mm}
		\noindent
		%\@placeofstudy, am \formatdate{\value{@dayofsubmission}}{\value{@monthofsubmission}}{\value{@yearofsubmission}}
		\@placeofstudy, am \DTMdate{\value{@yearofsubmission}-\value{@monthofsubmission}-\value{@dayofsubmission}}
		\par
		\vspace{12mm}
		\noindent
		\@author
	\end{german}
}

% English

\newcommand{\leadingzero}[1]{\ifnum #1<10 0\the#1\else\the#1\fi}

\newcommand{\@declarationpageEn}{%
	\begin{english}
		\chapter{Declaration}
		\noindent
		I hereby declare and confirm that this thesis is entirely the result of my own original work. 
		Where other sources of information have been used, they have been indicated as such and properly 
		acknowledged. I further declare that this or similar work has not been submitted for credit elsewhere.
		This printed copy is identical to the submitted electronic version.
		\par
		\vspace{10mm}
		\noindent
		%\@placeofstudy, \the\year-\leadingzero{\month}-\leadingzero{\day} %http://de.wikibooks.org/wiki/LaTeX-W%F6rterbuch:_today 
		%\@placeofstudy, {\usdate\formatdate{\value{@dayofsubmission}}{\value{@monthofsubmission}}{\value{@yearofsubmission}}}
		\@placeofstudy, \DTMdate{\value{@yearofsubmission}-\value{@monthofsubmission}-\value{@dayofsubmission}}
		\par
		\vspace{12mm}
		\noindent
		\@author
	\end{english}
}

\newcommand{\@declarationpage}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\@declarationpageDe}%
	{\@declarationpageEn}
}


%% Assembly of title pages ----------------------------------------------------

\renewcommand{\@mastertitlepages}{
	\@mastertitle
	\ifthenelse{\equal{\@advisor}{}}%
			{}{\@advisorpage}%
	\@copyrightpage
	\@declarationpage
}
     
\renewcommand{\@diplomatitlepages}{
	\@diplomatitle
	\ifthenelse{\equal{\@advisor}{}}%
			{}{\@advisorpage}%
	\@copyrightpage
	\@declarationpage
}

\renewcommand{\@bachelortitlepages}{
	\@bachelortitle
	\ifthenelse{\equal{\@advisor}{}}%
			{}{\@advisorpage}%
	\@copyrightpage
	\@declarationpage
}

\renewcommand{\@internshiptitlepages}{
	\@internshiptitle
	\@companypage
	\@copyrightpage
	\@declarationpage
}

\newcommand{\@warnmultipleauthors}{\PackageWarning{hagenberg-thesis}{Multiple authors are not supported ('\@backslashchar and' is ignored)!}}%

% Add PDF meta data and create title pages
\renewcommand{\maketitle}{	%replace standard LaTeX-command
	\def\and{\@warnmultipleauthors}% suppress \and inside \author{..}
	\renewcommand{\thanks}[1]{}% suppress \thanks{..} inside \author{..}
	\hypersetup{
			pdftitle={\@title},
			pdfauthor={\@author},
			pdfsubject={\@programtype \@programname, \@placeofstudy},
			pdfcreator={LaTeX using class hgbthesis [\hgbDate]},
			pdfproducer={pdflatex},
			pdfkeywords={},
			pageanchor=false	% disable hyperref page anchors in frontmatter pages
	}%
	\@maketitlepages
	\hypersetup{pageanchor=true}	% enable hyperref page anchors in the main document
}

%% Additional Hagenberg packages ----------------------------------------------

\RequirePackage{hgbmath}
\RequirePackage{hgbalgo}
\RequirePackage{hgbheadings}
\RequirePackage{hgbabbrev}
\RequirePackage{hgblistings}
\RequirePackage{hgbbib}

\endinput
