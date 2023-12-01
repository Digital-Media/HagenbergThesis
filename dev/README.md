# Hagenberg Thesis Development Directory

This is mainly a notebook for the developers of `HagenbergThesis` and probably not relevant for average users.

## What You Find Here

`/dev` is the development directory for the [HagenbergThesis](https://github.com/Digital-Media/HagenbergThesis) package. It contains the following in the respective directories:

- `tex/latex`: Master style files, classes, and bibliography for the package (input when used as a local TEXMF root directory, see below).
- `ctan`: Distribution files for hagenberg-thesis on [CTAN](https://ctan.org/pkg/hagenberg-thesis).
- `latex-foreign`: Third-party packages, which are to be included with the example documents because certain (older) LaTeX distributions do not have this package or the required version.

`/dev` can be used as a local TEXMF root directory for development.

## How to Use

### Editing Styles and Classes

Make your edits to the style files and classes in the `latex` directory. If the changes are substantial, create a branch and suggest them by opening a pull request.

Do *not* edit the version/date strings in `.cls`, `.sty` and `.tex` files. 
These are marked `%%AUTO` and are automatically replaced with the current date during the build process.

### Building and Distributing the Files

The `makefile` in this directory does the following:

- It adds the current date to the files and then copies them to the various example documents in the `documents` directory.
- It runs a multi-pass LaTeX, and Biber/BibLaTeX build using `latexmk` on each example document in the `documents` directory to build and create the corresponding PDF files. This is only done if necessary, e.g., when files are outdated or missing.
- It compresses each document into a ZIP file in the `documents` directory for easy distribution and use with [Overleaf](https://www.overleaf.com/).
- It assembles all the files necessary for submission on CTAN (styles and classes, documentation, and examples) with the correct directory structure.

#### Preparing the Build Process for Windows

This requires 'make' and 'zip' to be installed. This setup uses the GNU Win32 implementations.

1. Download [GnuWin Make](http://gnuwin32.sourceforge.net/downlinks/make.php). This installs `make.exe` in `C:\Program Files (x86)\GnuWin32\bin`. When using [Chocolatey](https://chocolatey.org/), run `choco install make`.
2. Download [GnuWin Zip](http://gnuwin32.sourceforge.net/downlinks/zip.php). This installs `zip.exe` in `C:\Program Files (x86)\GnuWin32\bin`. For Chocolatey, run `choco install zip`.
3. Add `C:\Program Files (x86)\GnuWin32\bin` to the Windows PATH using Control Panel -> System -> Advanced system settings -> Environment variables. If the tools were installed using Chocolatey, they were added to the path in the process.
4. To verify if the install is working, start the 'GitBash' shell (part of the Windows GIT installation) and run `which make` and `which zip`. This should show the location of the make executable:
```
$ which make
/c/Program Files (x86)/GnuWin32/bin/make
$ which zip
/c/Program Files (x86)/GnuWin32/bin/zip
```

#### Starting a Complete Build

```
$ make
```

Relax and maybe grab a coffee.

#### Building Individual Parts

It is also possible to execute specific parts of the build process. Call `make` with the appropriate parameters:

- `make setdate`: Sets the current date for all the style and class files.
- `make build`: Builds all the example documents in the `documents` directory.
- `make [DocumentName]`: Builds a single example document. Replace `[DocumentName]` with the respective document's directory name. E.g., use `make HgbThesisTutorial` to build the thesis tutorial document or `make HgbArticle` to build the article template.
- `make ctan`: Builds and gathers all the files for the CTAN package (located in the `ctan` directory).

### Testing Changes

To test and review your changes, open one of the example documents in the `documents` directory (e.g., `HgbThesisTutorial`) after a complete or partial build process. It will include the updated style files and classes, which can then be tested and evaluated. Keep in mind to make further changes only to the style and class files in the `dev/latex` directory. The build process will override any changes to the style or class files of the example documents.

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
