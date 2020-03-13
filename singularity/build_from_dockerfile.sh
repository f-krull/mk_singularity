#!/usr/bin/env bash

# This script documents how to build the singularity container
# from the Dockerfile

# exit on errors
set -ETeuo pipefail

declare BASEDIR; BASEDIR="$( cd "$( dirname $0 )" && pwd )"; readonly BASEDIR

in_dockerfile=$(readlink -f $1)
out_simg=$2


name=simg$( cat ${in_dockerfile} | md5sum | grep -o "^.\{7\}" )

# build docker container

pushd $BASEDIR
docker build -t ${name} -f ${in_dockerfile} .
popd

# docker registry server to host docker image locally
# do nothing if running, otherwise try to start registry or create registry
[ $(docker inspect -f '{{.State.Running}}' registry) == "true" ] \
  || docker container start registry \
  || docker run -d -p 5000:5000 --restart=always --name registry registry:2

# push image to local registry
docker tag ${name} localhost:5000/${name}
docker push localhost:5000/${name}

# build singularity image
rm -f ${out_simg}
SINGULARITY_NOHTTPS=1 singularity build ${out_simg} docker://localhost:5000/${name}:latest

# stop registry server
docker container stop registry
