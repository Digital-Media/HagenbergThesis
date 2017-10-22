SHELL = /bin/sh

COMMONDIR = common
BUILDDIR = subrepos
MKFILESUB = $(realpath makefile-subdir)

CTANDIR = ctan/hgb


BUILDS = HgbArticle HgbInternshipReport HgbLabReportDE HgbLabReportEN HgbTermReport HgbThesisDE HgbThesisEN HgbThesisTutorial

all : $(BUILDS) commit
.PHONY : all $(BUILDS) ctan commit

# ------------------------------------------------------------

HgbArticle :
	@echo "***** Making $@ *****"
	$(eval class = hgbarticle.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbInternshipReport :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbLabReportDE :
	@echo "***** Making $@ *****"
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbLabReportEN :
	@echo "***** Making $@ *****"
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbTermReport :
	@echo "***** Making $@ *****"
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbThesisDE :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbThesisEN :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

HgbThesisTutorial :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $(BUILDDIR)/$@
	make -C $(BUILDDIR)/$@ -f $(MKFILESUB)

ctan :
	@echo "***** Making $@ *****"
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.cls $(CTANDIR)
	
# ------------------------------------------------------------

commit :
	@echo "Performing GIT add/commit"
	-git add -v $(BUILDDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(BUILDDIR)/
	@echo GIT note: Commits need to be pushed to remote!


