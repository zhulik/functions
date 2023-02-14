FROM ghcr.io/zhulik/fn-base:latest

RUN apk update &&\
  apk add --no-cache alpine-sdk wget

COPY Gemfile Gemfile.lock ./
RUN bundle install
