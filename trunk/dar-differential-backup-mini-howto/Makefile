NAME=dar-differential-backup-mini-howto

all: $(NAME).en.html

$(NAME).%.html: source.%.txt
	html.py $< > $@

clean:
	rm -f $(NAME).??.html
