FROM openfaas/of-watchdog:0.8.1 as watchdog

FROM ruby:3.2.0-slim-buster

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

ARG ADDITIONAL_PACKAGE
RUN apt-get update &&\
  apt-get install -qy --no-install-recommends build-essential

RUN mkdir -p /home/app/function

WORKDIR /home/app/function

COPY function .

RUN bundle install

RUN addgroup --system app &&\
    adduser --system --ingroup app app

RUN chown app:app -R /home/app

USER app

ENV fprocess="ruby handler.rb"
EXPOSE 8080

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

ENV upstream_url="http://127.0.0.1:4567"
ENV mode="http"

CMD ["fwatchdog"]