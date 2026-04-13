%% hgbreport.cls
%% LaTeX template for creating lab and term reports as well as other forms of academic documentation
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wolfgang Hochleitner (wolfgang.hochleitner@fh-hagenberg.at)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: ASCII

%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hgbreport}[2026/04/12]%%AUTO

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
  apa.code         = {\ifthenelse{\equal{#1}{true}}{\PassOptionsToPackage{apa}{hgbbib}}{}},
  apa.default:n    = true,
  twoside.code     = {\ifthenelse{\equal{#1}{true}}%
                       {\PassOptionsToClass{twoside}{report}}%
                       {\PassOptionsToClass{oneside}{report}}},
  twoside.default:n = true,
  oneside.code     = {\PassOptionsToClass{oneside}{report}%
                      \@WarnDeprecatedOption{oneside}{twoside=false}},
  titlepage.code   = {\ifthenelse{\equal{#1}{false}}%
                       {\PassOptionsToClass{notitlepage}{report}}{}},
  titlepage.default:n = true,
  notitlepage.code = {\PassOptionsToClass{notitlepage}{report}%
                      \@WarnDeprecatedOption{notitlepage}{titlepage=false}},
  % hgb@SmartQuotesOn / hgb@UpdateCheck are declared in hgbvars.sty and read by hgb.sty later:
  smartquotes.code    = \setboolean{hgb@SmartQuotesOn}{#1},
  smartquotes.default:n = true,
  updatecheck.code    = \setboolean{hgb@UpdateCheck}{#1},
  updatecheck.default:n = true,
  noupdatecheck.code  = {\setboolean{hgb@UpdateCheck}{false}%
                         \@WarnDeprecatedOption{noupdatecheck}{updatecheck=false}},
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