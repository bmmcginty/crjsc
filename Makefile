.PHONY: spec

CRYSTAL := $(shell which crystal)
CURRENT := $(shell pwd)
EXT := $(CURRENT)/src/ext
OUTPUT := $(CURRENT)/.build

all: ext spec
ext:
	$(MAKE) -C $(EXT)
spec:
	$(CRYSTAL) run --release $(CURRENT)/spec/all_spec.cr
