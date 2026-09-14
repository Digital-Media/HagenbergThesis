# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project DOES NOT adhere to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- 2025/07/26: [#188](https://github.com/Digital-Media/HagenbergThesis/pull/188): Added an English version for the internship report (`HgbInternshipReportEN`) and renamed the existing version to `HgbInternshipReportDE`. Thanks to [@maxi-smidt](https://github.com/maxi-smidt).
- 2026/09/12: [#207](https://github.com/Digital-Media/HagenbergThesis/issues/207): Added a GitHub Actions workflow that builds and checks all documents, the manual and the CTAN bundle with the makefiles for every pull request, and publishes the results to the branch `build` after merging ([#210](https://github.com/Digital-Media/HagenbergThesis/issues/210): a single commit without history that is replaced on every build, so that the repository no longer grows; generated files are no longer tracked on `main`, the links in the README point to `build`). New make target `check` (checks the log files for errors and problematic warnings and validates PDF/A-2b compliance with veraPDF); the log files of each build are kept in `dev/logs/`.
- 2026/09/12: [#197](https://github.com/Digital-Media/HagenbergThesis/issues/197): New package `hgbaiusage` (loaded by `hgbthesis`) for the documentation of the usage of generative AI tools after the affidavit, using the texts of the FH OÖ templates: environment `aiusage` (short form composed of text modules: `\aiusednone`, `\aiusedfor{<key>}`, `\aiusedforother{...}`) and environment `aiusagedetails` (detailed form with confirmations and a table of activities: `\aiconfirm`, `\aiactivity`, `\aifurtheruse`). The texts of the detailed form were adapted by FH OÖ from KOGNITION/COGNISANCE by Gimpel et al. 2023 (doi:10.17605/OSF.IO/VGXF7); unlike the rest of the package, they are licensed under CC BY-SA 4.0 and kept in the separate file `hgbaiusage-cognisance.sty`, and the form prints the source reference with DOI, adaptation note and license. All thesis, proposal and internship report samples contain the short form (new files `front/ki-dokumentation.tex` and `front/ai-usage.tex`, inline in the internship reports), with the detailed form as a commented alternative.
- 2026/09/14: [#222](https://github.com/Digital-Media/HagenbergThesis/issues/222): Syntax highlighting for code listings: new class option `codestyle` (all three classes) with the styles `color` (default: white background, thin gray line between the line numbers and the code, colors similar to Visual Studio Code with sufficient contrast according to WCAG 2 AA), `mono` (the same layout without colors) and `classic` (the previous gray box without colors). Documents without the option now show colored listings; `codestyle=classic` restores the previous look. The styles are also available as `listings` styles `hgbcolor`, `hgbmono` and `hgbclassic` (e.g., for individual listings), and the colors (`ListingsKeywordColor` etc.) can be redefined. New code environments `BashCode`, `DartCode`, `GlslCode`, `GoCode`, `JsonCode`, `KotlinCode`, `MatlabCode`, `RCode`, `RustCode`, `SqlCode`, `TsCode` and `YamlCode`. Updated the manual (including the language names for `\lstinputlisting`), the tutorials and the option lists in all sample documents.
- 2026/09/14: [#227](https://github.com/Digital-Media/HagenbergThesis/issues/227): New optional argument `compact` for the detailed documentation of AI tools usage (`\begin{aiusagedetails}[compact]`): only the activities with entries are listed (by default, all activities are listed, as in the FH OÖ template). The sample documents contain an example line for every activity of the detailed form (most of them commented out).

### Changed

- 2026/09/14: [#227](https://github.com/Digital-Media/HagenbergThesis/issues/227): `hgbaiusage` issues a warning if both the short form (`aiusage`) and the detailed form (`aiusagedetails`) of the documentation of AI tools usage are used, since only one of them is intended.
- 2026/09/14: [#227](https://github.com/Digital-Media/HagenbergThesis/issues/227): In the detailed documentation of AI tools usage, "Keine"/"None" is printed below the heading of further use if no further use is documented with `\aifurtheruse` (previously, the heading stood alone).
- 2026/09/14: [#227](https://github.com/Digital-Media/HagenbergThesis/issues/227): The detailed documentation of AI tools usage no longer prints the instructions of the template to the authors (to confirm the statements, to indicate the tools used, and the footnote with names of tools), which students might otherwise leave in the finished form; the sample documents give them as comments instead.
- 2026/09/14: [#222](https://github.com/Digital-Media/HagenbergThesis/issues/222): Modernized the language definitions of the existing code environments: keywords of current language versions (C23, C++23, C# 13, Java 21, Python 3 instead of Python 2, Scala 3, Swift 6, PHP 8.4, HTML5), rewritten CSS and JavaScript definitions (JavaScript no longer highlights common identifiers such as `name` or `length`, CSS no longer breaks selectors such as `a:hover`), and built-in types and functions as a second keyword class. In HTML and XML, all element names are highlighted. The plain language names for `\lstinputlisting` (e.g., `language=Java`) select the modernized definitions as well, except for HTML, LaTeX, Scala, SQL and XML (e.g., `language={[hgb]HTML}`).
- 2026/09/13: [#215](https://github.com/Digital-Media/HagenbergThesis/issues/215): Updated the tutorials (`HgbThesisTutorialDE`/`HgbThesisTutorialEN`, kept in sync): current class options (`theme`, `apa`, `updatecheck`), package files and loaded packages, title page elements (`phd`, `\subtitle`, `\advisor` with role), `\license{...}` instead of the deprecated `\cclicense`/`\strictlicense`, key-value options in all code examples, fonts (Latin Modern/T1 independent of `hgbpdfa`, other fonts, fonts in graphics), language of the title page and German abstract of English theses (depending on the degree program), inclusive language (official German spelling rules of 2024), supplementary materials, LaTeX error messages, decimal commas and math tools (`icomma`, `siunitx`, `mathtools`), PDF/A setup and printing; the bibliography category is called `media` as in `hgbbib.sty`; the APA example no longer shows hard-coded page numbers; appendix D lists `main.tex` with `\lstinputlisting` (wrapped lines instead of overfull lines); the plagiarism section refers to the documentation of AI tools usage and the affidavit. Removed dead links and corrected numerous typos.
- 2026/09/13: [#215](https://github.com/Digital-Media/HagenbergThesis/issues/215): Updated the common bibliography `hgbreferences.bib`: current versions of the package manuals (keys renamed to `Bezos2026`, `Carlisle2026`, `Kime2026`, `Mittelbach2025`, `Pakin2026`), new entries `Mittelbach2023` (*The LaTeX Companion*, 3rd edition) and `Downes2017` (*Short Math Guide for LaTeX*, replaces the obsolete `Voss2014`), current amendments of the legal texts, English notes for entries with `langid=english`, and corrected typos, names, dates, links and the wrong DOI of `Burger1987`.
- 2026/09/13: [#215](https://github.com/Digital-Media/HagenbergThesis/issues/215): Updated the date of submission in all sample documents (and the semester in the lab reports) to 2027.
- 2026/09/12: [#197](https://github.com/Digital-Media/HagenbergThesis/issues/197): The declaration is now titled "Eidesstattliche Erklärung" / "Affidavit" and uses the text of the FH OÖ template of 2026 (all thesis types including internship reports). Updated the tutorials accordingly (use of AI tools, checklist, overview of the front pages).

- 2026/09/12: [#209](https://github.com/Digital-Media/HagenbergThesis/issues/209): Updated the documentation: new `CONTRIBUTING.md` (workflow for changes, local tests, automated build and check, branch `build`); `dev/README.md` with the local build workflow, the setup for TeX Live, details of the CI/CD workflow and corrections; updated `README.md` (PDF previews open in the GitHub PDF viewer, veraPDF as the PDF/A validator), CTAN README and `download/README.md`; the license of the project is unchanged (CC BY 4.0), only its file was reformatted: `LICENSE.md` was replaced by `LICENSE` with the original plain-text license text of Creative Commons instead of a reformatted Markdown version, so that the license is recognized automatically (e.g., by GitHub).
- 2026/09/11: [#204](https://github.com/Digital-Media/HagenbergThesis/issues/204): New `default` title page following the FH OÖ title page prototype for theses (logo at the top left, left-aligned text). The brand (logo and institution name) is set separately via `\hgb@SetBrand`, so `default` always shows the current official brand, while the new theme `fhooe26` pins the FH OÖ brand. The institution name is now optional in documents (provided by the theme). New class option `degree=<key>` for the academic degree on the title page, covering all degrees of Austrian FH degree programs (the level is taken from `type`; `\academicdegree{...}` for free text). The type of degree program is derived from `type` (`\programtype` is optional now). The previous default title page is available as theme `classic`. Internship report samples use the new title page.
- 2026/04/12: Renamed `noupdatecheck` to `updatecheck=true|false` for consistency with other boolean options (`true` = perform check, default; `false` = suppress); `noupdatecheck` kept as deprecated alias.
- 2026/04/10: Extended key-value option syntax to all boolean class options: `twoside=true|false` replaces the paired `oneside`/`twoside` options (bare `oneside` deprecated); `titlepage=true|false` replaces `notitlepage` in `hgbreport` (deprecated); `twocolumn=true|false` now correctly handles `=false` in `hgbarticle`; `smartquotes` and `apa` now correctly handle explicit `=false`.
- 2026/04/10: Modernized class option handling in `hgbarticle.cls` and `hgbreport.cls` to match `hgbthesis.cls`: key-value syntax (`language=english|german`) is now canonical; bare `english`/`german` options remain functional but issue a deprecation warning. Shared helper macros moved to `hgbvars.sty`. Babel loading restructured to correctly honor the `language=` option in all three classes.
- 2025/07/26: [#187](https://github.com/Digital-Media/HagenbergThesis/issues/187): Reworked printing chapter due to mostly digital submissions.

### Deprecated

- 2026/04/10: Bare language options `english`, `german`, `ngerman` as class options (use `language=english` / `language=german` instead).
- 2026/04/10: Bare `oneside` class option (use `twoside=false` instead).
- 2026/04/10: Bare `notitlepage` class option in `hgbreport` (use `titlepage=false` instead).
- 2026/04/12: `noupdatecheck` class option (use `updatecheck=false` instead).

### Removed

### Fixed

- 2025/05/26: [#180](https://github.com/Digital-Media/HagenbergThesis/issues/180): Fixed wrong URL style in APA documents.
- 2025/05/26: [#182](https://github.com/Digital-Media/HagenbergThesis/issues/182): Fixed wrong accent character for Exposé in German documents.
- 2025/07/10: [#185](https://github.com/Digital-Media/HagenbergThesis/issues/185): Fixed PDF-A generation due to a change in the `pdfmanagement-testphase` package.
- 2025/07/25: [#194](https://github.com/Digital-Media/HagenbergThesis/issues/194): Fixed bibliography file distributions in the project.
- 2025/09/05: [#190](https://github.com/Digital-Media/HagenbergThesis/issues/190): Fixed setup due to a change in `pdf-management-testphase` (again). Also reworked the project structure.
- 2025/11/11: [#199](https://github.com/Digital-Media/HagenbergThesis/issues/199): Fixed Babel loading unwanted configuration files.
- 2026/09/11: Fixed the missing default thesis type: `hgbthesis` now uses `type=master` if no type is given, as documented (previously the title page showed "undefined").
- 2026/09/11: Fixed the missing default license: `\license{cc}` is now used if `\license` is omitted, as documented (previously the copyright page showed "undefined").
- 2026/09/12: Fixed page numbers that were too wide for the table of contents in `hgbthesis` (e.g., roman "viii" in a longer front matter): the page number width (`\@pnumwidth`) is now 2em instead of 1.55em.
- 2026/09/11: Fixed the default title page language: without `titlelanguage` option, the front pages now use the main document language as documented (previously they were always English).
- 2026/09/11: Fixed the wrong accent character for "Exposé" in the German dictionary entry of `hgbdict.sty` and corrected its file header.
- 2026/09/11: Fixed outdated option descriptions in `HgbThesisTutorialDE`/`HgbThesisTutorialEN` (default language is `english`, key-value syntax, missing `phd` type, `titlelanguage` option), wrong language defaults in the comments of the German sample documents, and minor inconsistencies in the manual.
- 2026/09/12: [#216](https://github.com/Digital-Media/HagenbergThesis/issues/216): `hgbthesis` and `hgbreport` now load the T1 font encoding and the Latin Modern fonts themselves (with pdfLaTeX only), like `hgbarticle`. Previously these were only loaded by `hgbpdfa`, so documents without PDF/A output fell back to OT1 and Computer Modern (umlauts copied from the PDF as separate accents, poorer hyphenation of words with umlauts). Note that documents without `hgbpdfa` may therefore show slightly different line and page breaks. Documents with `hgbpdfa` are not affected.
- 2026/09/13: [#217](https://github.com/Digital-Media/HagenbergThesis/issues/217): Fixed the handling of `@electronic` entries in `hgbbib.sty`: like `@online` and `@www` (aliases in biblatex), they are now sorted and categorized as online sources. Previously they were printed as online sources but sorted as software, so citation lists containing such an entry were not in numeric order and not compressed (e.g. `[1, 4, 2, 3, 5, 6]` instead of `[1–6]`).
- 2026/09/14: [#224](https://github.com/Digital-Media/HagenbergThesis/issues/224): Fixed the missing display of the document title in PDF viewers: the title bar or tab now shows the title from the metadata instead of the file name (e.g., `main.pdf`), using the viewer preference `DisplayDocTitle` (also required by PDF/UA). The page content does not change.
- 2026/09/14: [#227](https://github.com/Digital-Media/HagenbergThesis/issues/227): Corrected the German texts of the documentation of AI tools usage (taken over from the FH OÖ templates): the date format in the source reference below the detailed form ("22. Mai 2023" instead of "Mai 22, 2023") and no comma before "etc." (e.g., "Zusammenfassungen etc.").
- 2026/09/14: [#227](https://github.com/Digital-Media/HagenbergThesis/issues/227): Fixed the warning for an unconfirmed statement in the detailed documentation of AI tools usage (missing `\aiconfirm{accuracy}` or `\aiconfirm{responsibility}`), which was never issued. All warnings of `hgbaiusage` are now shown completely in editors such as TeXstudio (every log line is shorter than 79 characters, and no line but the last one ends with a period; otherwise, TeXstudio cuts the message).

## [2025/02/24]

### Added

- 2025/02/24: [#171](https://github.com/Digital-Media/HagenbergThesis/issues/171): Added the class option `review` for `HgbArticle` to display line numbers while reviewing an article.
- 2025/02/18: [#15](https://github.com/Digital-Media/HagenbergThesis/issues/15): Added a way to handle cover pages more flexible. They are now themeable, their language can be set independently, multiple advisors can be specified and the cover now corresponds to ÖNORM A 2662. 
- 2025/02/18: [#77](https://github.com/Digital-Media/HagenbergThesis/issues/77): Added a `dissertation` option in the course of the flexible cover page.
- 2025/02/18: [#163](https://github.com/Digital-Media/HagenbergThesis/issues/163): Updated editor list in appendix a and mentioned Overleaf compile timeout.
- 2024/12/14: [#1](https://github.com/Digital-Media/HagenbergThesis/issues/1): Added the options `oneside` and `twoside` for switching between onesided and twosided layouts for saving paper when printing.
- 2024/12/09: [#169](https://github.com/Digital-Media/HagenbergThesis/issues/169): Added the `\DocumentMetadata` command to the style files to be futureproof in terms of document metadata handling.
- 2024/12/06: [#165](https://github.com/Digital-Media/HagenbergThesis/pull/165): Added a code environment for Scala. Thanks to [@marcelhas](https://github.com/marcelhas).

### Changed

- 2025/02/18: Updated the content of `references.bib`. Updated versions of various manuals and online sources. Adapted linked references in the documents accordingly.
- 2025/02/18: Updated the deadlines and semesters in the main files of all documents.

### Fixed

- 2025/02/21: [#170](https://github.com/Digital-Media/HagenbergThesis/issues/170): Fixed wrong sorting behavior when using the `nosplit` option with `\MakeBibliography`.

## [2023/11/06]

### Added

- 2023/10/26: [#132](https://github.com/Digital-Media/HagenbergThesis/issues/132): Setup added to produce PDF/A compliant documents, which is the default now. Added related instructions in `HgbThesisTutorialEN` and `HgbThesisTutorialDE`.

### Changed

- 2023/11/06: Updated the content of `references.bib`. Updated versions of various manuals and online sources. Adapted linked references in the documents accordingly.
- 2023/11/06: Updated the deadlines and semesters in the main files of all documents.

## [2023/02/13]

### Added

- 2021/01/04: [#114](https://github.com/Digital-Media/HagenbergThesis/issues/114): Added `apa` document option to switch to APA bibliography style.
- 2021/01/29: [#114](https://github.com/Digital-Media/HagenbergThesis/issues/114): Added two additional example documents (HgbThesisDE-APA and HgbThesisEN-APA) with a short introduction to the most important APA citation macros in it.
- 2021/01/29: [#114](https://github.com/Digital-Media/HagenbergThesis/issues/114): Added a section in `HgbThesisTutorial` about APA with instructions on how to enable it and an overview of the citation commands and the resulting reference list.
- 2021/03/02: [#119](https://github.com/Digital-Media/HagenbergThesis/discussions/119): Added `\email` macro in `hgb.sty` to print correct email addresses in documents and the preamble.
- 2021/06/24: [#127](https://github.com/Digital-Media/HagenbergThesis/issues/127): Added `\backmatter` section to `main.tex` to avoid things like a list of figures or acronyms being treated as appendices.
- 2022/12/28: [#138](https://github.com/Digital-Media/HagenbergThesis/issues/138): Expanded the table section in `HgbThesisTutorial` to include more information on creating tables, multi-page tables, and connecting rows and columns.
- 2023/01/03: [#146](https://github.com/Digital-Media/HagenbergThesis/issues/146): Include DOIs in references. Clear `url` field if a `doi` entry is present to avoid duplicate entries.
- 2023/01/16: [#155](https://github.com/Digital-Media/HagenbergThesis/issues/155): Added the option `proposal` for `hgbthesis` class documents with either the `bachelor` or `master` option active. Provided the two example documents, `HgbThesisDE-proposal` and `HgbThesisEN-proposal`, with an example exposé for a bachelor's thesis.
- 2023/02/13: [#140](https://github.com/Digital-Media/HagenbergThesis/issues/140): Added an English translation for the thesis tutorial. The documents are now called `HgbThesisTutorialEN` and `HgbThesisTutorialDE`. The documents have also been revised in terms of formatting and content.

### Changed

- 2020/10/30: [#111](https://github.com/Digital-Media/HagenbergThesis/issues/111): Removed `ctan/hagenberg-thesis/examples/` directory from CTAN bundle, modified `ctan` target in `makefile` and added another reference in `README.md` to this GitHub repo (CTAN admins had complained about duplicate files).
- 2021/03/05: [#120](https://github.com/Digital-Media/HagenbergThesis/issues/120): Algorithm setup converted to `algpseudocodex` for improved readability, added new spacing commands for fine-tuning.
- 2021/05/12: [#124](https://github.com/Digital-Media/HagenbergThesis/issues/124): Completely reworked `references.bib`. Replaced all occurrences of `year` and `month` with `date`. Switched `hyphenation` to `langid`. Also updated all references, corrected mistakes and removed unused entries from the file.
- 2021/06/24: Reworked all `main.tex` files and unified their appearance in terms of formatting and descriptions.
- 2021/06/24: [#125](https://github.com/Digital-Media/HagenbergThesis/issues/125): Changed displayed math shorthand from `$$...$$` to `\[...\]`. 
- 2022/06/30: [#137](https://github.com/Digital-Media/HagenbergThesis/issues/137): Clarified using the listings escape sequence for `GenericCode`.
- 2022/12/28: [#138](https://github.com/Digital-Media/HagenbergThesis/issues/138): Reworked all tables using the `booktabs` package for a more modern and cleaner look.
- 2023/01/09: [#151](https://github.com/Digital-Media/HagenbergThesis/pull/151): Re-formatted the source code of all example documents for a cleaner look. Line breaks are at 80 characters per line.
- 2023/01/12: [#135](https://github.com/Digital-Media/HagenbergThesis/issues/135): Added a guide on including SVG files in the document to the project's wiki: https://github.com/Digital-Media/HagenbergThesis/wiki/Including-SVGs. Also removed "Creating vector graphics using Inkscape" from `abbildungen.tex` into a wiki article: https://github.com/Digital-Media/HagenbergThesis/wiki/Vector-Graphics-with-Inkscape
- 2023/01/13: [#141](https://github.com/Digital-Media/HagenbergThesis/issues/141): Updated `HgbThesisTutorial` and all other documents. Removed outdated content and added or changed information where necessary.
- 2022/01/13: [#142](https://github.com/Digital-Media/HagenbergThesis/issues/142): Updated the content of `references.bib`. Updated versions of various manuals and online sources.

### Fixed

- 2021/03/22: Fixed two occurrences of missing gender-sensitive language in `HgbThesisTutorial`. Thanks to Julia Gruber.
- 2022/12/27: [#133](https://github.com/Digital-Media/HagenbergThesis/issues/133): Fixed `//` in the `CssCode` environment being treated as a comment.
- 2023/01/05: [#136](https://github.com/Digital-Media/HagenbergThesis/issues/136): Fixed smart quotes not working in the title.

## [2020/10/29]

### Added

- Added a section about gender-sensitive language and writing style.
- Cleanup of technical issues (software setup, workflow, printing) in ``HgbThesisTutorial``.
- Changed bibliography section titles from `Audio-visual media` (`Audiovisuelle Medien`) to `Media` (`Medien`) to include media types that are non-A/V (e.g., still images).
- Added hints in `HgbThesisTutorial` for citing musical scores. Modified `Appendix B` (listing of supplementary materials),
replacing obsolete CD/DVD by cloud archive submission.
- Modified repository setup (without GIT submodules) and adapted build process. All build-related parts are now contained in the new ``dev/`` directory, where .sty, .cls and .bib files are stored in a single place (``dev/latex/``). The build process updates the ``documents/`` and ``dev/ctan/`` directories. There is no duplication of document source files, all are in ``documents/``. Release dates are now automatically inserted (during build) into any date field, the ``9999/01/01`` dummy markers are not required any more. Experimental: ``latexmk`` is used in the build process.
- `hgbthesis.cls` now issues a package warning if trying to define multiple authors inside the `\author{..}` command. The `\and` and `\thanks{..}` commands are suppressed.
- Added `PythonCode` environment to include Python code in `listings` environments. Moved all build-related elements to a separate non-public repository, leaving only user-relevant parts in `HagenbergThesis`.
- Added a new load-time check to validate if the currently used `hagenberg-thesis` installation is no older than 365 days (in `hgb.sty`). Otherwise a warning is issued with a reminder to check for updates on Github. This check can be suppressed by passing the new class option `noupdatecheck`. In all `.cls` files the handling of class options was modified to pass all non-declared options to `hgb.sty`. In this course, the (obsolete) `datetime` package was replaced by the `datetime2` package (https://github.com/Digital-Media/HagenbergThesis/commit/2bc1895658b51904bfbbc2a7ec63230f23b9e17f).
- Added information on how/when to use the ``@unpublished`` biblatex tag in ``examples/HgbThesisTutorial`` (https://github.com/Digital-Media/HagenbergThesis/commit/90296eafc6089949780bf9c5e40b85836274fe3c).

### Changed

- Top-level folder ``examples`` renamed to ``documents``.
- Used gender-sensitive language in all German template documents. Also switched the example names to gender-neutral versions. Also updated references to their latest versions.

### Fixed

- Fixed sorting error with multiple keys in cite commands.
- Fixed error with \DTMgermanmonthname

## [2019/05/16]

### Added

- Added support for "smart quotes" using the ``csquotes`` package. To activate, pass the option ``smartquotes`` to any of the hgb document classes (all sample documents are set up to use this option). Remove document option ``smartquotes`` if traditional handling of quotes is desired. See ``examples/HgbThesisTutorial`` (Sec. 3.4.4) for details.

### Changed

- Added new listings definitions for JavaScript (including ES6, Node.js and a few others).

### Fixed

- Fixed and corrected outdated URLs and bibliography information.
- Corrected a few typos in the example document.

## [2018/11/28]

### Added
- Added patent references.
- Added setup for biblatex's ``\cites`` command (for multiple citations with supplementary texts).
- Added a new macro ``\citenobr`` (in ``hgbbib.sty``) to create citations with no ``backref`` entry in the bibliography.
- Added new macro ``\mcite`` for multiple citations with description texts (replacement for biblatex's ``\cites`` macro): ``\mcite`` inserts a semicolon as delimiter between each entry, while ordinary ``\cite`` inserts commas, as usual.
- CTAN release updated.

### Changed

- Revised setup for algorithms (all contained in new file ``hgbalgo.sty``): bug fixes, new commands, color.
- Better handling of multiple references in citations.
- Blocked ``subfigure``, ``lstlisting``, ``footnotes`` in captions.
- Discontinued support for the ``subfigure`` package (obsolete).

### Fixed
- Fixed ToC page breaking problems using the ``tocbasic`` package (replacing the ``tocloft`` package).
- Many small fixes and improvements.

## [2017/11/05]

### Added
- Automatic building with `make`.
- The bundle is distributed by CTAN as package [hagenberg-thesis](https://ctan.org/pkg/hagenberg-thesis).

### Changed
- Restructured setup for CTAN distribution
- Original `.cls` and `.sty` files are now stored in `common/`.
- Sample LaTeX documents are stored in `examples/`, with individual ZIP files for "single-click authoring" in Overleaf. Git submodules not needed any longer.

## [2017/10/16]

### Added
- New classes `hgbreport` and `hgbarticle`.
- Bibliography categorization.
- New bibliography examples.

### Changed
- PDF inclusion mechanism

## [2017/02/28]

### Added
- New and unified English commands for the front matter.

### Changed
- Headings in sans serif fonts.
- Smaller page margins.
- Two separate versions for German and English (the latter still being empty but ready to use).

## [2016/06/11]

### Added
This is the first release on GitHub. Future versions will now be published on this repository.
This version has also been ported to Overleaf for online editing.

[Unreleased]: https://github.com/Digital-Media/HagenbergThesis/compare/2025/02/24...HEAD
[2025/02/24]: https://github.com/Digital-Media/HagenbergThesis/compare/2023/11/06...2025/02/24
[2023/11/06]: https://github.com/Digital-Media/HagenbergThesis/compare/2023/02/13...2023/11/06
[2023/02/13]: https://github.com/Digital-Media/HagenbergThesis/compare/2020/10/29...2023/02/13
[2020/10/29]: https://github.com/Digital-Media/HagenbergThesis/compare/2019/05/16...2020/10/29
[2019/05/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2018/11/28...2019/05/16
[2018/11/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/11/05...2018/11/28
[2017/11/05]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/10/16...2017/11/05
[2017/10/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/02/28...2017/10/16
[2017/02/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2016/06/11...2017/02/28
[2016/06/11]: https://github.com/Digital-Media/HagenbergThesis/releases/tag/2016/06/11