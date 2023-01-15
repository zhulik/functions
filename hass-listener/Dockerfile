FROM ruby:3.2.0-slim as base

RUN adduser app
WORKDIR /mnt
RUN bundle config --local path vendor/bundle
EXPOSE 8080
HEALTHCHECK --interval=2s CMD curl -f http://127.0.0.1:4567/healthcheck

ENV fprocess="bundle exec ruby index.rb"
ENV upstream_url="http://127.0.0.1:4567"
ENV mode="http"
ENV APP_ENV="production"

CMD ["fwatchdog"]

FROM base as builder

RUN apt-get update &&\
  apt-get install -qy --no-install-recommends build-essential
COPY function/Gemfile .
RUN bundle install


FROM openfaas/of-watchdog:0.8.2 as watchdog
FROM base

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog
COPY --from=builder /mnt/ .
COPY function .
USER app
