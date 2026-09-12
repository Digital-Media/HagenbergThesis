# Contributing to the Hagenberg Thesis Package

Thank you for your interest in improving `hagenberg-thesis`! This document describes how to report problems, how changes find their way into the package, and how to test them locally and with the automated build (CI/CD).

## Reporting Problems and Suggesting Features

- **Bugs and feature requests:** open an [issue](https://github.com/Digital-Media/HagenbergThesis/issues). Please describe what you did, what you expected, and what happened instead; a minimal example document and the LaTeX log file help a lot.
- **Questions** about using the package are best asked in the [discussions](https://github.com/Digital-Media/HagenbergThesis/discussions).
- Planned and ongoing work is tracked on the [backlog board](https://github.com/orgs/Digital-Media/projects/1). Every piece of work starts as an issue, which is then labeled (type, affected area) and, if applicable, assigned to a release milestone.

## Workflow for Changes

All changes to `main` are made via **pull requests**. `main` contains source files only; all generated files are built automatically.

1. **Issue:** make sure there is an issue describing the change (or open one).
2. **Branch:** create a branch from the current `main` (in a fork, if you do not have write access to the repository).
3. **Change the source files** only, e.g.:
   - package files (classes, styles, themes, bibliography) in `dev/texmf/`,
   - sample documents in `documents/` (`.tex` files, images),
   - the manual in `manual/main.tex`,
   - documentation such as the READMEs and this file.
4. **Do not commit generated files** (PDFs, ZIP files, the CTAN bundle, log files). They are ignored by git and built by the workflow after merging.
5. **Do not edit the date stamps** marked with `%%AUTO` in `.sty`, `.cls` and `.bib` files; they are set automatically during the build.
6. **Conventions:**
   - Code comments, commit messages, the CHANGELOG and the READMEs are written in English. German is only used inside German documents (e.g., `HgbThesisTutorialDE`, German dictionary entries).
   - Add an entry to [CHANGELOG.md](CHANGELOG.md) under *[Unreleased]* in the matching section (*Added*, *Changed*, *Deprecated*, *Removed*, *Fixed*), with the date and a link to the issue.
   - If you change the behavior of the package, update the manual (`manual/main.tex`) and, where applicable, the tutorials (`HgbThesisTutorialEN`, `HgbThesisTutorialDE`) and the sample documents.
7. **Test** your changes locally (see below).
8. **Pull request:** open a pull request to `main` that references the issue (e.g., `Closes #123`). The automated check runs for every pull request (see below); it must pass before the pull request can be merged.
9. **Review and merge:** after the review, the pull request is merged into `main` (using a merge commit). The workflow then builds everything and publishes the results.

## Testing Changes Locally

The build uses the makefiles in `dev/`. The prerequisites (a TeX distribution with `latexmk` and `biber`, `make` and `zip`) and all make targets are described in [dev/README.md](dev/README.md). In a Unix-like shell (Git Bash on Windows), in directory `dev/`:

```shell
$ make HgbThesisTutorialEN   # build a single sample document
$ make documents manual      # build all sample documents and the manual
$ make check                 # check the results (see below)
```

- The resulting PDFs are found in `documents/<name>/main.pdf` and `manual/main.pdf`, the ZIP files for Overleaf in `download/`.
- `make check` requires [veraPDF](https://verapdf.org/software/) for the PDF/A check; use `make check VERAPDF=/path/to/verapdf` if it is not on the path, or `make check VERAPDF=skip` to check the log files only.
- The log files of each build are kept in `dev/logs/`.
- The full `make` additionally updates the date stamps in the package files and builds the CTAN bundle. This modifies tracked files, which must not be committed (see [dev/README.md](dev/README.md#running-a-complete-build)).

## Automated Build and Check (CI/CD)

The GitHub Actions workflow [`build.yml`](.github/workflows/build.yml) runs the same makefiles in a current TeX Live (Docker image `texlive/texlive:latest`):

| Event | Build | Check | Results |
|:--|:--|:--|:--|
| Pull request to `main` | `make all` | `make check` | attached to the workflow run as an artifact |
| Manual run (any branch) | `make all` | `make check` | attached to the workflow run as an artifact |
| Push to `main` (merged pull request) | `make all` | `make check` | published to the branch `build` |

### What Is Checked

`make check` (script `dev/check-build.sh`) lets the check fail if

- the PDF file of a sample document or of the manual is missing (e.g., because the build failed),
- a log file contains a TeX/LaTeX error,
- a reference or citation is undefined, or cross references are not resolved,
- biblatex asks to rerun Biber or LaTeX,
- a character is missing in a font,
- a class or style of the package itself (`hgb*`) issues a warning or an error, e.g., about a deprecated option,
- Biber reports an error, or
- a PDF file is not PDF/A-2b compliant (validated with the current [veraPDF](https://verapdf.org)).

All other warnings (e.g., overfull or underfull boxes) are only counted. The results of each document are shown as a table in the job summary of the workflow run; failures are also shown as annotations.

### Testing a Pull Request

- The check appears as *Build and check* at the bottom of the pull request. Click *Details* to see the log and the summary of the run.
- The built PDFs and log files can be downloaded from the *Summary* page of the workflow run (section *Artifacts*). They are kept for 14 days.
- Every push to the branch of the pull request starts a new run.
- To build a branch without a pull request, start the workflow manually: *Actions* ➔ *Build and check documents* ➔ *Run workflow* ➔ select the branch.

### After Merging: the Branch `build`

After a pull request is merged, the workflow builds `main` again and publishes the result to the branch [`build`](https://github.com/Digital-Media/HagenbergThesis/tree/build): the sources of `main` with the current date stamps plus all generated files (PDFs, ZIP files, CTAN bundle). This branch consists of a **single commit without history** that is replaced on every build, so the repository does not grow with every change. The PDF previews, ZIP downloads and Overleaf links in the [README](README.md) point to this branch; they are updated a few minutes after merging.

Never commit to the branch `build` directly; it is overwritten by the next build.
