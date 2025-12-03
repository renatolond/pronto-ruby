FROM ruby:3.4.7

LABEL maintainer="Devex <info@apptweak.com>"
LABEL org.opencontainers.image.source="https://github.com/apptweak/pronto-ruby"

ARG BUNDLER_VERSION="2.7.2"

RUN apt-get update && apt-get install -y curl

RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  ruby-dev \
  build-essential \
  cmake \
  git \
  pkg-config \
  openssl \
  libssl-dev \
  libzstd-dev \
  libz-dev \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler --version "${BUNDLER_VERSION}"

WORKDIR /runner

COPY Gemfile* .bundle ./

RUN bundle install --retry 4

ENV BUNDLE_GEMFILE=/runner/Gemfile

COPY . ./

WORKDIR /data

ENTRYPOINT ["/runner/pronto"]
