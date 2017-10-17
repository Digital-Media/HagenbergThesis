SHELL = /bin/sh

COMMONDIR = common
BUILDDIR = .

MKFILESUBDIR = $(realpath makefile-subdir)


#BUILDS = article internship labreportDE labreportEN thesisDE thesisEN
BUILDS = HgbArticle HgbInternshipReport HgbLabReportDE HgbLabReportEN HgbThesisDE HgbThesisEN


all : $(BUILDS) commit
.PHONY : all $(BUILDS) commit

# ------------------------------------------------------------

HgbArticle :
#	@echo Making $@
	$(eval class = hgbarticle.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUBDIR)

HgbInternshipReport :
#	@echo Making $@
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUBDIR)

HgbLabReportDE :
#	@echo Making $@
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUBDIR)

HgbLabReportEN :
#	@echo Making $@
	$(eval class = hgbreport.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUBDIR)

HgbThesisDE :
#	@echo Making $@
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUBDIR)

HgbThesisEN :
#	@echo Making $@
	$(eval class = hgbthesis.cls)
	cp -u $(COMMONDIR)/*.sty $(COMMONDIR)/*.bib $(COMMONDIR)/$(class) $@
	make -C $@ -f $(MKFILESUBDIR)

# ------------------------------------------------------------

commit :
	@echo "Performing GIT add/commit"
	-git add -v $(BUILDDIR)/
	-git commit -m "LaTeX style and class files updated" -v $(BUILDDIR)/
	@echo GIT note: Commits need to be pushed to remote!


