FROM ruby:3.2.8-slim

LABEL maintainer="Josh Bielick <jbielick@adwerx.com>"

ARG BUNDLER_VERSION="2.6.6"

RUN apt-get update && apt-get install -y curl

RUN apt-get update && \
  apt-get install -y \
  ruby-dev \
  build-essential \
  cmake \
  git \
  pkg-config \
  openssl \
  libgit2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler --version "${BUNDLER_VERSION}"

WORKDIR /runner

COPY Gemfile* ./

RUN bundle --retry 4

ENV BUNDLE_GEMFILE=/runner/Gemfile

COPY . ./

WORKDIR /data

ENTRYPOINT ["/runner/pronto"]
