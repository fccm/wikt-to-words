WIKTIONARY_PATH = "https://dumps.wikimedia.org/enwiktionary/latest/"
WIKTIONARY_DUMP = "enwiktionary-latest-pages-articles.xml.bz2"

_LANG = English

OUT_DIR = /tmp/dictionaries
OUT_FILE = $(OUT_DIR)/$(_LANG)

XMLM_DIR = $(shell ocamlfind query xmlm)

all: to_words.opt $(WIKTIONARY_DUMP)
	mkdir -p $(OUT_DIR)
	cat $(WIKTIONARY_DUMP) | bzcat | \
	  ./to_words.opt "$(_LANG)" | \
	    sed -e 's! !\n!g' | sort | uniq > \
	      $(OUT_FILE)

to_words.opt: to_words.ml
	ocamlopt str.cmxa -I $(XMLM_DIR) xmlm.cmxa $< -o $@

$(WIKTIONARY_DUMP):
	wget "$(WIKTIONARY_PATH)$(WIKTIONARY_DUMP)"
