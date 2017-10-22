SHELL=/bin/sh

COMMONDIR=common
BUILDDIR=subrepos
SUBMKFILE=$(realpath makefile-subdir)

# LATEXJOB refers to the TEX file to compile (used by the sub-makefile)
LATEXJOB=main
export LATEXJOB

CTANDIR=ctan/hgb

BUILDS=HgbArticle HgbInternshipReport HgbLabReportDE HgbLabReportEN HgbTermReport HgbThesisDE HgbThesisEN HgbThesisTutorial

all : $(BUILDS) ctan
.PHONY : all $(BUILDS) ctan commit

# ------------------------------------------------------------

HgbArticle :
	@echo "***** Making $@ *****"
	$(eval class=hgbarticle.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbInternshipReport :
	@echo "***** Making $@ *****"
	$(eval class=hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbLabReportDE :
	@echo "***** Making $@ *****"
	$(eval class=hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbLabReportEN :
	@echo "***** Making $@ *****"
	$(eval class=hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbTermReport :
	@echo "***** Making $@ *****"
	$(eval class=hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbThesisDE :
	@echo "***** Making $@ *****"
	$(eval class=hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbThesisEN :
	@echo "***** Making $@ *****"
	$(eval class=hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

HgbThesisTutorial :
	@echo "***** Making $@ *****"
	$(eval class=hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(SUBMKFILE)

ctan :
	@echo "***** Making $@ *****"
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.cls $(CTANDIR)
	$(eval LATEXJOB=hgb)
	make -C $(CTANDIR) -f $(SUBMKFILE)
	
# ------------------------------------------------------------

commit :
	@echo "Performing GIT add/commit"
	-git add -v $(BUILDDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(BUILDDIR)/
	@echo GIT note: Commits need to be pushed to remote!


