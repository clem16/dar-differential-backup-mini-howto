NAME=dar-differential-backup-mini-howto
CP=cp
RM=rm
FORMATTER=rest2html
FORMATTER_OPTIONS=--embed-stylesheet --stylesheet-path style.css

.PHONY: all dist clean

all: $(NAME).en.html $(NAME).it.html

$(NAME).%.html: source.%.txt
	$(FORMATTER) $(FORMATTER_OPTIONS) $< > $@

clean:
	$(RM) -f $(NAME).*.html *.bak *.bz2

H_VERSION = $(shell grep Rev: source.en.txt | awk '{print $$2}')
SRC_VERSION = $(shell grep Rev: source.en.txt | awk '{print $$4}')
BASENAME = $(NAME)-$(H_VERSION)-$(SRC_VERSION)

dist: all
	$(RM) -fR dist
	mkdir dist
	$(CP) source.*.txt dist
	$(CP) Makefile dist
	svn update
	svn log > ChangeLog
	$(CP) ChangeLog dist
	$(RM) -fR $(BASENAME) $(BASENAME).tar.bz2
	mv dist $(BASENAME)
	arcdir -t tar.bz2 $(BASENAME)
	$(RM) -fR $(BASENAME)
	-mkdir ~/release
	mv $(NAME).*.html $(BASENAME).tar.bz2 ~/release
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
