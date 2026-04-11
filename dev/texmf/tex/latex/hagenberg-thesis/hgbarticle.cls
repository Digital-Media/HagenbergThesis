%% hgbarticle.cls
%% LaTeX class for creating lab and term reports as well as other forms of academic documentation.
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wolfgang Hochleitner (wolfgang.hochleitner@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbarticle}[2026/04/12]%%AUTO

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

%% Handling class options -----------------------------------------------------

\RequirePackage{hgbvars}	% declares shared variables, booleans, and class option helpers

\@RegisterClassOption{language}{english}
\@RegisterClassOption{language}{german}

% We are using the \DeclareKeys / \ProcessKeyOptions system (LaTeX2e kernel, 2022+).
% See http://mirrors.ctan.org/macros/latex/base/source2e.pdf (p. 956),
% https://tex.stackexchange.com/questions/417704/key-value-syntax-in-package-options
\DeclareKeys[hgbarticle]{
  % Legacy language options (deprecated, but still accepted):
  english.code    = {\renewcommand{\hgb@MainLanguage}{english}%
                     \@WarnDeprecatedOption{english}{language=english}},
  german.code     = {\renewcommand{\hgb@MainLanguage}{german}%
                     \@WarnDeprecatedOption{german}{language=german}},
  ngerman.code    = {\renewcommand{\hgb@MainLanguage}{german}%
                     \@WarnDeprecatedOption{ngerman}{language=german}},
  % New key-value options:
  language.code   = {\@ValidateClassOption{language}{#1}%
                     \renewcommand{\hgb@MainLanguage}{#1}},
  apa.code        = {\ifthenelse{\equal{#1}{true}}{\PassOptionsToPackage{apa}{hgbbib}}{}},
  apa.default:n   = true,
  review.code     = \setboolean{reviewmode}{#1},
  review.default:n = true,
  twoside.code    = {\ifthenelse{\equal{#1}{true}}%
                      {\PassOptionsToClass{twoside}{article}}%
                      {\PassOptionsToClass{oneside}{article}}},
  twoside.default:n = true,
  oneside.code    = {\PassOptionsToClass{oneside}{article}%
                     \@WarnDeprecatedOption{oneside}{twoside=false}},
  twocolumn.code  = {\ifthenelse{\equal{#1}{true}}%
                      {\PassOptionsToClass{twocolumn}{article}}%
                      {\PassOptionsToClass{onecolumn}{article}}},
  twocolumn.default:n = true,
  % hgb@SmartQuotesOn / hgb@UpdateCheck are declared in hgbvars.sty and read by hgb.sty later:
  smartquotes.code    = \setboolean{hgb@SmartQuotesOn}{#1},
  smartquotes.default:n = true,
  updatecheck.code    = \setboolean{hgb@UpdateCheck}{#1},
  updatecheck.default:n = true,
  noupdatecheck.code  = {\setboolean{hgb@UpdateCheck}{false}%
                         \@WarnDeprecatedOption{noupdatecheck}{updatecheck=false}},
}
\DeclareUnknownKeyHandler[hgbarticle]{
  \PassOptionsToPackage{\CurrentOption}{hgb}
}
\ProcessKeyOptions[hgbarticle]

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
