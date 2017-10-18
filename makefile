SHELL = /bin/sh

COMMONDIR = common
BUILDDIR = .
MKFILESUB = $(realpath makefile-subdir)

BUILDS = HgbArticle HgbInternshipReport HgbLabReportDE HgbLabReportEN HgbTermReport HgbThesisDE HgbThesisEN

all : $(BUILDS) commit
.PHONY : all $(BUILDS) commit

# ------------------------------------------------------------

HgbArticle :
	@echo "***** Making $@ *****"
	$(eval class = hgbarticle.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

HgbInternshipReport :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

HgbLabReportDE :
	@echo "***** Making $@ *****"
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

HgbLabReportEN :
	@echo "***** Making $@ *****"
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

HgbTermReport :
	@echo "***** Making $@ *****"
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

HgbThesisDE :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

HgbThesisEN :
	@echo "***** Making $@ *****"
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUB)

# ------------------------------------------------------------

commit :
	@echo "Performing GIT add/commit"
	-git add -v $(BUILDDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(BUILDDIR)/
	@echo GIT note: Commits need to be pushed to remote!


