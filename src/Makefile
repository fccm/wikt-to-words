.PHONY: indonesian
indonesian:
	$(MAKE) -f to_words.mk \
	    WIKTIONARY_DUMP="enwiktionary-latest-pages-articles.xml.bz2" \
	    OUT_FILE="/tmp/dictionaries/indonesian" \
	    _LANG="Indonesian"

.PHONY: greek
greek:
	$(MAKE) -f to_words.mk \
	    WIKTIONARY_DUMP="elwiktionary-latest-pages-articles.xml.bz2" \
	    OUT_FILE="/tmp/dictionaries/greek" \
	    _LANG="Ελληνικά"

clean:
	$(RM) *.cm[ix] *.o *.opt
