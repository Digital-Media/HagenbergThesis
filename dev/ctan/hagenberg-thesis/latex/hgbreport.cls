%% hgbreport.cls
%% LaTeX template for creating lab and term reports as well as other forms of academic documentation
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wolfgang Hochleitner (wolfgang.hochleitner@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbreport}[2025/02/24]%%AUTO

\typeout{****************** hgbreport.cls (options=\@nameuse{opt@hgbreport.cls}) ***********************}

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbreport: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbreport: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Handling class options --------------------------------------------------------------

\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{report}}	%default
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{notitlepage}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
% pass all other options to hgb.sty
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
\ProcessOptions*


%% Paper options and style file -----------------------------------------------

\LoadClass[a4paper,11pt]{report}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe

\RequirePackage{hgb}	% load style file hgb.sty with options registered above


%% Set title font to SF and inject PDF meta-data
\RequirePackage{titling}
\renewcommand{\maketitlehooka}{%
  \sffamily%
  \hypersetup{
		pdftitle={\thetitle},   % \thetitle is defined by titling package (instead of \@title)
		pdfauthor={\theauthor}, % \theauthor is defined by titling package (instead of \@author)
		pdfsubject={},
		pdfcreator={LaTeX using class hgbreport [\hgbDate]},
		pdfproducer={pdflatex},
		pdfkeywords={}
	}%
}

%% Set abstract name to bold
\RequirePackage{abstract}%
\renewcommand{\abstractnamefont}{\sffamily\small\bfseries}


%% Additional Hagenberg packages ----------------------------------------------

\RequirePackage{hgbmath}
\RequirePackage{hgbalgo}
\RequirePackage{hgbheadings}
\RequirePackage{hgbabbrev}
\RequirePackage{hgblistings}
\RequirePackage{hgbbib}

\endinput