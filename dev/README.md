# Hagenberg Thesis Development Directory

This is mainly a notebook for the developers of `HagenbergThesis` and probably not relevant for average users.

## What You Find Here

`/dev` is the development directory for the [HagenbergThesis](https://github.com/Digital-Media/HagenbergThesis) package. It contains the following in the respective directories:

- `latex`: Master style files, classes, and bibliography for the package.
- `ctan`: Distribution files for hagenberg-thesis on [CTAN](https://ctan.org/pkg/hagenberg-thesis).
- `latex-foreign`: Third-party packages, which are to be included with the example documents because certain (older) LaTeX distributions do not have this package or the required version.

## How to Use

### Editing Styles and Classes

Make your edits to the style files and classes in the `latex` directory. If the changes are substantial, create a branch and suggest them by opening a pull request.

Do *not* edit the version/date strings in `.cls`, `.sty` and `.tex` files. 
These are marked `%%AUTO` and are automatically replaced with the current date during the build process.

### Building and Distributing the Files

The `makefile` in this directory does the following:

- It adds the current date to the files and then copies them to the various example documents in the `documents` directory.
- It runs a multi-pass LaTeX and Biber/BibLaTeX build using `latexmk` on each example document in the `documents` directory to build and create the corresponding PDF files. This is only done if necessary, e.g., when files are outdated or missing.
- It compresses each document into a ZIP file in the `documents` directory for easy distribution and use with [Overleaf](https://www.overleaf.com/).
- It assembles all the files necessary for submission on CTAN (styles and classes, documentation, and examples) with the correct directory structure.

#### Preparing the Build Process for Windows

This requires 'make' and 'zip' to be installed. This setup uses the GNU Win32 implementations.

1. Install **GnuWin Make** through one of the following options:
   1. [Download and run the GnuWin Make installer](http://gnuwin32.sourceforge.net/downlinks/make.php). This installs `make.exe` in `C:\Program Files (x86)\GnuWin32\bin`.
   2. Install using [Chocolatey](https://chocolatey.org/): `choco install make`.
   3. Install using [WinGet](https://learn.microsoft.com/windows/package-manager/winget/): `winget install GnuWin32.Make`.
2. Install **GnuWin Zip** through one of the following options:
   1. [Download and run the GnuWin Zip installer](http://gnuwin32.sourceforge.net/downlinks/zip.php). This installs `zip.exe` in `C:\Program Files (x86)\GnuWin32\bin`.
   2. Install using Chocolatey: `choco install zip`.
   3. Install using WinGet: `winget install GnuWin32.Zip`.
3. Add `C:\Program Files (x86)\GnuWin32\bin` to the Windows PATH using Control Panel -> System -> Advanced system settings -> Environment variables. If the tools were installed using Chocolatey or WinGet, they were added to the path in the process.
4. To verify if the installation is working, start the 'GitBash' shell (part of the Windows GIT installation) and run `which make` and `which zip`. This should show the location of the make executable:

```shell
$ which make
/c/Program Files (x86)/GnuWin32/bin/make
$ which zip
/c/Program Files (x86)/GnuWin32/bin/zip
```

#### Starting a Complete Build

In the directory `dev/` enter

```shell
$ make
```

Relax and grab a coffee.

#### Building Individual Parts

It is also possible to execute specific parts of the build process. Call `make` with the appropriate parameters:

- `make inittex`: Adds `/dev/texmf/` as a TEXMF root directory. This should be run before building documents locally in `/documents/` (not executed in a full make).
- `make setdate`: Sets the version number to the current date in all `.sty` and `.cls` files.
- `make build`: Builds all the example documents in the `documents` directory.
- `make [DocumentName]`: Builds a single example document. Replace `[DocumentName]` with the respective document's directory name. E.g., use `make HgbThesisTutorialDE` to build the thesis tutorial document or `make HgbArticle` to build the article template.
- `make ctan`: Builds and gathers all the files for the CTAN package (located in the `ctan` directory).

### Testing Changes

To test and review your changes, open one of the example documents in the `documents` directory (e.g., `HgbThesisTutorial`) after a complete or partial build process.
It will include the updated style files and classes, which can then be tested and evaluated. Remember to make further changes only to the style and class files in the `dev/latex` directory.
The build process will override any changes to the style or class files of the example documents.

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
