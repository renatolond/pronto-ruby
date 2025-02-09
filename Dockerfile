FROM ruby:3.3

LABEL maintainer="QAWAII <info@apptweak.com>"
LABEL org.opencontainers.image.source https://github.com/apptweak/pronto-ruby

ARG BUNDLER_VERSION="2.6.3"
ARG NODE_VERSION=14

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  cmake \
  curl \
  git \
  pkg-config \
  openssl \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler --version "${BUNDLER_VERSION}"

WORKDIR /runner

COPY Gemfile* ./

RUN bundle --retry 4

ENV BUNDLE_GEMFILE /runner/Gemfile

COPY . ./

WORKDIR /data

ENTRYPOINT ["/runner/pronto"]
