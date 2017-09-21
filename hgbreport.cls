%% hgbreport.cls
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wolfgang Hochleitner (wolfgang.hochleitner@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: UTF-8

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\newcommand{\hgbreportDate}{2017/10/01} %version string
\ProvidesClass{hgbreport}[\hgbreportDate\space LaTeX template for creating lab and term reports as well as other forms of academic documentation.]

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbreport: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbreport: *** LaTeX NOT running in PDF mode ***}}
\fi


%% Commands for Title Pages (used in class options) ---------------------------

\newcommand{\hgb@MainLanguage}{german}	% also referenced in hgb.sty

\newcommand{\@titlepagefont}{\sffamily}

%% Class options --------------------------------------------------------------

\DeclareOption{notitlepage}{%
	\PassOptionsToClass{\CurrentOption}{report}
}

\DeclareOption{english}{%
	\renewcommand{\hgb@MainLanguage}{english}
}

\DeclareOption{german}{%
	\renewcommand{\hgb@MainLanguage}{german}
}

\DeclareOption*{%
	\ClassWarning{hgbreport}{Unknown document option '\CurrentOption'.}
}

\ProcessOptions


%% Paper Options and Style File -----------------------------------------------

\LoadClass[a4paper,11pt,onecolumn]{report}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
 
\RequirePackage{hgb}	% load associated style file hgb.sty

% Add PDF meta data and create title pages

\AtBeginDocument{%
	\hypersetup{
		pdftitle={\@title},
		pdfauthor={\@author},
		pdfsubject={Report dated \@date},
		pdfcreator={LaTeX using class hgbreport [\hgbreportDate]},
		pdfproducer={pdflatex},
		pdfkeywords={}
	}%
}%


%% Additional Hagenberg packages ----------------------------------------------

\RequirePackage{hgbmath}
\RequirePackage{hgbheadings}
\RequirePackage{hgbabbrev}
\RequirePackage{hgblistings}
\RequirePackage{hgbbib}

\endinput
