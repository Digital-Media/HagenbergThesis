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
# directory where we keep the original .cls and .sty files
SOURCEDIR=tex/latex/hagenberg-thesis
# directory where we keep the original .bib files
BIBTEXDIR=bibtex/bib
# directory for holding .sty files from other packages if needed
SOURCEDIRFOREIGN=latex-foreign
# Target directory for the compiled documents (examples):
DOCUMENTSDIR := ../documents
# Collect all subdirectories (examples) in DOCUMENTSDIR:
EXAMPLES := $(shell cd $(DOCUMENTSDIR); find * -maxdepth 0 -type d)
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
CTANDIR := ctan
# The official package name on CTAN
CTANPKG := hagenberg-thesis
# The subdirectory to hold the sample documents in CTAN
CTANEXAMPLES := examples
# The release date line in ctan/hagenberg-thesis/README.md starts with "### Version:"
READMEVERSIONTAG := \#\#\# Version:
# -----------------------------------------------------------------------

all : setdates build ctan
.PHONY : all setdates build ctan $(EXAMPLES)

setdates :
# Problem: setdates updates ALL such files, thus all examples must be rebuilt!!!
#	Replaces any date of the form [yyyy/mm/dd] in *.cls and *.sty *.tex files:
	@echo Updating release date in all sty/cls files to [$(RELEASEDATE)]
	@$(shell sed -i 's|$(DATEPATTERN)|\[$(RELEASEDATE)\]%%AUTO|' $(SOURCEDIR)/*.sty $(SOURCEDIR)/*.cls $(BIBTEXDIR)/*.bib)
	@echo ""

build : $(EXAMPLES)
#	Defines a make target for each directory name in EXAMPLES

$(EXAMPLES) : 
#	Builds and zips every document (directory) in EXAMPLES
	@echo "+++ Processing document \"$@\" +++"
#	Copy all .sty .cls *.bib files to the example directory:
	@echo "updating .sty, .cls, .bib files from $(SOURCEDIR)/"
	@find $(SOURCEDIR)/ -type f -name "*.sty" -exec cp -u {} $(DOCUMENTSDIR)/$@ \;
	@find $(SOURCEDIR)/ -type f -name "*.cls" -exec cp -u {} $(DOCUMENTSDIR)/$@ \;
	@find $(SOURCEDIR)/ -type f -name "*.bib" -exec cp -u {} $(DOCUMENTSDIR)/$@ \;
	@find $(SOURCEDIRFOREIGN)/ -type f -name "*.sty" -exec cp -u {} $(DOCUMENTSDIR)/$@ \;
#	@cp -u $(SOURCEDIR)/*.sty $(DOCUMENTSDIR)/$@
#	@cp -u $(SOURCEDIR)/*.cls $(DOCUMENTSDIR)/$@
#	@cp -u $(SOURCEDIR)/*.bib $(DOCUMENTSDIR)/$@
#	@cp -u $(SOURCEDIRFOREIGN)/*.sty $(DOCUMENTSDIR)/$@
#
#	Run the LaTeX build in a sub-makefile:
	@make --silent -C $(DOCUMENTSDIR)/$@ -f $(MKFILELATEX)
#	Make a ZIP for importing to Overleaf:
#	@echo "creating $@.zip"
#	@cd $(DOCUMENTSDIR)/; rm -f $@.zip; $(ZIPEXE) -r -q $@.zip $@
	@echo ""
	
ctan :
#	Builds the CTAN distribution
	@echo "" 
	@echo "Building CTAN bundle ..."
#	Copy all .sty and .cls files to ctan/hagenberg-thesis/latex/
	@echo "  copying .sty and .cls files from $(SOURCEDIR)/"
	@cp -u $(SOURCEDIR)/*.sty $(SOURCEDIR)/*.cls $(CTANDIR)/$(CTANPKG)/latex
#
#	Copy the entire documents/ directory to ctan/hagenberg-thesis/ (clear target first)
#	@echo "  copying $(DOCUMENTSDIR)/ directory to $(CTANEXAMPLES)/"
#	@rm -r -f $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/*
#	@cp -u -R $(DOCUMENTSDIR)/* $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)
#
#	Remove all .sty and .cls files in ctan/hagenberg-thesis/examples/ (recursively):
#	@echo "  removing all .sty and .cls files in $(CTANEXAMPLES)/"
#	@find $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/ -name "*.sty" -type f -delete
#	@find $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/ -name "*.cls" -type f -delete
#
#	Remove all top-level ZIP files in ctan/hagenberg-thesis/examples/:
#	@echo "  removing ZIP files in $(CTANEXAMPLES)/"
#	@find $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/ -maxdepth 1 -name "*.zip" -type f -delete
#
#	Copy manual/tutorial source and PDFs to ctan/hagenberg-thesis/doc/
	@echo "  copying manual/tutorial source and PDFs to $(CTANDIR)/doc/"
	@cp -u $(DOCUMENTSDIR)/Manual/main.tex $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).tex
	@cp -u $(DOCUMENTSDIR)/Manual/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).pdf
	@cp -u $(DOCUMENTSDIR)/HgbThesisTutorialEN/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG)-tutorial-en.pdf
	@cp -u $(DOCUMENTSDIR)/HgbThesisTutorialDE/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG)-tutorial-de.pdf
#	Update version number in package README file:
	@echo "  updating version number in package README.md"
	@$(shell sed -i 's|$(READMEVERSIONTAG).*|$(READMEVERSIONTAG) $(RELEASEDATE)|' $(CTANDIR)/$(CTANPKG)/README.md)
#	Make a ZIP of the complete CTAN bundle:
	@echo "  ZIPing the complete CTAN bundle"
	@cd $(CTANDIR)/; rm -f $(CTANPKG).zip; $(ZIPEXE) -r -q $(CTANPKG).zip $(CTANPKG)



	
	
	