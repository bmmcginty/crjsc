.PHONY: spec examples

CRYSTAL := $(shell which crystal)
CURRENT := $(shell pwd)
EXT := $(CURRENT)/src/ext
OUTPUT := $(CURRENT)/.build

all: ext spec
ext:
	$(MAKE) -C $(EXT)
spec:
	$(CRYSTAL) run --release $(CURRENT)/spec/all_spec.cr
examples:
	$(CRYSTAL) build -o $(CURRENT)/examples/file_interface --release $(CURRENT)/examples/file_interface.cr
	$(CURRENT)/examples/file_interface
