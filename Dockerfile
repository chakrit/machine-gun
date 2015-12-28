#!/usr/local/bin/docker
FROM alpine
RUN apk add --update \
  build-base \
  bash \
  git \
  ruby \
  ruby-dev \
  ruby-irb \
  ruby-rdoc \
  libffi-dev \
  go
RUN gem install \
  io-console \
  bundler \
  ffi
