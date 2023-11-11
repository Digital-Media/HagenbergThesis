%% hgbthesis.cls
%% LaTeX template for creating diploma theses, masters's theses, bachelor's theses and other term papers.
%% This file is part of the Hagenberg Thesis package for creating bachelors's and masters's theses
%% Author: Wilhelm Burger (wilbur@ieee.org)
%% GitHub: https://github.com/Digital-Media/HagenbergThesis
%% File encoding: UTF-8

% Preferences for the naming macros (commands/variables):
% * internal, undocumented macros (used in release *.cls and *.sty files):   \@macroname or \@MacroName
% * documented internal macros for customizing (eg in theme *.sty files):    \hgb@MacroName or \hgb@macroname
% * documented public macros (available in user documents):                  \hgbMacroName (preferred), \MacroName or \macroname


%% Package Information --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[2022/06/01]  % recent LaTeX kernel version, must support \DeclareKeys (ltkeys)
\ProvidesClass{hgbthesis}[2023/10/26]%%AUTO

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbthesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbthesis: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Add thesis-relevant dictionary terms ---------------------------------------

\RequirePackage{hgbdict}

\hgbDictionarySet{bachelor-thesis}{english}{Bachelor Thesis}
\hgbDictionarySet{bachelor-thesis}{german}{Bachelorarbeit}

\hgbDictionarySet{master-thesis}{english}{Master's Thesis}
\hgbDictionarySet{master-thesis}{german}{Masterarbeit}

\hgbDictionarySet{diploma-thesis}{english}{Diploma Thesis}
\hgbDictionarySet{diploma-thesis}{german}{Diplomarbeit}

\hgbDictionarySet{internship-report}{english}{Internship Report}
\hgbDictionarySet{internship-report}{german}{Praktikumsbericht}

\hgbDictionarySet{proposal}{english}{Proposal}
\hgbDictionarySet{proposal}{german}{Exposè}

\hgbDictionarySet{declaration}{english}{Declaration}
\hgbDictionarySet{declaration}{german}{Erklärung}

\hgbDictionarySet{advisor}{english}{Advisor}
\hgbDictionarySet{advisor}{german}{Betreuer*in}

%% Commands for Title Pages (used in class options) ---------------------------

% Type of thesis (theme name):
\newcommand{\hgb@ThesisType}{master}	

%% Setup for proposals ------------------------------------------------------

\newboolean{hgb@IsProposal} % indicates if this document is a proposal (true) or final thesis (false).
\setboolean{hgb@IsProposal}{false}

%% Handling class options ------------------------------------------------------

%\DeclareOption{bachelor}{\AtEndOfPackage{\RequirePackage{hgbtheme-bachelor}}}
%\DeclareOption{master}{\AtEndOfPackage{\RequirePackage{hgbtheme-master}}}
%\DeclareOption{diploma}{\AtEndOfPackage{\RequirePackage{hgbtheme-diploma}}}
%\DeclareOption{phd}{\AtEndOfPackage{\RequirePackage{hgbtheme-phd}}}
%\DeclareOption{internship}{\AtEndOfPackage{\RequirePackage{hgbtheme-internship}}}
%\DeclareOption{custom}{\AtEndOfPackage{\RequirePackage{hgbtheme-custom}}}
%
%\DeclareOption{apa}{\PassOptionsToPackage{\CurrentOption}{hgbbib}}
%\DeclareOption{proposal}{\setboolean{hgb@IsProposal}{true}}	% use with 'bachelor', 'master', 'diploma', 'phd' options
%
%% pass all other options to hgb.sty
%\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{hgb}}
%\ProcessOptions*

%% New version allowing key/value options (provided by recent LaTeX2e kernel):

\newcommand{\@WarnDeprecatedTypeOption}[1]{% #1 = obsolete option
	\ClassWarning{hgbthesis}{Class option '#1' is deprecated, use 'type=#1' instead!}}%

\newcommand{\@ThemePackage}{}
\newcommand{\@ThemeFile}{}

