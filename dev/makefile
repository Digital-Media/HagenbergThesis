# Local makefile to buld LaTeX examples in subdirectories.
# -----------------------------------------------------------------------
# Usage (assuming a Linux-type shell, e.g. Git Bash on Windows):
# 'make' or 'make all' -> to rebuild everything
# 'make setdates' -> update version dates in *.sty and *.cls files
# 'make build' -> to build all example documents
# 'make <example>' -> to buld a specific example document, e.g. 'make HgbArticle'
# 'make ctan' -> to build the complete CTAN distribution
# -----------------------------------------------------------------------

SHELL = /bin/sh
TMPDIR = tmpltx
ZIPEXE := zip
MKFILELATEX := $(realpath makefile-latex)

# -----------------------------------------------------------------------
# directory where 'make' is started
TEXMFDIR := $(realpath texmf)
# directory where we keep the original .cls and .sty files
SOURCEDIR = $(realpath texmf)/tex/latex/hagenberg-thesis
# directory where we keep the original .bib files
BIBTEXDIR = $(realpath texmf)/bibtex/bib
# directory for holding .sty files from other packages if needed
SOURCEDIRFOREIGN = $(realpath texmf)/tex/latex-foreign
# Target directory for the compiled documents (examples):
DOCSDIR := $(realpath ../documents)
# Collect all subdirectories (examples) in DOCSDIR:
DOCSLIST := $(shell cd $(DOCSDIR); find * -maxdepth 0 -type d)
# -----------------------------------------------------------------------
# Date-related stuff:
TODAY := $(shell date +"%Y\/%m\/%d")
# Specify a specific release date as 'yyyy\/mm\/dd' (default is TODAY):
# RELEASEDATE := 2018\/11\/28
RELEASEDATE := $(TODAY)
# The pattern used to find the release date in .sty and .cls files: '[yyyy/mm/dd]%%AUTO'
DATEPATTERN := \[[0-9]\{4\}\/[0-9]\{2\}\/[0-9]\{2\}\]%%AUTO
# -----------------------------------------------------------------------
# This directory holds everything needed for CTAN distribution:
CTANDIR := $(realpath ctan)
# The official package name on CTAN
CTANBUNDLE := hagenberg-thesis
# The subdirectory to hold the sample documents in CTAN
# CTANDOCSLIST := examples
# The release date line in ctan/hagenberg-thesis/README.md starts with "### Version:"
READMEVERSIONTAG := "\#\#\# Version:"
# -----------------------------------------------------------------------

all : setdates build ctan
.PHONY : all showsetup inittex setdates build ctan $(DOCSLIST)

showsetup :
	@echo TEXMFDIR = $(TEXMFDIR)
	@echo SOURCEDIR = $(SOURCEDIR)
	@echo BIBTEXDIR = $(BIBTEXDIR)
	@echo SOURCEDIRFOREIGN = $(SOURCEDIRFOREIGN)
	@echo DOCSDIR = $(DOCSDIR)
	@echo DOCSLIST = $(DOCSLIST)
	@echo TODAY = $(TODAY)
	@echo RELEASEDATE = $(RELEASEDATE)
	@echo DATEPATTERN = $(DATEPATTERN)
	@echo CTANDIR = $(CTANDIR)
	@echo CTANBUNDLE = $(CTANBUNDLE)
#	@echo CTANDOCSLIST = $(CTANDOCSLIST)
	@echo READMEVERSIONTAG = $(READMEVERSIONTAG)
	
inittex :
#	Add /dev/texmf... as a TEXMF root directory (not executed in a full make).
#	Note: this must be a clean TEXMF dir, with nothing else in it. Otherwise MikTeX 'update-fndb' throws an error!
# https://docs.miktex.org/manual/initexmf.html
# https://tex.stackexchange.com/questions/69483/create-a-local-texmf-tree-in-miktex
#
	initexmf --register-root=$(TEXMFDIR) --verbose
	initexmf --update-fndb --verbose
#	initexmf -u
	initexmf --report
#	initexmf --unregister-root=$(TEXMFDIR) --verbose


