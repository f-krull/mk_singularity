simg_modules ?= test

# simg_modules := \
# 	moas-r \
# 	moas-flask

all_simg: $(addprefix singularity/,  $(addsuffix .simg, $(simg_modules)))

# alias
prepare_offline_simg: all_simg

clean_simg:
	$(RM) singularity/*.simg

singularity/%.simg: singularity/Dockerfile_%
	singularity/build_from_dockerfile.sh $< $@

PHONY: test_simg
test_simg: $(addprefix test_,  $(addsuffix _simg, $(simg_modules)))

PHONY: test_%_simg
test_%_simg: singularity/%.simg
	@du -h $<
	@singularity exec $< bash -c 'cat /etc/issue'
