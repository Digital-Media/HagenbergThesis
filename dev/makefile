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
SOURCEDIR=latex
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
#	Replaces any date of the form [yyyy/mm/dd] in *.cls and *.sty files:
	@echo Updating release date in all sty/cls files by [$(RELEASEDATE)]
	$(shell sed -i 's/$(DATEPATTERN)/\[$(RELEASEDATE)\]%%AUTO/' $(SOURCEDIR)/*.sty $(SOURCEDIR)/*.cls)

build : $(EXAMPLES)
#	Defines a make target for each directory name in EXAMPLES

$(EXAMPLES) : 
#	Builds and zips every document (directory) in EXAMPLES
	@echo Running LaTeX on $@
#	Copy all .sty .cls *.bib files to the example directory:
	cp -u $(SOURCEDIR)/*.sty $(DOCUMENTSDIR)/$@
	cp -u $(SOURCEDIR)/*.cls $(DOCUMENTSDIR)/$@
	cp -u $(SOURCEDIR)/*.bib $(DOCUMENTSDIR)/$@
#	Run the LaTeX build in a sub-makefile:
	make -C $(DOCUMENTSDIR)/$@ -f $(MKFILELATEX)
#	Make a ZIP for importing to Overleaf:
	cd $(DOCUMENTSDIR)/; rm -f $@.zip; $(ZIPEXE) -r $@.zip $@

ctan :
#	Builds the CTAN distribution
	@echo "***** Making $@ *****"
#	Copy all .sty and .cls files to ctan/hagenberg-thesis/latex/
	cp -u $(SOURCEDIR)/*.sty $(SOURCEDIR)/*.cls $(CTANDIR)/$(CTANPKG)/latex
#	Copy the entire documents/ directory to ctan/hagenberg-thesis/
	cp -u -R $(DOCUMENTSDIR)/* $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)
#	Rename ..documents/ to ..examples/
#	mv $(CTANDIR)/$(CTANPKG)/$(DOCUMENTSDIR) $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)
#	Remove all .sty and .cls files in ctan/hagenberg-thesis/examples/ (recursively):
	find $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/ -name "*.sty" -type f -delete
	find $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/ -name "*.cls" -type f -delete
#	Remove all top-level ZIP files in ctan/hagenberg-thesis/examples/:
	find $(CTANDIR)/$(CTANPKG)/$(CTANEXAMPLES)/ -maxdepth 1 -name "*.zip" -type f -delete
#	Copy manual/tutorial source and PDF to ctan/hagenberg-thesis/doc/
	cp -u $(DOCUMENTSDIR)/Manual/main.tex $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).tex
	cp -u $(DOCUMENTSDIR)/Manual/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).pdf
	cp -u $(DOCUMENTSDIR)/HgbThesisTutorial/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG)-tutorial.pdf
#	Update version number in package README file:
	$(shell sed -i 's/$(READMEVERSIONTAG).*/$(READMEVERSIONTAG) $(RELEASEDATE)/' $(CTANDIR)/$(CTANPKG)/README.md)
#	Make a ZIP of the complete ctan bundle:
	cd $(CTANDIR)/; rm -f $(CTANPKG).zip; $(ZIPEXE) -r $(CTANPKG).zip $(CTANPKG)



	
	
	