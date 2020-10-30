# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project DOES NOT adhere to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

### Changed

-2020/10/30: Removed `ctan/hagenberg-thesis/examples/` directory from CTAN bundle, modified `ctan` target in `makefile` and added another reference in `README.md` to this GitHub repo. (CTAN admins had complained about duplicate files.)

### Fixed

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

[Unreleased]: https://github.com/Digital-Media/HagenbergThesis/compare/2020/10/29...HEAD
[2020/10/29]: https://github.com/Digital-Media/HagenbergThesis/compare/2019/05/16...2020/10/29
[2019/05/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2018/11/28...2019/05/16
[2018/11/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/11/05...2018/11/28
[2017/11/05]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/10/16...2017/11/05
[2017/10/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/02/28...2017/10/16
[2017/02/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2016/06/11...2017/02/28
[2016/06/11]: https://github.com/Digital-Media/HagenbergThesis/releases/tag/2016/06/11
