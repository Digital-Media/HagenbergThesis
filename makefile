SHELL = /bin/sh

COMMONDIR = common
BUILDDIR = .

MKFILESUBDIR = $(realpath makefile-subdir)


#BUILDS = article internship labreportDE labreportEN thesisDE thesisEN
BUILDS = HgbLatex_Article HgbLatex-InternshipReport HgbLatex-LabReportDE HgbLatex-LabReportEN HgbLatex-ThesisDE HgbLatex-ThesisEN


all : $(BUILDS) commit
.PHONY : all commit

# ------------------------------------------------------------

HgbLatex_Article :
	@echo Making $@
	$(eval dir = HgbLatex-Article)
	$(eval class = hgbarticle.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(dir)
	make -C $(dir) -f $(MKFILESUBDIR)

HgbLatex-InternshipReport :
	@echo Making $@
	$(eval dir=HgbLatex-InternshipReport)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir)
	make -C $(dir)

HgbLatex-LabReportDE :
	@echo Making $@
	$(eval dir=HgbLatex-LabReportDE)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbreport.cls $(dir)
	make -C $(dir)

HgbLatex-LabReportEN :
	@echo Making $@
	$(eval dir=HgbLatex-LabReportEN)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbreport.cls $(dir)
	make -C $(dir)

HgbLatex-ThesisDE :
	@echo Making $@
	$(eval dir=HgbLatex-ThesisDE)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir)
	make -C $(dir)

HgbLatex-ThesisEN :
	@echo Making $@
	$(eval dir=HgbLatex-ThesisEN)
	cp -u $(COMMONDIR)/*.sty $(dir)
	cp -u $(COMMONDIR)/hgbthesis.cls $(dir)
	make -C $(dir)

# ------------------------------------------------------------

commit :
	@echo "Performing GIT add/commit"
	-git add -v $(BUILDDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(BUILDDIR)/
	@echo GIT note: Commits need to be pushed to remote!


