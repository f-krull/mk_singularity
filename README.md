# mk_singularity

Makefile to build singularity images. Used for other projects

## Quick start

```
git clone https://github.com/LCBC-UiO/mk_singularity
cd mk_singularity
make
```

## Build a custom image

  * Add a new `Dockerfile_new-name`
  * Add `simg_modules := new-name` to `singularity/make_simg.mk`.  
    (Or define in calling Makefile)
  * Run `make prepare_offline_simg`

## Requirements

  * make
  * docker
  * singularity

## Offline mode (TSD)

Run
```
make prepare_offline_simg
```
Singularity images will be written to `singulariy/`.

## 

