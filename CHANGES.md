# Recent Changes

* [2017/10/18] Major restructuring: Split the LaTeX source into separate GIT sub-modules (repositories) to allow smooth integration with Overleaf.
* [2017/10/27] Revised structure to meet requirements of CTAN and Overleaf. Git submodules not needed any longer.
* [2018/06/17] Discontinued support for the ``subfigure`` package (obsolete).
* [2018/06/28] Disabled ``lstlisting`` environment (due to frequent abuse).
* [2018/07/01] Disabled the use of ``\footnote`` in captions.
* [2018/07/12] Revised setup for algorithms (all contained in new file ``hgbalgo.sty``): bug fixes, new commands, color.
* [2018/08/23] Added setup for biblatex's ``\cites`` command (for multiple citations with supplementary texts).
* [2018/08/31] Fixed ToC page breaking problems using the `tocbasic` package (replacing the `tocloft` package).
* [2018/09/18] Added a new macro ``\citenobr`` (in ``hgbbib.sty``) to create citations with no "backref" entry in the bibliography.
* [2018/10/09] Added examples for patent references to thesis tutorial.
* [2018/11/24] Added new macro ``\mcite`` for multiple citations with description texts (replacement for biblatex's ``\cites`` macro). ``\mcite`` insert a semicolon as delimiter between each entry, while an ordinary ``\cite`` inserts commas, as usual.
