%% hgbarticle.cls
%% LaTeX class for creating lab and term reports as well as other forms of academic documentation.
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wolfgang Hochleitner (wolfgang.hochleitner@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbarticle}[2025/09/05]%%AUTO

%% Set up output font encoding and PDF format
\usepackage[T1]{fontenc}	% pdfmanagement requires T1 encoding!
\usepackage{lmodern}			% alternatively install(!) cm-super package
\usepackage{hgbpdfa}			% enable PDF/A output

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbarticle: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbarticle: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Variable definitions -------------------------------------------------------

\newboolean{reviewmode}
\setboolean{reviewmode}{false}

%% Handling class options --------------------------------------------------------------

\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{article}}	% default
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{twocolumn}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
\DeclareOption{review}{\setboolean{reviewmode}{true}}
% pass all other options to hgb.sty
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
\ProcessOptions*

%% Paper options and style file -----------------------------------------------

\LoadClass[a4paper,11pt]{article}

%Adjust margins only in single-column mode
\if@twocolumn%
\else%
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
\fi%

%% Review mode with line numbers ----------------------------------------------

\ifthenelse{\boolean{reviewmode}}%
	{%
		\if@twocolumn%
			% When in two-column mode, use switch to display line numbers right of the second column
			\RequirePackage[mathlines,switch]{lineno}%
		\else%
			\RequirePackage[mathlines]{lineno}%
		\fi%
		\renewcommand{\linenumberfont}{\sffamily\tiny\color{gray}}%
		\linenumbers%
	}%
	{}%

% load style file hgb.sty with options registered above	
\RequirePackage{hgb}

% Set title font to SF and inject PDF meta-data
\AddToHook{cmd/maketitle/before}{%
  \sffamily%
	\hgb@SetDocumentMetadata%
}

% Set abstract name to bold (single column format only)
\if@twocolumn%
\else%
\RequirePackage{abstract}
\renewcommand{\abstractnamefont}{\sffamily\small\bfseries}
\fi%

%% Additional Hagenberg packages ----------------------------------------------

\RequirePackage{hgbmath}
\RequirePackage{hgbalgo}
\RequirePackage{hgbheadings}
\RequirePackage{hgbabbrev}
\RequirePackage{hgblistings}
\RequirePackage{hgbbib}

\endinput
