# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/), and this project DOES NOT adhere to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

- 2023/10/26: [#132](https://github.com/Digital-Media/HagenbergThesis/issues/132): Setup added to produce PDF/A compliant documents, which is the default now. Added related instructions in `HgbThesisTutorialEN` and `HgbThesisTutorialDE`.

### Changed

### Fixed

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
- Added a new load-time check to validate if the currently used `hagenberg-thesis` installation is no older than 365 days (in `hgb.sty`). Otherwise a warning is issued with a reminder to check for updates on Github. This check can be suppressed by passing the new class option `noUpdateCheck`. In all `.cls` files the handling of class options was modified to pass all non-declared options to `hgb.sty`. In this course, the (obsolete) `datetime` package was replaced by the `datetime2` package (https://github.com/Digital-Media/HagenbergThesis/commit/2bc1895658b51904bfbbc2a7ec63230f23b9e17f).
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

[Unreleased]: https://github.com/Digital-Media/HagenbergThesis/compare/2023/02/13...HEAD
[2023/02/13]: https://github.com/Digital-Media/HagenbergThesis/compare/2020/10/29...2023/02/13
[2020/10/29]: https://github.com/Digital-Media/HagenbergThesis/compare/2019/05/16...2020/10/29
[2019/05/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2018/11/28...2019/05/16
[2018/11/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/11/05...2018/11/28
[2017/11/05]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/10/16...2017/11/05
[2017/10/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/02/28...2017/10/16
[2017/02/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2016/06/11...2017/02/28
[2016/06/11]: https://github.com/Digital-Media/HagenbergThesis/releases/tag/2016/06/11