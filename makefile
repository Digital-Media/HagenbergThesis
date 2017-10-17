SHELL = /bin/sh

COMMONDIR = common
TEMPLATEDIR = templates

#TEMPLATES = article internship labreport thesis_DE thesis_EN
TEMPLATES = HgbLatex-Article

all : $(TEMPLATES) gitaddcommit
.PHONY : all

#copystyles :
#	@echo "Updating *.sty files"
#	for dir in $(TEMPLATES); do \
#		echo copying $(COMMONDIR)/"*.sty" to $(TEMPLATEDIR)/$$dir : \
#		cp -u $(COMMONDIR)/*.sty $(TEMPLATEDIR)/$$dir; \
#	done;

# ------------------------------------------------------------

article :
	@echo Making $@
	cp -u $(COMMONDIR)/*.sty $(TEMPLATEDIR)/$@;
	cp -u $(COMMONDIR)/hgbarticle.cls $(TEMPLATEDIR)/$@

internship :
	@echo Making $@
	cp -u $(COMMONDIR)/*.sty $(TEMPLATEDIR)/$@;
	cp -u $(COMMONDIR)/hgbthesis.cls $(TEMPLATEDIR)/$@

labreport :
	@echo Making $@
	cp -u $(COMMONDIR)/*.sty $(TEMPLATEDIR)/$@;
	cp -u $(COMMONDIR)/hgbreport.cls $(TEMPLATEDIR)/$@

thesis_DE :
	@echo Making $@
	cp -u $(COMMONDIR)/*.sty $(TEMPLATEDIR)/$@;
	cp -u $(COMMONDIR)/hgbthesis.cls $(TEMPLATEDIR)/$@

thesis_EN :
	@echo Making $@
	cp -u $(COMMONDIR)/*.sty $(TEMPLATEDIR)/$@;
	cp -u $(COMMONDIR)/hgbthesis.cls $(TEMPLATEDIR)/$@

# ------------------------------------------------------------

gitaddcommit :
	@echo "Performing GIT add/commit"
	-git add -v $(TEMPLATEDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(TEMPLATEDIR)/
	@echo GIT note: Commits need to be pushed to remote!
