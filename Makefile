NAME=dar-differential-backup-mini-howto
CP=@cp
RM=rm
FORMATTER_HTML=rst2html.py
FORMATTER_LATEX=rst2latex.py
FORMATTER_HTML_OPTIONS=--input-encoding=iso-8859-1 --embed-stylesheet --stylesheet-path style.css

.PHONY: all dist clean

all: $(NAME).en.html $(NAME).it.html $(NAME).es.html

pdf: $(NAME).en.pdf $(NAME).it.pdf $(NAME).es.pdf

ps: $(NAME).en.ps $(NAME).it.ps $(NAME).es.ps

# Strip svn specific keywords. Besides, they are localised into Spanish.
mini-howto.%.txt: source.%.txt
	sed -e "s#\$$Date: \([^(]*\)\(.*\)#\1#;s#\$$Rev: \([0-9]*\) \$$.*#\1)#" $< > $@

$(NAME).%.html: mini-howto.%.txt
	$(FORMATTER_HTML) $(FORMATTER_HTML_OPTIONS) $< > $@

$(NAME).%.pdf: mini-howto.%.tex
	$(FORMATTER_HTML) $(FORMATTER_HTML_OPTIONS) $< > $@

$(NAME).%.pdf: $(NAME).%.dvi
	dvipdf $< $@

$(NAME).%.dvi: $(NAME).%.tex
	latex $<

# We need separate rules for different languages.
$(NAME).en.tex: mini-howto.en.txt
	$(FORMATTER_LATEX) --generator --language=en $< > $@

$(NAME).es.tex: mini-howto.es.txt
	$(FORMATTER_LATEX) --generator --language=it $< > $@

$(NAME).it.tex: mini-howto.it.txt
	$(FORMATTER_LATEX) --generator --language=it $< > $@

clean:
	$(RM) -f $(NAME).??.html *.bak *.bz2 $(NAME).??.pdf
	$(RM) -f $(NAME).??.toc $(NAME).??.dvi $(NAME).??.ps
	$(RM) -f $(NAME).??.aux $(NAME).??.tex $(NAME).??.out
	$(RM) -f $(NAME).??.log mini-howto.??.txt

H_VERSION = $(shell grep Rev: source.en.txt | awk '{print $$2}')
SRC_VERSION = $(shell ./get_revision.sh)
BASENAME = $(NAME)-$(H_VERSION)-$(SRC_VERSION)

dist: all pdf
	$(RM) -fR dist
	mkdir dist
	@# Copy all the interesting files.
	$(CP) mini-howto.*.txt Makefile style.css dist
	$(CP) Makefile dist
	@# Now generate a changes log.
	svn update
	svn log > ChangeLog.Repository
	$(CP) ChangeLog.Repository dist
	@# Nice. Now package.
	$(RM) -fR $(BASENAME) $(BASENAME).tar.bz2
	mv dist $(BASENAME)
	arcdir -t tar.bz2 $(BASENAME)
	$(RM) -fR $(BASENAME)
	-mkdir ~/release
	mv $(NAME).??.pdf $(NAME).??.html $(BASENAME).tar.bz2 ~/release
	@for file in ~/release/*.??.html; do \
		sed -e "s#@#@@#g" $$file > $${file%html}htm && rm $$file; \
	done
	@echo Files in ~/release. Now update your web page!

add_words:
	cat source.en.txt |aspell list --lang=en |sort|uniq> tmp.txt
	-cat source.en.txt.ignored_words >> tmp.txt
	sort tmp.txt|uniq> source.en.txt.ignored_words
	rm tmp.txt
	svn diff source.en.txt.ignored_words
	cat source.es.txt |aspell list --lang=es |sort|uniq> tmp.txt
	-cat source.es.txt.ignored_words >> tmp.txt
	sort tmp.txt|uniq> source.es.txt.ignored_words
	rm tmp.txt
	svn diff source.es.txt.ignored_words

spell:
	aspell --lang=en create master ./.aspell.dic.source.en.txt < ./source.en.txt.ignored_words
	aspell check source.en.txt --lang=en --add-extra-dicts ./.aspell.dic.source.en.txt
	aspell --lang=es create master ./.aspell.dic.source.es.txt < ./source.es.txt.ignored_words
	aspell check source.es.txt --lang=es --add-extra-dicts ./.aspell.dic.source.es.txt
        
