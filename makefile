SHELL = /bin/sh

COMMONDIR = common
#TEMPLATEDIR = templates
TEMPLATEDIR = .

TEMPLATES = article internship labreport thesis_DE thesis_EN
#TEMPLATES = HgbLatex-Article HgbLatex-InternshipReport HgbLatex-LabReport HgbLatex-ThesisDE HgbLatex-ThesisEN

#all : $(TEMPLATES) gitaddcommit
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
	$(eval dir=HgbLatex-Article)
	cp -u $(COMMONDIR)/*.sty $(dir);
	cp -u $(COMMONDIR)/hgbarticle.cls $(dir);

internship :
	@echo Making $@
	$(eval dir=HgbLatex-InternshipReport)
	cp -u $(COMMONDIR)/*.sty $(dir);
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir);

labreport :
	@echo Making $@
	$(eval dir=HgbLatex-LabReport)
	cp -u $(COMMONDIR)/*.sty $(dir);
	cp -u $(COMMONDIR)/hgbreport.cls $(dir);

thesis_DE :
	@echo Making $@
	$(eval dir=HgbLatex-ThesisDE)
	cp -u $(COMMONDIR)/*.sty $(dir);
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir);

thesis_EN :
	@echo Making $@
	$(eval dir=HgbLatex-ThesisEN)
	cp -u $(COMMONDIR)/*.sty $(dir);
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir);

# ------------------------------------------------------------

gitaddcommit :
	@echo "Performing GIT add/commit"
	-git add -v $(TEMPLATEDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(TEMPLATEDIR)/
	@echo GIT note: Commits need to be pushed to remote!
