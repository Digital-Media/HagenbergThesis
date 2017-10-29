# Local makefile to buld LaTeX examples in subdirectories.

# Usage (assuming a Linux-type shell, e.g. Git Bash on Windows):
# 'make' or 'make all' -> to rebuild everything
# 'make prepare' -> to copy *.sty and *.cls files to a tmp directory and set versiondates
# 'make build' -> to buld all example documents
# 'make <example>' -> to buld a specific example document, e.g. 'make HgbArticle'
# 'make ctan' -> to assemble the complete CTAN package bundle

SHELL = /bin/sh

MKFILELATEX=$(realpath makefile-latex)
EXAMPLES := $(shell cd examples; find * -maxdepth 0 -type d)
COMMONDIR=common
EXAMPLESDIR=examples
TMPDIR=tmpltx
ZIPEXEPATH := $(realpath bin/zip.exe)

DUMMYDATE := 9999\/01\/01
TODAY := $(shell date +"%Y\/%m\/%d")

CTANDIR = ctan
CTANPKG = hagenberg-thesis
READMEVERSIONTAG=\#\#\# Version:

all : prepare build ctan
.PHONY : all prepare copytex setdates build ctan $(EXAMPLES)

prepare : copytex setdates

copytex :
	@echo Copying sty/cls files to $(TMPDIR)/
	mkdir -p $(TMPDIR)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.cls $(COMMONDIR)/*.bib $(TMPDIR)

setdates :
	@echo Replacing date entries in sty/cls files
	$(eval LTXFILES := $(shell find $(TMPDIR)/ -name "*.sty" -or -name "*.cls" -type f))
#	@echo "LTXFILES: " $(LTXFILES)
#	Replace the dummy date '9999/01/01' in all examples/ *.cls and *.sty files#
	$(foreach FILE, $(LTXFILES), $(shell sed -i 's/$(DUMMYDATE)/$(TODAY)/' $(FILE)))

	
build : $(EXAMPLES)

$(EXAMPLES) : 
	@echo Running LaTeX on $@
	cp -u $(TMPDIR)/*.* $(EXAMPLESDIR)/$@
#	Run the LaTeX build in a sub-makefile:
	make -C $(EXAMPLESDIR)/$@ -f $(MKFILELATEX)
#	Make a ZIP for importing to Overleaf:
	cd $(EXAMPLESDIR)/; rm -f $@.zip; $(ZIPEXEPATH) -r $@.zip $@

ctan :
	@echo "***** Making $@ *****"
	cp -u $(TMPDIR)/*.sty $(TMPDIR)/*.cls $(CTANDIR)/$(CTANPKG)/latex
#	Copy manual source and PDF to doc/
	cp -u $(EXAMPLESDIR)/Manual/main.tex $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).tex
	cp -u $(EXAMPLESDIR)/Manual/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).pdf
#	Copy tutorial PDF (only) to doc/
#	cp -u $(EXAMPLESDIR)/HgbThesisTutorial/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG)-tutorial.pdf
#	Copy the entire examples/ directory to ctan/hagenberg-thesis/
	cp -u -R $(EXAMPLESDIR) $(CTANDIR)/$(CTANPKG)
	rm -rf $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/Manual
#	Remove all .sty and .cls files:
	find $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/ -name "*.sty" -type f -delete
	find $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/ -name "*.cls" -type f -delete
#	Remove all top-level ZIP files:
	find $(CTANDIR)/$(CTANPKG)/$(EXAMPLESDIR)/ -maxdepth 1 -name "*.zip" -type f -delete
#	Update version number in package README file:
	$(shell sed -i 's/$(READMEVERSIONTAG).*/$(READMEVERSIONTAG) $(TODAY)/' $(CTANDIR)/$(CTANPKG)/README.md)
#	Make a ZIP of the complete ctan bundle:
	cd $(CTANDIR)/; rm -f $(CTANPKG).zip; $(ZIPEXEPATH) -r $(CTANPKG).zip $(CTANPKG)



	
	
	