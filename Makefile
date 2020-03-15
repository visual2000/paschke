SHELL = /bin/bash

.PHONY: help
help:
	$(info Hello there!)

.PHONY: clean
clean:
	-rm win95_disk.img

.PHONY: check
check:
	shellcheck $(wildcard *.sh) $(wildcard lib/*.sh)

.PHONY: build
build:
	./paschke-build.sh

DISK = win95_disk.img
.PHONY: boot
boot: $(DISK)
	qemu-system-i386 \
	    -drive file=$<,format=raw \
	    -cpu pentium \
	    -m 100 \
	    -boot c \
	    -vga std \
	    -nic none
