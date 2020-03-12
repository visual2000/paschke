SHELL = /bin/bash

.PHONY: help
help:
	$(info Hello there!)

.PHONY: clean
clean:
	-rm win95_disk.img

.PHONY: check
check:
	shellcheck $(wildcard *.sh)

.PHONY: build
build:
	./paschke-build.sh
