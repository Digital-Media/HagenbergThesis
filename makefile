# Local makefile to buld LaTeX examples in subdirectories.

SHELL = /bin/sh

MKFILELATEX=$(realpath makefile-latex)
EXAMPLES := $(shell cd examples; find * -maxdepth 0 -type d)
COMMONDIR=common
EXAMPLESDIR=examples
TMPDIR=tmpltx
ZIPEXEPATH := $(realpath bin/zip.exe)

DUMMYDATE := 9999\/01\/01
TODAY := $(shell date +"%Y\/%m\/%d")


# sed -i 's/9999\/01\/01/AbraKadabra/' hgb.sty

CTANDIR = ctan
CTANPKG = hagenberg-thesis

all : prepare build ctan
.PHONY : all prepare copytex setdates build ctan $(EXAMPLES) listexamples

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

listexamples:
	@echo "EXAMPLES = " $(EXAMPLES)

ctan :
	@echo "***** Making $@ *****"
	cp -u $(TMPDIR)/*.sty $(TMPDIR)/*.cls $(CTANDIR)/$(CTANPKG)/latex
	cp -u $(EXAMPLESDIR)/Manual/main.tex $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).tex
	cp -u $(EXAMPLESDIR)/Manual/main.pdf $(CTANDIR)/$(CTANPKG)/doc/$(CTANPKG).pdf
#	Copy the entire examples/ directory to ctan/hagenberg-thesis/, then remove all ZIP files
	cp -u -R $(EXAMPLESDIR) $(CTANDIR)/$(CTANPKG)
	find $(CTANDIR)/$(CTANPKG) -name "*.zip" -type f -delete
#	Make a ZIP of the complete ctan bundle:
	cd $(CTANDIR)/; rm -f $(CTANPKG).zip; $(ZIPEXEPATH) -r $(CTANPKG).zip $(CTANPKG)

	
	
	