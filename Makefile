# Makefile for compiling resumes (RU & EN)

ENGINE    ?= lualatex
BUILD_DIR ?= build
PUB_DIR   ?= publish
LATEXMK   := latexmk -$(ENGINE) -outdir=$(BUILD_DIR) -interaction=nonstopmode

.PHONY: all ru en publish clean distclean help

all: publish

ru: $(BUILD_DIR)/resume_ru.pdf
	@mkdir -p $(PUB_DIR)
	cp $(BUILD_DIR)/resume_ru.pdf $(PUB_DIR)/resume_ru.pdf
	@echo "Built Russian resume: $(PUB_DIR)/resume_ru.pdf"

en: $(BUILD_DIR)/resume.pdf
	@mkdir -p $(PUB_DIR)
	cp $(BUILD_DIR)/resume.pdf $(PUB_DIR)/resume.pdf
	@echo "Built English resume: $(PUB_DIR)/resume.pdf"

$(BUILD_DIR)/resume_ru.pdf: resume_ru.tex header/header.tex
	@mkdir -p $(BUILD_DIR)
	$(LATEXMK) resume_ru.tex

$(BUILD_DIR)/resume.pdf: resume.tex header/header.tex
	@mkdir -p $(BUILD_DIR)
	$(LATEXMK) resume.tex

publish: $(BUILD_DIR)/resume_ru.pdf $(BUILD_DIR)/resume.pdf
	@mkdir -p $(PUB_DIR)
	cp $(BUILD_DIR)/resume_ru.pdf $(PUB_DIR)/resume_ru.pdf
	cp $(BUILD_DIR)/resume.pdf $(PUB_DIR)/resume.pdf
	@echo "Published to $(PUB_DIR)/:"
	@echo "  - $(PUB_DIR)/resume_ru.pdf"
	@echo "  - $(PUB_DIR)/resume.pdf"

clean:
	@echo "Cleaning auxiliary build files..."
	@latexmk -outdir=$(BUILD_DIR) -c resume.tex resume_ru.tex 2>/dev/null || true

distclean:
	@echo "Removing build directory..."
	@rm -rf $(BUILD_DIR)

help:
	@echo "Available targets:"
	@echo "  make (or make all) - Build both versions and copy to publish/"
	@echo "  make ru            - Build Russian resume and copy to publish/resume_ru.pdf"
	@echo "  make en            - Build English resume and copy to publish/resume.pdf"
	@echo "  make publish       - Explicitly build and publish both PDFs"
	@echo "  make clean         - Remove LaTeX auxiliary files (.aux, .log, .fls, etc.)"
	@echo "  make distclean     - Remove the entire build/ directory"
	@echo "  make help          - Show this help message"
