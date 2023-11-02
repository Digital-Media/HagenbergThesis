%% hgbthesis.cls
%% LaTeX template for creating diploma theses, masters's theses, bachelor's theses and other term papers.
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wilhelm Burger (wilbur@ieee.org)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbthesis}[2023/10/26]%%AUTO

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbthesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbthesis: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Commands for Title Pages (used in class options) ---------------------------

\newcommand{\hgb@MainLanguage}{german}	% also referenced in hgb.sty

\newboolean{@hgbisproposal}
\setboolean{@hgbisproposal}{false}

\newcommand{\@titlepagefont}{\sffamily}

%% Standard title designations -------------------------------------------------

\newcommand{\hgbThesisNameDE}{UNDEFINED}
\newcommand{\hgbThesisNameEN}{UNDEFINED}

\newcommand{\hgbBachelorThesisNameDE}{Bachelorarbeit}
\newcommand{\hgbBachelorThesisNameEN}{Bachelor Thesis}

\newcommand{\hgbMasterThesisNameDE}{Masterarbeit}
\newcommand{\hgbMasterThesisNameEN}{Master Thesis}

\newcommand{\hgbDiplomaThesisNameDE}{Diplomarbeit}
\newcommand{\hgbDiplomaThesisNameEN}{Diploma Thesis}

