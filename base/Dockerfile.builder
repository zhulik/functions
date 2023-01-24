FROM ghcr.io/zhulik/fn-base:latest

RUN apt-get update &&\
  apt-get install -qy --no-install-recommends build-essential

COPY function/Gemfile function/Gemfile.lock ./
RUN bundle install
