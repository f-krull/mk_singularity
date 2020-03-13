include singularity/make_simg.mk

all: test_simg

.PHONY: clean
clean: clean_simg

.PHONY: prepare_offline
prepare_offline: prepare_offline_simg
