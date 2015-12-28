#!/bin/sh

# osx
go build -v -buildmode=c-shared -o lib/darwin/x86_64/machine-gun.so src/*.go

# linux (via docker/centos)
docker build -t machine-gun-builder .
docker run --rm --name machine-gun-build \
  -v "$PWD":/work \
  -w /work \
  machine-gun-builder \
  go build -v -buildmode=c-shared -o lib/linux/x86_64/machine-gun.so src/*.go
