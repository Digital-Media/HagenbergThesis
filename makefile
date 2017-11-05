# Local makefile to buld LaTeX examples in subdirectories.
# -----------------------------------------------------------------------
# Usage (assuming a Linux-type shell, e.g. Git Bash on Windows):
# 'make' or 'make all' -> to rebuild everything
# 'make prepare' -> to copy *.sty and *.cls files to a tmp directory and set version dates
# 'make build' -> to build all example documents
# 'make <example>' -> to buld a specific example document, e.g. 'make HgbArticle'
# 'make ctan' -> to build the complete CTAN distribution
# -----------------------------------------------------------------------

SHELL = /bin/sh
TMPDIR = tmpltx
ZIPEXE := zip
MKFILELATEX := $(realpath makefile-latex)

COMMONDIR=common
EXAMPLESDIR=examples
EXAMPLES := $(shell cd $(EXAMPLESDIR); find * -maxdepth 0 -type d)

# Dummy date string in common/*.sty and *.cls files:
DUMMYDATE := 9999\/01\/01
TODAY := $(shell date +"%Y\/%m\/%d")
RELEASEDATE := $(TODAY)
# Specify a specific release date as 'yyyy\/mm\/dd' (default is TODAY):
#RELEASEDATE := 2017\/11\/28

CTANDIR = ctan
CTANPKG = hagenberg-thesis
# Dummy date line in ctan/hagenberg-thesis/README.md starts with "### Version:"
READMEVERSIONTAG=\#\#\# Version:

### -----------------------------------------------------------------

all : prepare build ctan
.PHONY : all prepare copytex setdates build ctan $(EXAMPLES)

prepare : copytex setdates

copytex :
	@echo Copying sty/cls files to $(TMPDIR)/
	mkdir -p $(TMPDIR)
	cp -f $(COMMONDIR)/*.sty $(COMMONDIR)/*.cls $(COMMONDIR)/*.bib $(TMPDIR)

setdates :
	@echo Replacing dummy dates in sty/cls files by $(RELEASEDATE)
	$(eval LTXFILES := $(shell find $(TMPDIR)/ -name "*.sty" -or -name "*.cls" -type f))
#	@echo "LTXFILES: " $(LTXFILES)
#	Replace the dummy date '9999/01/01' in all examples/ *.cls and *.sty files#
	$(foreach FILE, $(LTXFILES), $(shell sed -i 's/$(DUMMYDATE)/$(RELEASEDATE)/' $(FILE)))

build : $(EXAMPLES)

$(EXAMPLES) : 
	@echo Running LaTeX on $@
	cp -u $(TMPDIR)/*.* $(EXAMPLESDIR)/$@
#	Run the LaTeX build in a sub-makefile:
	make -C $(EXAMPLESDIR)/$@ -f $(MKFILELATEX)
#	Make a ZIP for importing to Overleaf:
	cd $(EXAMPLESDIR)/; rm -f $@.zip; $(ZIPEXE) -r $@.zip $@

ctan :
	@echo "***** Making $@ *****"
#	Copy all .sty and .cls files to ctan/hagenberg-thesis/latex/
	cp -u $(TMPDIR)/*.sty $(TMPDIR)/*.cls $(CTANDIR)/$(CTANPKG)/latex
#	Copy the entire examples/ directory to ctan/hagenberg-thesis/
	cp -u -R $(EXAMPLESDIR) $(CTANDIR)/$(CTANPKG)
#	Remove all .sty and .cls files in ctan/examples/ (recursively):
	find $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/ -name "*.sty" -type f -delete
	find $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/ -name "*.cls" -type f -delete
#	Remove all top-level ZIP files in ctan/examples/:
	find $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/ -maxdepth 1 -name "*.zip" -type f -delete
#	Copy manual/tutorial source and PDF to ctan/hagenberg-thesis/doc/
	cp -u $(EXAMPLESDIR)/Manual/main.tex $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).tex
	cp -u $(EXAMPLESDIR)/Manual/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).pdf
	cp -u $(EXAMPLESDIR)/HgbThesisTutorial/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG)-tutorial.pdf
#	Update version number in package README file:
	$(shell sed -i 's/$(READMEVERSIONTAG).*/$(READMEVERSIONTAG) $(RELEASEDATE)/' $(CTANDIR)/$(CTANPKG)/README.md)
#	Make a ZIP of the complete ctan bundle:
	cd $(CTANDIR)/; rm -f $(CTANPKG).zip; $(ZIPEXE) -r $(CTANPKG).zip $(CTANPKG)



	
	
	