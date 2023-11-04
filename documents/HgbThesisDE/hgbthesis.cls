%% hgbthesis.cls
%% LaTeX template for creating diploma theses, masters's theses, bachelor's theses and other term papers.
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wilhelm Burger (wilbur@ieee.org)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: UTF-8

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[2022/06/01]  % recent LaTeX kernel version, must support \DeclareKeys (ltkeys)
\ProvidesClass{hgbthesis}[2023/10/26]%%AUTO

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbthesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbthesis: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Commands for Title Pages (used in class options) ---------------------------

% The document's main language, specified by a class option (passed to hgb.sty);
\newcommand{\hgb@MainLanguage}{german}
\newcommand{\hgb@ThesisType}{master}	

%% Standard title designations -------------------------------------------------

\newcommand{\hgbThesisNameDE}{UNDEFINED}
\newcommand{\hgbThesisNameEN}{UNDEFINED}

\newcommand{\hgbProposalNameDE}{Exposè}
\newcommand{\hgbProposalNameEN}{Proposal}

\newboolean{@hgbisproposal} % indicates if this document is a proposal (true) or final thesis (false).
\setboolean{@hgbisproposal}{false}

%% Handling class options ------------------------------------------------------

%\DeclareOption{bachelor}{\AtEndOfPackage{\RequirePackage{hgbtheme-bachelor}}}
%\DeclareOption{master}{\AtEndOfPackage{\RequirePackage{hgbtheme-master}}}
%\DeclareOption{diploma}{\AtEndOfPackage{\RequirePackage{hgbtheme-diploma}}}
%\DeclareOption{phd}{\AtEndOfPackage{\RequirePackage{hgbtheme-phd}}}
%\DeclareOption{internship}{\AtEndOfPackage{\RequirePackage{hgbtheme-internship}}}
%\DeclareOption{custom}{\AtEndOfPackage{\RequirePackage{hgbtheme-custom}}}
%
%\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
%\DeclareOption{proposal}{\setboolean{@hgbisproposal}{true}}	% use with 'bachelor', 'master', 'diploma', 'phd' options
%
%% pass all other options to hgb.sty
%\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
%\ProcessOptions*

%% New version allowing key/value options (provided by recent LaTeX2e kernel):

\newcommand{\@WarnDeprecatedOption}[2]{% #1 = obsolete option, #2 = suggested replacement
	\ClassWarning{hgbthesis}{Class option '\string#1' is deprecated, use '\string#2' instead!}}%

\newcommand{\@ThemePackage}{}
\newcommand{\@ThemeFile}{}

\newcommand{\@SelectThemeFile}[1]{%
	\renewcommand{\@ThemePackage}{hgbtheme-#1}%
	\renewcommand{\@ThemeFile}{\@ThemePackage.sty}%
	%\typeout{ThemeFile = \@ThemeFile}
	\IfFileExists{\@ThemeFile}%
		{\AtEndOfPackage{\RequirePackage{\@ThemePackage}}		 }%
		{\ClassError{hgbthesis}{Could not find theme file '\@ThemeFile' for option 'type=#1'}} 
}

% Set the language to be used for the front pages, which may be different from
% the document's main language (specified by a class option).
\newcommand{\hgb@TitleLanguage}{\hgb@MainLanguage}
\newcommand{\titlelanguage}[1]{%
  \ifthenelse{\equal{#1}{german} \or \equal{#1}{english}}%
    {\renewcommand{\hgb@TitleLanguage}{#1}}%
    {\ClassError{hgbthesis}{Unknown title language: '#1' (use 'german' or 'english')}{}}
}


\DeclareKeys{
  bachelor.code 	= {\@WarnDeprecatedOption{bachelor}{type=bachelor}\AtEndOfPackage{\RequirePackage{hgbtheme-bachelor}}},
  master.code 		= {\@WarnDeprecatedOption{master}{type=master}\AtEndOfPackage{\RequirePackage{hgbtheme-master}}},
  diploma.code 		= {\@WarnDeprecatedOption{diploma}{type=diploma}\AtEndOfPackage{\RequirePackage{hgbtheme-diploma}}},
	internship.code = {\@WarnDeprecatedOption{internship}{type=internship}\AtEndOfPackage{\RequirePackage{hgbtheme-internship}}},
	%% new options
	%
	type.code 			= \@SelectThemeFile{#1},
	titlelanguage.code = \titlelanguage{#1},
  %
  proposal.code 	= \setboolean{@hgbisproposal}{true},
  %
  apa.code 				= \PassOptionsToPackage{\CurrentOption}{hgbbib}
}

\DeclareUnknownKeyHandler[hgbthesis]{
    \PassOptionsToPackage{\CurrentOption}{hgb}
}

\ProcessKeyOptions

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


% Specify the institution's logo in 'images/' ('logo.pdf' by default)
\newcommand{\@logofile}{logo.pdf}
\newcommand{\logofile}[1]{%
	\renewcommand{\@logofile}{#1}
}

% Special sectioning setup for thesis proposals: 
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
  \ClassWarning{hgbthesis}{\string\cclicense\space command is deprecated, use \string\license{cc} instead!}%
  \license{cc}%
 }

\newcommand{\strictlicense}{% for backward compatibility, use \license{strict} instead
  \ClassWarning{hgbthesis}{\string\strictlicense\space command is deprecated, use \string\license{strict} instead!}%
  \license{strict}%
 }

% Command stubs for generating the document's front pages (to be redefined by theme styles):

\providecommand{\hgb@makefrontpages}{\relax}  % TODO: throw errors if undefined!
\providecommand{\@maketitlepage}{\relax}
\providecommand{\@advisorpage}{\relax}
\providecommand{\@copyrightpage}{\relax}
\providecommand{\@declarationpage}{\relax}

%% -----------------------

\newcommand{\@warnmultipleauthors}%
  {\ClassWarning{hgbthesis}{Multiple authors are not supported ('\string\and' is ignored)!}}%

% Create title pages and add PDF meta data:

\RequirePackage{titling}
\renewcommand{\maketitle}{%                     redefine standard LaTeX-command
	\renewcommand{\and}{\@warnmultipleauthors}%   suppress \and inside \author{..}
	\renewcommand{\thanks}[1]{\relax}%            suppress \thanks{..} inside \author{..}
	\hypersetup{
			pdftitle={\thetitle},%      \thetitle is defined by titling package (instead of \@title)
      pdfauthor={\theauthor},%    \theauthor is defined by titling package (instead of \@author)
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
