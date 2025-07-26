# Hagenberg Thesis Development Directory

This directory is exclusively used for developing and building the `HagenbergThesis` package.
Typical package users will probably find no relevant information here.

## What You Find Here

`/dev` is the development directory for the [HagenbergThesis](https://github.com/Digital-Media/HagenbergThesis) package. It contains the following in the respective directories:

- `texmf`: Master style files, classes, and bibliography for the package.
- `ctan`: Distribution files for `hagenberg-thesis` submitted to [CTAN](https://ctan.org/pkg/hagenberg-thesis).

## How to Use

### Editing Styles and Classes

Make your edits to the style files and classes in the `latex` directory. If the changes are substantial, create a branch and suggest them by opening a pull request.

Do *not* edit the version/date strings in `.cls`, `.sty` and `.tex` files. 
These are marked `%%AUTO` and are automatically replaced with the current date during the build process.

### Building and Distributing the Files

The `makefile` in this directory does the following:

- Updates the date fields in all package files files before copying them to the various example documents in the `documents` directory.
- Runs a multi-pass `LaTeX` and `Biber`/`BibLaTeX` build using `latexmk` on each sample document in the `documents` directory to build and create the corresponding PDF files. This is only done if necessary, e.g., when files are outdated or missing.
- Packs each document into a ZIP file in the `download` directory for easy distribution and direct upload to [Overleaf](https://www.overleaf.com/).
- Builds the associated package manual.
- Assembles all files necessary for submission on CTAN (styles and classes, documentation, and examples) with the correct directory structure.

#### Preparing the Build Process for Windows

This requires `make` and `zip` executables to be installed, e.g., the GNU Win32 implementations:

1. Install **GnuWin Make** through one of the following options:
   1. Download and run the [GnuWin Make installer](http://gnuwin32.sourceforge.net/downlinks/make.php). This installs `make.exe` in `C:\Program Files (x86)\GnuWin32\bin`.
   2. Install using [Chocolatey](https://chocolatey.org/): `choco install make`.
   3. Install using [WinGet](https://learn.microsoft.com/windows/package-manager/winget/): `winget install GnuWin32.Make`.
2. Install **GnuWin Zip** through one of the following options:
   1. Download and run the [GnuWin Zip installer](http://gnuwin32.sourceforge.net/downlinks/zip.php). This installs `zip.exe` in `C:\Program Files (x86)\GnuWin32\bin`.
   2. Install using Chocolatey: `choco install zip`.
   3. Install using WinGet: `winget install GnuWin32.Zip`.
3. Add `C:\Program Files (x86)\GnuWin32\bin` to the Windows PATH using `Control Panel` ➔ `System` ➔ `Advanced system settings` ➔ `Environment variables`. If the tools are installed using Chocolatey or WinGet, they are automatically added to the path in the process.
4. To verify if the installation is working, start the `GitBash` shell (part of the Windows GIT installation) and run `which make` and `which zip`. This should show the location of the make executable, for example:

```shell
$ which make
/c/Program Files (x86)/GnuWin32/bin/make
$ which zip
/c/Program Files (x86)/GnuWin32/bin/zip
```

#### Running a Complete Build

Open a `GitBash` shell in directory `dev/` and simply enter
```shell
$ make
```

Relax and grab a coffee...

#### Building Individual Parts

It is also possible to execute specific parts of the build process. Call `make` with the following arguments:

- `make inittex`: Adds `/dev/texmf/` as a TEXMF root directory. This should be run once before building documents locally in `/documents/`. Note that this is not executed during a normal (full) `make`.
- `make uninittex`: Unlinks `/dev/texmf/` as a TEXMF root directory. This is needed for building documents in `/documents/` from global `hagenberg-thesis` package files installed in the local LaTeX installation (distributed via CTAN).
- `make setdate`: Sets the version number to the current date in all `.sty` and `.cls` files.
- `make build`: Builds all sample documents in the `documents` directory.
- `make [DocumentName]`: Builds a single sample document. Replace `[DocumentName]` with the respective document's directory name. E.g., use `make HgbThesisTutorialDE` to build the thesis tutorial document or `make HgbArticle` to build the article document.
- `make manual`: Builds the package manual.
- `make ctan`: Builds and gathers all files required for the CTAN distribution (in directory `ctan`).

### Testing Changes

To test and review your changes, open one of the example documents in the `documents` directory (e.g., `HgbThesisTutorial`) after a complete or partial build process.
This will include the updated pdf, which can then be tested and evaluated (e.g., for PDF/A and included metadata). Note that the package's required `.sty`, `.cls` and `.pdf` files are only copied temporarily to the document directories during the build process and subsequently removed again. Only an up-to-date copy of the common bibtex file `references.bib` remains in the document directory, because it cannot be distributed through CTAN.


### GIT Repository Cleanup

Since this repo holds several binary files (pdf, zip), its size grows steadily with each update. To purge such files from the repo's history, do the following:

- Get [BFG Repo Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) (a single Java JAR file, referred to as ``bfg.jar`` below).

Use the shell (`Git Bash`) to perform the following steps:

- ``$ git clone --mirror https://github.com/Digital-Media/HagenbergThesis.git`` (this creates a bare repo in folder ``HagenbergThesis.git``)
- Make a backup copy of ``HagenbergThesis.git`` to be safe.
- ``$ java -jar bfg.jar --delete-files 'main.pdf,hagenberg*.zip,Hgb*.zip,Manual.zip' HagenbergThesis.git``
- ``$ cd HagenbergThesis.git``
- ``$ git reflog expire --expire=now --all && git gc --prune=now --aggressive``
- ``$ git push``

Cleaning reports can be found in the ``HagenbergThesis.git.bfg-report`` folder.

Finally, make a **fresh checkout** (clone) from ``https://github.com/Digital-Media/HagenbergThesis.git`` to avoid local garbage being pushed again!