setdates :
# Problem: setdates updates ALL such files, thus all examples must be rebuilt!!!
#	Replaces any date of the form [yyyy/mm/dd] in *.cls and *.sty *.tex files:
	@echo Updating release date in all sty/cls files to [$(RELEASEDATE)]
	@$(shell sed -i 's|$(DATEPATTERN)|\[$(RELEASEDATE)\]%%AUTO|' $(SOURCEDIR)/*.sty $(SOURCEDIR)/*.cls $(BIBTEXDIR)/*.bib)
	@echo ""

build : $(DOCSLIST)
#	Defines a make target for each directory name in DOCSLIST

$(DOCSLIST) : 
#	Builds and zips every document (directory) in DOCSLIST
	@echo "+++ Processing document \"$@\" +++"
#	Copy all .sty .cls *.bib files to the document directory:
	@echo "Temporarily copying .sty, .cls files from $(SOURCEDIR) and $(SOURCEDIRFOREIGN)"
	@find $(SOURCEDIR)/ -type f -name "*.sty" -exec cp -u {} $(DOCSDIR)/$@ \;
	@find $(SOURCEDIR)/ -type f -name "*.cls" -exec cp -u {} $(DOCSDIR)/$@ \;
	@find $(SOURCEDIRFOREIGN)/ -type f -name "*.sty" -exec cp -u {} $(DOCSDIR)/$@ \;
	@echo "Temporarily copying .bib files from $(BIBTEXDIR)"
	@find $(BIBTEXDIR)/ -type f -name "*.bib" -exec cp -u {} $(DOCSDIR)/$@ \;
#
#	Run the LaTeX build in a sub-makefile:
	@make --silent -C $(DOCSDIR)/$@ -f $(MKFILELATEX)
#	Make a ZIP for importing to Overleaf:
	@echo "Creating document ZIP file $@.zip"
	@cd $(DOCSDIR)/; rm -f $@.zip; $(ZIPEXE) -r -q $@.zip $@
#	Remove all local .sty .cls *.bib files from the document directory:
	@echo "Final cleanup in $(DOCSDIR)/$@: deleting .sty, .cls, .bib files"
	@find $(DOCSDIR)/$@ -name "*.sty" -type f -delete
	@find $(DOCSDIR)/$@ -name "*.cls" -type f -delete
	@find $(DOCSDIR)/$@ -name "*.bib" -type f -delete
	@echo ""
	
ctan :
#	Builds the CTAN distribution
	@echo "" 
	@echo "Building CTAN bundle ..."
#	Copy all .sty and .cls files to ctan/hagenberg-thesis/latex/
	@echo "  copying .sty and .cls files from $(SOURCEDIR)/"
	@find $(CTANDIR)/$(CTANBUNDLE)/latex -name "*.sty" -type f -delete
	@find $(CTANDIR)/$(CTANBUNDLE)/latex -name "*.cls" -type f -delete
	@cp -u $(SOURCEDIR)/*.sty $(SOURCEDIR)/*.cls $(CTANDIR)/$(CTANBUNDLE)/latex
#	Copy all .bib to ctan/hagenberg-thesis/bibtex/
	@echo "  copying .bib files from $(BIBTEXDIR)/"
	@find $(CTANDIR)/$(CTANBUNDLE)/bibtex -name "*.bib" -type f -delete
	@cp -u $(BIBTEXDIR)/*.bib $(CTANDIR)/$(CTANBUNDLE)/bibtex
#
#	Copy manual/tutorial source and PDFs to ctan/hagenberg-thesis/doc/
	@echo "  Copying manual/tutorial source and PDFs to $(CTANDIR)/doc/"
	@find $(CTANDIR)/$(CTANBUNDLE)/doc -name "*.tex" -type f -delete
	@find $(CTANDIR)/$(CTANBUNDLE)/doc -name "*.pdf" -type f -delete
	@cp -u $(DOCSDIR)/Manual/main.tex $(CTANDIR)/$(CTANBUNDLE)/doc/$(CTANBUNDLE).tex
	@cp -u $(DOCSDIR)/Manual/main.pdf $(CTANDIR)/$(CTANBUNDLE)/doc/$(CTANBUNDLE).pdf
	@cp -u $(DOCSDIR)/HgbThesisTutorialEN/main.pdf $(CTANDIR)/$(CTANBUNDLE)/doc/$(CTANBUNDLE)-tutorial-en.pdf
	@cp -u $(DOCSDIR)/HgbThesisTutorialDE/main.pdf $(CTANDIR)/$(CTANBUNDLE)/doc/$(CTANBUNDLE)-tutorial-de.pdf
#
#	Update version number in package README file:
	@echo "  Updating version number in package README.md"
	@$(shell sed -i 's|$(READMEVERSIONTAG).*|$(READMEVERSIONTAG) $(RELEASEDATE)|' $(CTANDIR)/$(CTANBUNDLE)/README.md)
#	Make a ZIP of the complete CTAN bundle:
	@echo "  ZIPing the complete CTAN bundle"
	@cd $(CTANDIR)/; rm -f $(CTANBUNDLE).zip; $(ZIPEXE) -r -q $(CTANBUNDLE).zip $(CTANBUNDLE)



	
	
	