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
\ProvidesClass{hgbthesis}[2025/05/26]%%AUTO

\RequirePackage{xifthen}

\RequirePackage{ifpdf}	% for checking PDF mode 
\ifpdf{}% \typeout{hgbthesis: *** LaTeX in PDF mode ***}
\else{\errmessage{hgbthesis: *** LaTeX NOT running in PDF mode ***}}
\fi

%% Commands for Title Pages (used in class options) ---------------------------

\newcommand{\hgb@ThesisType}{master}%									type of thesis (theme name)						

\newcommand{\hgb@MainLanguage}{german}%								the main language for this document:
\newcommand{\hgb@TitleLanguage}{}%										the language to be used for the front pages

\newboolean{hgb@IsProposal} % indicates if this document is a proposal (true) or final thesis (false).
\setboolean{hgb@IsProposal}{false}
\newcommand{\hgb@ProposalName}{UNDEFINED}

\newcommand{\hgb@@pagelayout}{oneside}% default to 'oneside' (used locally only in this file!)

%% Utilities for handling class options -------------------------------------

% Issue warning when using deprecated options:
\newcommand{\@WarnDeprecatedOption}[2]{% #1=obsolete option, #2=replacement option
	\ClassWarning{hgbthesis}{option '#1' is deprecated, use '#2' instead!}}%
	
% Register permissible key/value option, e.g.: \@RegisterClassOption{type}{master}
\newcommand{\@RegisterClassOption}[2]{%  #1=optionKey, #2=optionValue
  \expandafter\def\csname hgb@keyvalueoption-#1-#2\endcsname{\relax}%
}

