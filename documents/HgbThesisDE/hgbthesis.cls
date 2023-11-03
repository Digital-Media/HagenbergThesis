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

% The document's main language, specified by a class option (passed to hgb.sty);
\newcommand{\hgb@MainLanguage}{german}	

% Boolean indication if this document is a proposal (true) or final thesis (false).
\newboolean{@hgbisproposal}
\setboolean{@hgbisproposal}{false}

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

%% -------------

\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
\DeclareOption{proposal}{\setboolean{@hgbisproposal}{true}}	% use with 'bachelor' or 'master' option

% pass all other options to hgb.sty
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
\ProcessOptions*

%% Paper Options and Style File -----------------------------------------------

\LoadClass[a4paper,11pt,oneside]{book}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
\RequirePackage{hgb}	% load style file hgb.sty with options registered above
\newcommand{\@titlepagefont}{\sffamily}


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

% Copyright/License Settings --------------------------------------------------

\newcommand{\@license}{cc}

\newcommand{\license}[1]{%
	\renewcommand{\@license}{#1}
}

\newcommand{\cclicense}{% for backward compatibility, use \license{cc} instead
  \license{cc}%
 }

\newcommand{\strictlicense}{% for backward compatibility, use \license{strict} instead
  \license{strict}%
 }

% Command stubs for generating the document's front pages (to be redefined by theme styles):

\providecommand{\hgb@makefrontpages}{\relax}  % TODO: throw errors if undefined!
\providecommand{\@advisorpage}{\relax}
\providecommand{\@copyrightpage}{\relax}
\providecommand{\@declarationpage}{\relax}

%% -----------------------

\newcommand{\@warnmultipleauthors}%
  {\ClassWarning{hgbthesis}{Multiple authors are not supported ('\@backslashchar and' is ignored)!}}%

% Create title pages and add PDF meta data:

\renewcommand{\maketitle}{%           redefine standard LaTeX-command
	\def\and{\@warnmultipleauthors}%    suppress \and inside \author{..}
	\renewcommand{\thanks}[1]{\relax}%  suppress \thanks{..} inside \author{..}
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
