NAME=dar-differential-backup-mini-howto
CP=@cp
RM=rm
FORMATTER_HTML=rest2html
FORMATTER_HTML_OPTIONS=--embed-stylesheet --stylesheet-path style.css

.PHONY: all dist clean

all: $(NAME).en.html $(NAME).it.html $(NAME).es.html

pdf: $(NAME).en.pdf $(NAME).it.pdf $(NAME).es.pdf

ps: $(NAME).en.ps $(NAME).it.ps $(NAME).es.ps

$(NAME).%.html: source.%.txt
	$(FORMATTER_HTML) $(FORMATTER_HTML_OPTIONS) $< > $@

$(NAME).%.pdf: source.%.tex
	$(FORMATTER_HTML) $(FORMATTER_HTML_OPTIONS) $< > $@

$(NAME).%.pdf: $(NAME).%.dvi
	dvipdf $< $@

$(NAME).%.dvi: $(NAME).%.tex
	latex $<

$(NAME).en.tex: source.en.txt
	rest2latex --generator --language=en $< > $@

$(NAME).es.tex: source.es.txt
	rest2latex --generator --language=es $< > $@

$(NAME).it.tex: source.it.txt
	rest2latex --generator --language=it $< > $@

clean:
	$(RM) -f $(NAME).??.html *.bak *.bz2 $(NAME).??.pdf
	$(RM) -f $(NAME).??.toc $(NAME).??.dvi $(NAME).??.ps
	$(RM) -f $(NAME).??.aux $(NAME).??.tex $(NAME).??.out
	$(RM) -f $(NAME).??.log

H_VERSION = $(shell grep Rev: source.en.txt | awk '{print $$2}')
SRC_VERSION = $(shell grep Rev: source.en.txt | awk '{print $$4}')
BASENAME = $(NAME)-$(H_VERSION)-$(SRC_VERSION)

dist: all pdf
	$(RM) -fR dist
	mkdir dist
	@# Copy all the interesting files.
	$(CP) source.*.txt Makefile style.css dist
	$(CP) Makefile dist
	@# Now generate a changes log.
	svn update
	svn log > ChangeLog
	$(CP) ChangeLog dist
	@# Nice. Now package.
	$(RM) -fR $(BASENAME) $(BASENAME).tar.bz2
	mv dist $(BASENAME)
	arcdir -t tar.bz2 $(BASENAME)
	$(RM) -fR $(BASENAME)
	-mkdir ~/release
	mv $(NAME).??.pdf $(NAME).??.html $(BASENAME).tar.bz2 ~/release
	@echo Files in ~/release. Now update your web page!

add_words:
	cat source.en.txt |aspell list --lang=en |sort|uniq> tmp.txt
	-cat source.en.txt.ignored_words >> tmp.txt
	sort tmp.txt|uniq> source.en.txt.ignored_words
	rm tmp.txt
	svn diff source.en.txt.ignored_words

spell:
	aspell --lang=en create master ./.aspell.dic.source.en.txt < ./source.en.txt.ignored_words
	aspell check source.en.txt --lang=en --add-extra-dicts ./.aspell.dic.source.en.txt
