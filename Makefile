
PREFIX = /usr/local
BIN = burl

install:
	cp -f bin/$(BIN) $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)

.PHONY: install uninstall