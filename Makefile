targets=thymio-vpl-tutorial-en.zip thymio-vpl-tutorial-de.zip
deps=$(wildcard */*/*.tex) $(wildcard images/*.png) $(wildcard programs/*.aesl) vpl.sty authors.txt

thymio-vpl-tutorial-%.pdf: docs/%/vpl.tex $(deps) Makefile build
	cd build/$* && TEXINPUTS=../../docs/$*:${TEXINPUTS} pdflatex ../../$<
	cd build/$* && TEXINPUTS=../../docs/$*:${TEXINPUTS} pdflatex ../../$<
	mv build/$*/vpl.pdf $@

thymio-vpl-tutorial-answers-%.pdf: answers/%/vpl-answers.tex $(deps) Makefile build
	cd build/$* && TEXINPUTS=../../answers/$*:${TEXINPUTS} pdflatex ../../$<
	cd build/$* && TEXINPUTS=../../answers/$*:${TEXINPUTS} pdflatex ../../$<
	mv build/$*/vpl-answers.pdf $@

thymio-vpl-tutorial-%.zip: thymio-vpl-tutorial-%.pdf thymio-vpl-tutorial-answers-%.pdf
	rm -f thymio-vpl-tutorial-$*.zip
	zip $@ $^ programs/*.aesl answers/*.aesl authors.txt
	cd readmes/$* && zip ../../$@ *

all:	$(targets)

clean: buildclean

build:
	mkdir -p build/en
	mkdir -p build/de

buildclean:
	rm -rf build *~ */*~ 

distclean: clean
	rm -f *.pdf $(targets)

.PHONY: clean buildclean distclean all dist