% Check if key/value option is permissible, e.g.: \@ValidateClassOption{type}{master}
\newcommand{\@ValidateClassOption}[2]{%  #1=optionKey, #2=optionValue
\ifcsname hgb@keyvalueoption-#1-#2\endcsname%
  {}%
  \else \ClassError{hgbthesis}{illegal key/value option: #1=#2}\relax%
  \fi%
}

%% Specifiying/loading thesis theme styles ---------------------------------------------------

\newcommand{\@ThemeID}{default}%			use theme 'hgbtheme-default' if no theme is specified
\newcommand{\@ThemePrefix}{hgbtheme}%	fixed, all theme files are named 'hgbtheme-<themeID>.sty'

% The .sty file for the specified theme (#2) is loaded if it exists, otherwise throws an error:
\newcommand{\hgb@UseTheme}[2][]{%		#1=options passed to theme style file, #2=themeID
	\def\@ThemeName{\@ThemePrefix-#2}
	\def\@ThemeFile{\@ThemeName.sty}
	%\typeout{ThemeFile = \@ThemeFile}
	\IfFileExists{\@ThemeFile}%		true if LaTeX can find this file (need not be local!)
		{\RequirePackage[#1]{\@ThemeName}}%  must load immediately, was {\AtEndOfPackage{\usepackage[#1]{\@ThemeName}}}%
		{\ClassError{hgbthesis}{style file '\@ThemeFile' for theme '#2' could not be found}\relax}%
}

% Class option handling --------------------------------------------------

% Specifiy permissible key/value options:
\@RegisterClassOption{type}{bachelor}
\@RegisterClassOption{type}{master}
\@RegisterClassOption{type}{diploma}
\@RegisterClassOption{type}{phd}
\@RegisterClassOption{type}{internship}

\@RegisterClassOption{language}{english}
\@RegisterClassOption{language}{german}

\@RegisterClassOption{titlelanguage}{english}
\@RegisterClassOption{titlelanguage}{german}

% We are using the 
% See http://mirrors.ctan.org/macros/latex/base/source2e.pdf (p. 956),
% https://tex.stackexchange.com/questions/417704/key-value-syntax-in-package-options
\DeclareKeys{
	% legacy options (deprecated):
	bachelor.code 	= {\renewcommand{\hgb@ThesisType}{bachelor}\@WarnDeprecatedOption{bachelor}{type=bachelor}},
	master.code 		= {\renewcommand{\hgb@ThesisType}{master}\@WarnDeprecatedOption{master}{type=master}},
	diploma.code 		= {\renewcommand{\hgb@ThesisType}{diploma}\@WarnDeprecatedOption{diploma}{type=diploma}},
	internship.code = {\renewcommand{\hgb@ThesisType}{internship}\@WarnDeprecatedOption{internship}{type=internship}},
	% catch old-style language options (for some reason they are still passed to hgb.sty!)
	german.code     = {\renewcommand{\hgb@MainLanguage}{german}\@WarnDeprecatedOption{german}{language=german}},
	ngerman.code    = {\renewcommand{\hgb@MainLanguage}{german}\@WarnDeprecatedOption{ngerman}{language=german}},
	english.code    = {\renewcommand{\hgb@MainLanguage}{english}\@WarnDeprecatedOption{english}{language=english}},
	% new options
	type.code 				= {\@ValidateClassOption{type}{#1}\renewcommand{\hgb@ThesisType}{#1}},
	theme.code 				= \renewcommand{\@ThemeID}{#1},
	language.code			= {\@ValidateClassOption{language}{#1}\renewcommand{\hgb@MainLanguage}{#1}},
	titlelanguage.code = {\@ValidateClassOption{titlelanguage}{#1}\renewcommand{\hgb@TitleLanguage}{#1}},
	proposal.code			= \setboolean{hgb@IsProposal}{#1},
	proposal.default:n	= true,	% https://tex.stackexchange.com/a/682260/175415
	apa.code					= \PassOptionsToPackage{\CurrentOption}{hgbbib},
	apa.default:n			= true,	% TODO: check if default value is properly passed!
	%
	%	This works, but default should be 'oneside' for backward compatibility ('twoside' is default for class 'book')
	%oneside.code			= \PassOptionsToClass{\CurrentOption}{book},
	%twoside.code			= \PassOptionsToClass{\CurrentOption}{book},
	% Instead we define 
	oneside.code			= {\renewcommand{\hgb@@pagelayout}{oneside}},
	twoside.code			= {\renewcommand{\hgb@@pagelayout}{twoside}},
}

\DeclareUnknownKeyHandler[hgbthesis]{
    %\typeout{hgbthesis.cls: unknown option \CurrentOption}%
    \PassOptionsToPackage{\CurrentOption}{hgb}
}

\ProcessKeyOptions[hgbthesis]

%% Paper Options and Style File -----------------------------------------------

%\LoadClass[a4paper,11pt,oneside]{book}
\LoadClass[a4paper,11pt,\hgb@@pagelayout]{book}
\RequirePackage[top=36mm,bottom=40mm,left=32mm,right=32mm]{geometry} %showframe
\RequirePackage{hgb}	% load style file hgb.sty with options registered above
\RequirePackage{titling}
\newcommand{\hgb@TitlePageFont}{\sffamily}

%% Setup for Pages in the Front Matter:

% General Thesis Parameters ----------------------------------------

%	Initialized from standard '\author{}' parameter (by \maketitle hook below)
\newcommand{\hgb@Author}{Author undefined!}

\newcommand{\@warnmultipleauthors}%
	{\ClassWarning{hgbthesis}{Multiple authors are not supported ('\string\and' is ignored)!}}%

\newcommand{\hgb@Title}{Undefined document title!}% derived from \title (initialized in \maketitle hook)

\newcommand{\hgb@SubTitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\hgb@SubTitle}{#1}}

\newcommand{\hgb@FullTitle}{}% = title + subtitle (initialized in \maketitle hook)

\newcommand{\hgb@ThesisName}{Undefined thesis name!}%

\newcommand{\hgb@Institution}{\@MissingArg{Name of institution not specified!}}
\newcommand{\institution}[1]{%
	\ifthenelse{\isempty{#1}}{}{\renewcommand{\hgb@Institution}{#1}}
}

\newcommand{\hgb@ProgramType}{\@MissingArg{Type of degree program not specified!}}
\newcommand{\programtype}[1]{\renewcommand{\hgb@ProgramType}{#1}}

\newcommand{\hgb@ProgramName}{\@MissingArg{Name of degree program not specified!}}
\newcommand{\programname}[1]{\renewcommand{\hgb@ProgramName}{#1}}

\newcommand{\hgb@PlaceOfStudy}{\@MissingArg{Place of study not specified!}}
\newcommand{\placeofstudy}[1]{\renewcommand{\hgb@PlaceOfStudy}{#1}}

% Advisor(s) -------------------------------------------------------------------

\newcounter{@advisorctr}
\setcounter{@advisorctr}{0}

% User command to specify the role(optional) and name of one advisor: \advisor[<role>]{<name>}
% Repeat to specify multiple advisors.
\newcommand{\advisor}[2][\hgbDictionaryGet{advisorheader}{\hgb@TitleLanguage}]{% e.g., \advisor[Supervisor]{Prof.~Marie Curie, PhD}
	\stepcounter{@advisorctr}%
	\expandafter\def\csname advisorrole-\the@advisorctr\endcsname{#1}
	\expandafter\def\csname advisorname-\the@advisorctr\endcsname{#2}
}

% Returns the number of advisors specified 
\newcommand{\hgb@AdvisorCount}{%
	\the@advisorctr
}

% Returns the 'role' of advisor with the given number (#1 = 1,...,\hgb@AdvisorCount)
\newcommand{\hgb@getAdvisorRole}[1]{%
	\csname advisorrole-#1\endcsname
}

% Returns the 'name' of advisor with the given number (#1 = 1,...,\hgb@AdvisorCount)
\newcommand{\hgb@getAdvisorName}[1]{%
	\csname advisorname-#1\endcsname
}

% Legacy cmommand, returns the first advisor's name
\newcommand{\hgb@Advisor}{\hgb@getAdvisorName{1}}

% Submission Date ---------------------------------------------------------------

\DTMsavenow{hgb@SubmissionDate}  % default submission date is today

\newcommand{\dateofsubmission}[3]{%	usage: \dateofsubmission{yyyy}{mm}{dd}
	\DTMsavenoparsedate{hgb@SubmissionDate}{#1}{#2}{#3}{-1}
}

\newcommand{\hgb@SubmissionYear}{\DTMfetchyear{hgb@SubmissionDate}}
\newcommand{\hgb@SubmissionMonth}{\DTMfetchmonth{hgb@SubmissionDate}}
\newcommand{\hgb@SubmissionDay}{\DTMfetchday{hgb@SubmissionDate}}

\newcommand{\hgb@GetMonthName}[2]{% #1=language #2=monthNumber,
	\csname DTM#1monthname\endcsname{#2}% brittle?
}

% Copyright/License Settings --------------------------------------------------

\newcommand{\hgb@License}{cclicense}

\newcommand{\license}[1]{%
	\renewcommand{\hgb@License}{#1}
	\ifthenelse{\equal{#1}{cc}}{\renewcommand{\hgb@License}{cclicense}}{}%
	\ifthenelse{\equal{#1}{strict}}{\renewcommand{\hgb@License}{strictlicense}}{}%
}

\newcommand{\cclicense}{% for backward compatibility, use \license{cc} instead
	\ClassWarning{hgbthesis}{\string\cclicense\space command is deprecated, use \string\license{cc} instead!}%
	\license{cc}%
}

\newcommand{\strictlicense}{% for backward compatibility, use \license{strict} instead
	\ClassWarning{hgbthesis}{\string\strictlicense\space command is deprecated, use \string\license{strict} instead!}%
	\license{strict}%
}

% Legacy commands, keep for internship reports:
\newcommand{\hgb@CompanyName}{\@MissingArg{Company not specified!}}
\newcommand{\companyName}[1]{\renewcommand{\hgb@CompanyName}{#1}}

\newcommand{\hgb@CompanyUrl}{\@MissingArg{Company URL not specified!}}
\newcommand{\companyUrl}[1]{\renewcommand{\hgb@CompanyUrl}{#1}}


%% Logo -------------------------------------------------------------------------

% Specify the institution's logo - DEPRECATED - logo is now handled in theme files only!
\newcommand{\hgb@LogoFile}{@unspecified}	% 
\newcommand{\logofile}[1]{%
	\ClassWarning{hgbthesis}{Command \string\logofile\space is deprecated, logo should be specified in theme file!}%
	\renewcommand{\hgb@LogoFile}{#1}
}

%% Create title pages -------------------------------------

% Generate the front pages (to be redefined by theme .sty files)
\newcommand{\hgb@MakeFrontPages}{%
	\ClassError{hgbthesis}{Command \string\hgb@MakeFrontPages\space is not defined!}\relax%
}

% Redefine LaTeX's \maketitle to add PDF meta data
\renewcommand{\maketitle}{% redefine standard \maketitle command
	\hypersetup{
			pdftitle={\hgb@FullTitle},%
      pdfauthor={\hgb@Author},%
			pdfsubject={\hgb@ProgramType~\hgb@ProgramName,~\hgb@PlaceOfStudy},
			pdfcreator={LaTeX using class hgbthesis [\hgbDate]},
			pdfproducer={pdflatex},
			pdfkeywords={},
			pageanchor=false%					disable hyperref page anchors in front pages
	}%
	\SetLanguage{\hgb@TitleLanguage}
	\hgb@MakeFrontPages%						generate front pages
	\SetLanguage{\hgb@MainLanguage}
	\hypersetup{pageanchor=true}%		enable hyperref page anchors in the main document
}

% Define new hook to be used in theme style files for various initializations: 
% Usage: \AddToHook{hgb@InitThemeHook}{...}
% Invoked before \maketitle (by hook code below).
\NewHook{hgb@InitThemeHook}

% Initialize remaining parameters before running \maketitle:
\AddToHook{cmd/maketitle/before}{%
	\renewcommand{\hgb@Author}{\theauthor}%		defined by 'titling' package
	\renewcommand{\hgb@Title}{\thetitle}%		  defined by 'titling' package
	\ifthenelse{\equal{\hgb@SubTitle}{}}%
		{\renewcommand{\hgb@FullTitle}{\hgb@Title}}%
		{\renewcommand{\hgb@FullTitle}{\hgb@Title: \hgb@SubTitle}}%
	%
	%\ifthenelse{\boolean{hgb@IsProposal}}{\hgb@ProposalSetup}{}% wilbur: moved to \AtBeginDocument
	\UseHook{hgb@InitThemeHook}%	execute collected code for hgb@InitThemeHook (if any)
}

% Special sectioning setup for thesis proposals: ----------------------------
% wilbur: should be simplified and moved elsewhere (TODO)
%
% Provides a special chapter/section configuration for thesis proposals:
% The idea is to use the regular 'hgbthesis' class but to have only a single 
% (unnumbered) chapter with a couple of sections. All float elements and equations
% are numbered without the chapter count:
%
\newcommand{\hgb@ProposalSetup}[0]{%
	% remove "Kapitel X"/"Chapter X" from chapter titles:
	\titleformat{\chapter}[display]{\sffamily}{}{0pt}{\Huge}% from 'titlesec' package loaded by 'hgbheadings'
	% remove chapter number from header:
	\renewcommand{\chaptermark}[1]{\markboth{##1}{}}% wilbur: from 'fancyhdr' package loaded by 'hgbheadings'
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
}

\AtBeginDocument{%
	\ifthenelse{\boolean{hgb@IsProposal}}{\hgb@ProposalSetup}{}%
}

%% Set various terms to be redefined by title page themes

\ifthenelse{\equal{\hgb@TitleLanguage}{}}%	duplicate in 'hgb.sty'!
		{\renewcommand{\hgb@TitleLanguage}{\hgb@MainLanguage}}{}%

\renewcommand{\hgb@ThesisName}{\hgbDictionaryGet{\hgb@ThesisType-docname}{\hgb@TitleLanguage}}%
\renewcommand{\hgb@ProposalName}{\hgbDictionaryGet{proposal-name}{\hgb@TitleLanguage}}%


%% Additional Hagenberg packages ----------------------------------------------

\RequirePackage{hgbmath}
\RequirePackage{hgbalgo}
\RequirePackage{hgbheadings}
\RequirePackage{hgbabbrev}
\RequirePackage{hgblistings}
\RequirePackage{hgbbib}
\RequirePackage{hgbdict}

\hgb@UseTheme{\@ThemeID}%		load theme style file

\endinput