\newcommand{\@SelectTheme}[1]{%
  \ifthenelse{\equal{\@ThemePackage}{}}%      %% \isempty{\@ThemePackage} not working?
    { 
      \renewcommand{\@ThemePackage}{hgbtheme-#1}%
      \renewcommand{\@ThemeFile}{\@ThemePackage.sty}%
      %\typeout{ThemeFile = \@ThemeFile}
      %\typeout{hgbthesis.cls: \string\@SelectTheme}
      \IfFileExists{\@ThemeFile}%
        {\AtEndOfPackage{\RequirePackage{\@ThemePackage}}}%
        {\ClassError{hgbthesis}{Could not find theme file '\@ThemeFile' for option 'type=#1'}} 
    }%
    {
      \ClassWarning{hgbthesis}{Multiple declaration of thesis type, ignoring option '#1'}
    }
}

% Sets the main language for this document:
\newcommand{\hgb@MainLanguage}{german}
\newcommand{\@setMainlLanguage}[1]{%
  \ifthenelse{\equal{#1}{german} \or \equal{#1}{english}}%
    {\renewcommand{\hgb@MainLanguage}{#1}}%
    {\ClassError{hgbthesis}{Unknown title language: '\string#1' (use 'german' or 'english')}{}}
}

% Sets the language to be used for the front pages, which may be different from
% the document's main language (specified by a class option):
\newcommand{\hgb@TitleLanguage}{\hgb@MainLanguage}
\newcommand{\@setTitleLanguage}[1]{%
  \ifthenelse{\equal{#1}{german} \or \equal{#1}{english}}%
    {\renewcommand{\hgb@TitleLanguage}{#1}}%
    {\ClassError{hgbthesis}{Unknown title language: '\string#1' (use 'german' or 'english')}{}}
}

% See source2e documentation (p. 956)
% See https://tex.stackexchange.com/questions/417704/key-value-syntax-in-package-options
\DeclareKeys{
  % legacy options (deprecated):
  bachelor.code 	= {\@SelectTheme{bachelor}\@WarnDeprecatedTypeOption{\CurrentOption}},
  master.code 		= {\@SelectTheme{master}\@WarnDeprecatedTypeOption{\CurrentOption}},
  diploma.code 		= {\@SelectTheme{diploma}\@WarnDeprecatedTypeOption{\CurrentOption}},
	internship.code = {\@SelectTheme{internship}\@WarnDeprecatedTypeOption{\CurrentOption}},
  %
  % catch old-style language options: for some reason they are still passed to hgb.sty!
  german.code     = {\@setMainlLanguage{german}}, % currently no warnings!
  ngerman.code    = {\@setMainlLanguage{german}}, % currently no warnings!
  english.code    = {\@setMainlLanguage{english}},
  %
	%% new options
	type.code 			= \@SelectTheme{#1},
  %
  language.code      = \@setMainlLanguage{#1},
	titlelanguage.code = \@setTitleLanguage{#1},
  %
  proposal.code 	= \setboolean{hgb@IsProposal}{true},
  %
  apa.code 				= \PassOptionsToPackage{\CurrentOption}{hgbbib}
}

\DeclareUnknownKeyHandler[hgbthesis]{
    %\typeout{hgbthesis.cls: unknown option \CurrentOption}%
    \PassOptionsToPackage{\CurrentOption}{hgb}
}

\ProcessKeyOptions[hgbthesis]

%% Paper Options and Style File -----------------------------------------------

\LoadClass[a4paper,11pt,oneside]{book}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
\RequirePackage{hgb}	% load style file hgb.sty with options registered above
\newcommand{\hgb@TitlePageFont}{\sffamily}

%% Setup for Pages in the Front Matter ----------------------------------------

% General Thesis Parameters

\newcommand{\hgb@Author}{\theauthor}%	\theauthor is defined by titling package (instead of \@author)

\newcommand{\hgb@Title}{Document title not specified!}	
% initialized by \renewcommand{\maketitle} below

\newcommand{\hgb@SubTitle}{}
\newcommand{\subtitle}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\hgb@SubTitle}{#1}}
}

% Full title (title + subtitle) where a combination of both is required:
\newcommand{\hgb@FullTitle}{}
\ifthenelse{\isempty{\hgb@SubTitle}}{\renewcommand{\hgb@FullTitle}{\hgb@Title}}{\renewcommand{\hgb@FullTitle}{\hgb@Title: \hgb@SubTitle}}

\newcommand{\hgb@Institution}{\@MissingArg{Name of institution not specified!}}
\newcommand{\institution}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\hgb@Institution}{#1}}
}

\newcommand{\hgb@ProgramType}{\@MissingArg{Type of degree program not specified!}}
\newcommand{\programtype}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\hgb@ProgramType}{#1}}
}

\newcommand{\hgb@ProgramName}{\@MissingArg{Name of degree program not specified!}}
\newcommand{\programname}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\hgb@ProgramName}{#1}}
}

\newcommand{\hgb@PlaceOfStudy}{\@MissingArg{Place of study not specified!}}
\newcommand{\placeofstudy}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\hgb@PlaceOfStudy}{#1}}
}

% Advisor -------------------------------------------------------------------

\newcommand{\hgb@Advisor}{}					% obsolete?
\newcommand{\hgb@AdvisorRole}{}			% obsolete?

\newcounter{@advisorctr}
\setcounter{@advisorctr}{0}

% Returns the number of advisers specified 
\newcommand{\hgb@AdvisorCount}{
	\the@advisorctr
}

% Returns the 'role' of adviser with the given number (#1 = 1,...,\hgb@AdvisorCount)
\newcommand{\hgb@getAdvisorRole}[1]{
	\csname advisorrole-#1\endcsname
}

% Returns the 'name' of adviser with the given number (#1 = 1,...,\hgb@AdvisorCount)
\newcommand{\hgb@getAdvisorName}[1]{
	\csname advisorname-#1\endcsname
}

% User command to specify the role(optional) and name of one advisor: \advisor[<role>]{<name>}
\newcommand{\advisor}[2][\hgbDictionaryGet{advisor}{\hgb@TitleLanguage}]{% % e.g., \advisor[Supervisor]{Prof.~Marie Curie, PhD}
	\stepcounter{@advisorctr}%
	\expandafter\def\csname advisorrole-\the@advisorctr\endcsname{#1}
	\expandafter\def\csname advisorname-\the@advisorctr\endcsname{#2}
  \renewcommand{\hgb@Advisor}{#2}     % keeps the last advisor (obsolete?)
  \renewcommand{\hgb@AdvisorRole}{#1} % keeps the last advisor (obsolete?)
}

% ---------------------------------------------------------------------------

% Specify the institution's logo in 'images/' ('logo.pdf' by default)
\newcommand{\hgb@LogoFile}{logo.pdf}
\newcommand{\logofile}[1]{%
	\renewcommand{\hgb@LogoFile}{#1}%
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

% Submission Date

\DTMsavenow{hgb@DateOfSubmission}  % default submission date is today

\newcommand{\dateofsubmission}[3]{%	usage: \dateofsubmission{yyyy}{mm}{dd}
  \DTMsavenoparsedate{hgb@DateOfSubmission}{#1}{#2}{#3}{-1}
}

\newcommand{\hgb@SubmissionYear}{\DTMfetchyear{hgb@DateOfSubmission}}
\newcommand{\hgb@SubmissionMonth}{\DTMfetchmonth{hgb@DateOfSubmission}}
\newcommand{\hgb@SubmissionDay}{\DTMfetchday{hgb@DateOfSubmission}}

\newcommand{\hgb@GetMonthName}[2]{% #1=language #2=month, 
  \csname DTM#1monthname\endcsname{#2}% brittle?
}

\newcommand{\hgb@SubmissionMonthNameDE}{\DTMgermanmonthname{\hgb@SubmissionMonth}}
\newcommand{\hgb@SubmissionMonthNameEN}{\DTMenglishmonthname{\hgb@SubmissionMonth}}

% Copyright/License Settings --------------------------------------------------

\newcommand{\hgb@license}{cc}

\newcommand{\license}[1]{%
	\renewcommand{\hgb@license}{#1}
}

\newcommand{\cclicense}{% for backward compatibility, use \license{cc} instead
  \ClassWarning{hgbthesis}{\string\cclicense\space command is deprecated, use \string\license{cc} instead!}%
  \license{cc}%
 }

\newcommand{\strictlicense}{% for backward compatibility, use \license{strict} instead
  \ClassWarning{hgbthesis}{\string\strictlicense\space command is deprecated, use \string\license{strict} instead!}%
  \license{strict}%
 }

% Generate the front pages (to be defined by theme .sty files)
\newcommand{\hgb@MakeFrontPages}{\ClassError{hgbthesis}{Command \string\hgb@MakeFrontPages\space is not defined!}}

%% -----------------------

\newcommand{\@warnmultipleauthors}%
  {\ClassWarning{hgbthesis}{Multiple authors are not supported ('\string\and' is ignored)!}}%

% Create title pages and add PDF meta data:

\newcommand{\hgb@InitTheme}{} % called by \maketitle, to be redefined by the styles, 

\RequirePackage{titling}
\renewcommand{\maketitle}{%                     redefine standard LaTeX-command
	\renewcommand{\hgb@Title}{\thetitle}%					defined by 'titling' package
	\renewcommand{\and}{\@warnmultipleauthors}%   suppress \and inside \author{..}
	\renewcommand{\thanks}[1]{\relax}%            suppress \thanks{..} inside \author{..}
	\hypersetup{
			pdftitle={\hgb@FullTitle},%			TODO: add optional subtitle!
      pdfauthor={\hgb@Author},%
			pdfsubject={\hgb@ProgramType~\hgb@ProgramName,~\hgb@PlaceOfStudy},
			pdfcreator={LaTeX using class hgbthesis [\hgbDate]},
			pdfproducer={pdflatex},
			pdfkeywords={},
			pageanchor=false	% disable hyperref page anchors in front pages
	}%
  \hgb@InitTheme%       % to finalize all required title page fields from input data
	\hgb@MakeFrontPages   % generate front pages
	\hypersetup{pageanchor=true}	% enable hyperref page anchors in the main document
}

%% Set various terms for title pages:

\newcommand{\hgb@ThesisName}{UNDEFINED}

\AtBeginDocument{
  \ifthenelse{\boolean{hgb@IsProposal}}{\@proposalsetup}{}%
}

%% Additional Hagenberg packages ----------------------------------------------

\RequirePackage{hgbmath}
\RequirePackage{hgbalgo}
\RequirePackage{hgbheadings}
\RequirePackage{hgbabbrev}
\RequirePackage{hgblistings}
\RequirePackage{hgbbib}


\endinput
