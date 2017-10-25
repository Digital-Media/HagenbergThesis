SHELL = /bin/sh

PDFLATEX=pdflatex
LATEXFLAGS?=-interaction=nonstopmode -file-line-error
BIBTEX=biber
#IMAGEDIR=images
IMAGEDIR=.

#LATEXJOB=main

# Make does not offer a recursive wildcard function, so here's one (https://stackoverflow.com/a/12959694):
#rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
#TEXS := $(call rwildcard,./,*.tex)
#TEXS=$(wildcard *.tex) $(wildcard *.sty) $(wildcard *.cls)

# This is GOOD!!
JOBS := $(shell find * -maxdepth 0 -type d)

STYLES := $(shell find . -name "*.sty")
CLASSES := $(shell find . -name "*.cls")
TEXS := $(shell find . -name "*.tex")
BIBS := $(shell find . -name "*.bib")
PICS := $(shell find $(IMAGEDIR) -name "*.png" -or -name "*.pdf" -or -name "*.jpg")


all: HgbArticle HgbInternshipReport HgbLabReportDE HgbLabReportEN HgbTermReport HgbThesisDE HgbThesisEN HgbThesisTutorial Manual
.PHONY : all HgbArticle HgbInternshipReport HgbLabReportDE HgbLabReportEN HgbTermReport HgbThesisDE HgbThesisEN HgbThesisTutorial Manual clean listfiles

	
$(JOBS) : 
	@echo Running LaTeX on $@
	cd $@; 
	ls -l *.tex
	
#$(LATEXJOB).pdf: $(CLASSES) $(STYLES) $(TEXS) $(PICS) $(BIBS)
#	@echo Running LaTeX on $(LATEXJOB).tex
#	-$(PDFLATEX) $(LATEXFLAGS) $(LATEXJOB)
#	-$(BIBTEX) $(LATEXJOB)
#	-$(PDFLATEX) $(LATEXFLAGS) $(LATEXJOB)
#	-$(PDFLATEX) $(LATEXFLAGS) $(LATEXJOB)

clean:
	rm -rf *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.tps

listfiles:
	@echo "JOBS = " $(JOBS)
#	@echo tex files: $(TEXS)
#	@echo style files: $(STYLES)
#	@echo class files: $(CLASSES)
#	@echo bin files: $(BIBS)
#	@echo image files: $(PICS)