# TODO: mulstistage build
FROM openfaas/of-watchdog:0.8.2 as watchdog

FROM ruby:3.2.0-slim-buster

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN apt-get update &&\
  apt-get install -qy --no-install-recommends build-essential

RUN mkdir -p /home/app/function

WORKDIR /home/app/function

RUN addgroup --system app &&\
    adduser --system --ingroup app app

RUN chown app:app -R /home/app

USER app

EXPOSE 8080

HEALTHCHECK --interval=2s CMD curl -f http://127.0.0.1:4567/healthcheck

ENV fprocess="ruby index.rb"
ENV upstream_url="http://127.0.0.1:4567"
ENV mode="http"
ENV APP_ENV="production"

CMD ["fwatchdog"]

COPY function/Gemfile .

RUN bundle install

COPY function .
