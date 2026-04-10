%% hgbreport.cls
%% LaTeX template for creating lab and term reports as well as other forms of academic documentation
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wolfgang Hochleitner (wolfgang.hochleitner@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbreport}[2025/11/10]%%AUTO

\typeout{****************** hgbreport.cls (options=\@nameuse{opt@hgbreport.cls}) ***********************}

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbreport: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbreport: *** LaTeX NOT running in PDF mode ***}}
\fi

\RequirePackage{hgbvars}	% declares shared variables, booleans, and class option helpers

%% Handling class options -----------------------------------------------------

\@RegisterClassOption{language}{english}
\@RegisterClassOption{language}{german}

% We are using the \DeclareKeys / \ProcessKeyOptions system (LaTeX2e kernel, 2022+).
% See http://mirrors.ctan.org/macros/latex/base/source2e.pdf (p. 956),
% https://tex.stackexchange.com/questions/417704/key-value-syntax-in-package-options
\DeclareKeys[hgbreport]{
  % Legacy language options (deprecated, but still accepted):
  english.code     = {\renewcommand{\hgb@MainLanguage}{english}%
                      \@WarnDeprecatedOption{english}{language=english}},
  german.code      = {\renewcommand{\hgb@MainLanguage}{german}%
                      \@WarnDeprecatedOption{german}{language=german}},
  ngerman.code     = {\renewcommand{\hgb@MainLanguage}{german}%
                      \@WarnDeprecatedOption{ngerman}{language=german}},
  % New key-value options:
  language.code    = {\@ValidateClassOption{language}{#1}%
                      \renewcommand{\hgb@MainLanguage}{#1}},
  apa.code         = \PassOptionsToPackage{\CurrentOption}{hgbbib},
  apa.default:n    = true,
  oneside.code     = \PassOptionsToClass{oneside}{report},
  twoside.code     = \PassOptionsToClass{twoside}{report},
  notitlepage.code = \PassOptionsToClass{notitlepage}{report},
  % hgb@SmartQuotesOn / hgb@NoUpdateCheck are declared in hgbvars.sty and read by hgb.sty later:
  smartquotes.code    = \setboolean{hgb@SmartQuotesOn}{true},
  smartquotes.default:n = true,
  noUpdateCheck.code  = \setboolean{hgb@NoUpdateCheck}{true},
  noUpdateCheck.default:n = true,
}
\DeclareUnknownKeyHandler[hgbreport]{
  \PassOptionsToPackage{\CurrentOption}{hgb}
}
\ProcessKeyOptions[hgbreport]

%% Paper options and style file -----------------------------------------------

\LoadClass[a4paper,11pt]{report}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
\RequirePackage{hgb}
\renewcommand{\hgb@TitlePageFont}{\sffamily}

%% Do before running \maketitle:
\AddToHook{cmd/maketitle/before}{%
	\hgb@SetDocumentMetadata%
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