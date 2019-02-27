# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project DOES NOT adhere to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

- Added (experimental) support for "smart quotes" using the csquotes package. To activate, pass the option smartquotes to any of the hgb document classes. See examples/HgbThesisTutorial-smartquotes for details.

## [2018/11/28]

### Added
- Added patent references.
- Added setup for biblatex's \cites command (for multiple citations with supplementary texts).
- Added a new macro \citenobr (in hgbbib.sty) to create citations with no "backref" entry in the bibliography.
- Added new macro \mcite for multiple citations with description texts (replacement for biblatex's \cites macro): \mcite inserts a semicolon as delimiter between each entry, while ordinary \cite inserts commas, as usual.
- CTAN release updated.

### Changed

- Revised setup for algorithms (all contained in new file hgbalgo.sty): bug fixes, new commands, color.
- Better handling of multiple references in citations.
- Blocked subfigure, lstlisting, footnotes in captions.
- Discontinued support for the subfigure package (obsolete).

### Fixed
- Fixed ToC page breaking problems using the tocbasic package (replacing the tocloft package).
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

[Unreleased]: https://github.com/Digital-Media/HagenbergThesis/compare/2018/11/28...master
[2018/11/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/11/05...2018/11/28
[2017/11/05]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/10/16...2017/11/05
[2017/10/16]: https://github.com/Digital-Media/HagenbergThesis/compare/2017/02/28...2017/10/16
[2017/02/28]: https://github.com/Digital-Media/HagenbergThesis/compare/2016/06/11...2017/02/28
