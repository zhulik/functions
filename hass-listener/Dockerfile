FROM openfaas/of-watchdog:0.8.2 as watchdog
FROM ruby:3.2.0-slim as base

WORKDIR /mnt

RUN adduser --system app &&\
    bundle config --local path vendor/bundle &&\
    bundle config set --local deployment 'true' &&\
    bundle config set --local without 'development test'

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

EXPOSE 8080
HEALTHCHECK --interval=2s CMD curl -f http://127.0.0.1:4567/healthcheck

ENV fprocess="bundle exec falcon serve -b http://0.0.0.0 -p 4567"
ENV upstream_url="http://127.0.0.1:4567"
ENV mode="http"
ENV APP_ENV="production"

CMD ["fwatchdog"]

FROM base as builder

RUN apt-get update &&\
  apt-get install -qy --no-install-recommends build-essential

COPY function/Gemfile function/Gemfile.lock ./
RUN bundle install

FROM base

COPY --from=builder /mnt/ .
COPY function .
USER app