\newcommand{\hgbProposalNameDE}{Expos{\`e}}
\newcommand{\hgbProposalNameEN}{Proposal}


%% Handling class options ------------------------------------------------------

\DeclareOption{bachelor}{
  \renewcommand{\hgbThesisNameDE}{Bachelorarbeit}
  \renewcommand{\hgbThesisNameEN}{Bachelor Thesis}
  \AtEndOfPackage{\RequirePackage{hgbtheme-thesis}}
}

\DeclareOption{master}{
  \renewcommand{\hgbThesisNameDE}{Masterarbeit}
  \renewcommand{\hgbThesisNameEN}{Master Thesis}
  \AtEndOfPackage{\RequirePackage{hgbtheme-thesis}}
}

\DeclareOption{diploma}{
  \renewcommand{\hgbThesisNameDE}{Diplomarbeit}
  \renewcommand{\hgbThesisNameEN}{Diploma Thesis}
  \AtEndOfPackage{\RequirePackage{hgbtheme-thesis}}
}

\DeclareOption{internship}{
  \AtEndOfPackage{\RequirePackage{hgbtheme-internship}}
 }

\DeclareOption{custom}{
  \AtEndOfPackage{\RequirePackage{hgbtheme-custom}}
}

\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
\DeclareOption{proposal}{\setboolean{@hgbisproposal}{true}}	% use with 'bachelor' or 'master' option

% pass all other options to hgb.sty
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
\ProcessOptions*


%% Paper Options and Style File -----------------------------------------------

\LoadClass[a4paper,11pt,oneside]{book}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
 
\RequirePackage{hgb}	% load style file hgb.sty with options registered above


%% Setup for Pages in the Front Matter ----------------------------------------

% General Thesis Parameters

\newcommand{\@institution}{\@MissingArg{Name of institution not specified!}}
\newcommand{\institution}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\@institution}{#1}}
}

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

\newcommand{\@logofile}[0]{}
\newcommand{\logofile}[1]{%
	\renewcommand{\@logofile}{#1}
}

\newcommand{\makelogo}[0]{%
\ifthenelse{\equal{\@logofile}{}}%	check if \@logofile is empty (unspecified)
	{\vspace*{30mm}}%			skip logo
	{\includegraphics[height=30mm]{\@logofile}}%	insert logo
}

% Special sectioning setup for thesis proposals (called in \@bachelortitlepages):

\newcommand{\@proposalsetup}[0]{%
	% remove "Kapitel 1" (titlesec):
	\titleformat{\chapter}[display]{\sffamily}{}{0pt}{\Huge}
	% define an empty entry format for the TOC chapter numbering (tocbasic)
	\newcommand\noentrynumber[1]{}
	% set empty number and remove indentation for chapter numbering in TOC (tocbasic)
	\DeclareTOCStyleEntry[entrynumberformat=\noentrynumber,numwidth=0pt]{tocline}{chapter}
	 % remove chapter number from sections and figures (basic LaTeX):
	\counterwithout{section}{chapter}
	\counterwithout{figure}{chapter}
	\counterwithout{table}{chapter}
	\counterwithout{equation}{chapter}
	\counterwithout{program}{chapter}
	\counterwithout{algorithm}{chapter}
	% remove chapter number from header (fancyhdr):
	\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
}

\AtBeginDocument{
  \ifthenelse{\boolean{@hgbisproposal}}{\@proposalsetup}{}%
}

% Submission Date

\DTMsavenow{@dateofsubmission}  % default submission date is today

\newcommand{\dateofsubmission}[3]{%	usage: \dateofsubmission{yyyy}{mm}{dd}
  \DTMsavenoparsedate{@dateofsubmission}{#1}{#2}{#3}{-1}
}

%% ----------------------------------------------------------------------------

%% dirty trick: adds blank space after each letter (https://stackoverflow.com/a/3951837)
% REPLACED by \so command from 'soul' package!
%\newcommand{\@addspaces}[1]{%  
  %\@tfor\letter:=#1\do{%
    %\letter\thinspace%	%\space
  %}\negthinspace%
%}

% Default Copyright and License Page --------------------------------------------------

\newcommand{\@license}{\@MissingArg{License information is missing!}}
\newcommand{\license}[1]{%
	\renewcommand{\@license}{#1}
}

\newcommand{\strictlicense}{%
\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
	{\license{Alle Rechte vorbehalten}}%
	{\license{All Rights Reserved}}
}

% ----------------

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

% ----------------

\newcommand{\@copyrightpage}{%
\newpage
%\setcounter{page}{2}
\thispagestyle{plain}
\rule{0mm}{1mm}
\vspace*{75mm}
\begin{center}
\textsf{\copyright\ Copyright\ \DTMfetchyear{@dateofsubmission} \@author}
\end{center}
\vspace{8mm}
\@makelicense
}

%% Default Advisor Page ----------------------------------------

\newcommand{\@advisorheaderfinal}{
	\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
			{Betreuung}%
			{Advisor}%
}

\newcommand{\@advisorheaderproposal}{
	\ifthenelse{\equal{\hgb@MainLanguage}{german}}%
			{Betreuung (Vorschlag)}%
			{Proposed Advisor}%
}

\newcommand{\@advisorpage}{%
	\ifthenelse{\equal{\@advisor}{}}%	does nothing if advisor is undefined 
		{}{%
		\newpage
		\setcounter{page}{2}
		\thispagestyle{plain}
		\rule{0mm}{1mm}
		\vspace{90mm}
		\begin{center}
			\ifthenelse{\boolean{@hgbisproposal}}%
				{\@advisorheaderproposal:}%
				{\@advisorheaderfinal:}%
			\\
			\vspace{3mm} 
			{\Large\sf \@advisor\\ \mbox{}}
		\end{center}
		}
}

%% Default Declaration Pages in German and English ------------------------------------

\newcommand{\@declarationpageDe}{% Standardfassung der FH-OOe ab 04.04.2012
	\begin{german}
		\chapter{Erkl\"arung}
		\noindent
		Ich erkl\"are eidesstattlich, dass ich die vorliegende Arbeit selbstst\"andig und ohne fremde Hilfe verfasst, 
		andere als die angegebenen Quellen nicht benutzt und die den benutzten Quellen entnommenen Stellen als 
		solche gekennzeichnet habe. Die Arbeit wurde bisher in gleicher oder \"ahnlicher Form keiner anderen 
		Pr\"ufungsbeh\"orde vorgelegt.
		Die vorliegende, gedruckte Arbeit ist mit dem elektronisch \"ubermittelten Textdokument identisch.
		\par
		\vspace{10mm}
		\noindent
		\@placeofstudy, am \DTMusedate{@dateofsubmission}
		\par
		\vspace{12mm}
		\noindent
		\@author
	\end{german}
}

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
		\@placeofstudy, \DTMusedate{@dateofsubmission}
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

%% Default arrangement of thesis front pages (may be redefined by theme styles) -----------------------------------

\newcommand{\hgb@makefrontpages}{
	\@maketitlepage%  
	\ifthenelse{\boolean{@hgbisproposal}}
    {% proposal
			\@advisorpage%
			%no copyright/declaration page for proposals
		}{% final document
			\@advisorpage%
			\@copyrightpage%
			\@declarationpage%
		}%
}

\newcommand{\@warnmultipleauthors}%
{\PackageWarning{hagenberg-thesis}{Multiple authors are not supported ('\@backslashchar and' is ignored)!}}%

% Add PDF meta data and create title pages

\renewcommand{\maketitle}{	%replace standard LaTeX-command
	\def\and{\@warnmultipleauthors}% suppress \and inside \author{..}
	\renewcommand{\thanks}[1]{}% suppress \thanks{..} inside \author{..}
	\hypersetup{
			pdftitle={\@title},
			pdfauthor={\@author},
			pdfsubject={\@programtype~\@programname,~\@placeofstudy},
			pdfcreator={LaTeX using class hgbthesis [\hgbDate]},
			pdfproducer={pdflatex},
			pdfkeywords={},
			pageanchor=false	% disable hyperref page anchors in frontmatter pages
	}%
	\hgb@makefrontpages
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
