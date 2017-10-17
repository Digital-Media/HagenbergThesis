SHELL = /bin/sh

COMMONDIR = common
BUILDDIR = .

BUILDS = article internship labreport thesisDE thesisEN
#BUILDS = HgbLatex-Article HgbLatex-InternshipReport HgbLatex-LabReport HgbLatex-ThesisDE HgbLatex-ThesisEN


all : $(BUILDS) gitaddcommit
.PHONY : all dummy

# ------------------------------------------------------------

article :
	@echo Making $@
	$(eval dir=HgbLatex-Article)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbarticle.cls $(dir)
	make -C $(dir)

internship :
	@echo Making $@
	$(eval dir=HgbLatex-InternshipReport)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir)
	make -C $(dir)

labreport :
	@echo Making $@
	$(eval dir=HgbLatex-LabReport)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbreport.cls $(dir)
	make -C $(dir)

thesisDE :
	@echo Making $@
	$(eval dir=HgbLatex-ThesisDE)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir)
	make -C $(dir)

thesisEN :
	@echo Making $@
	$(eval dir=HgbLatex-ThesisEN)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir)
	make -C $(dir)

# ------------------------------------------------------------

gitaddcommit :
	@echo "Performing GIT add/commit"
	-git add -v $(BUILDDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(BUILDDIR)/
	@echo GIT note: Commits need to be pushed to remote!


