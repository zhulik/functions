FROM ghcr.io/openfaas/classic-watchdog:0.2.1 as watchdog
FROM ruby:alpine

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN apk --no-cache add gcc

WORKDIR /home/app

COPY function  function

RUN mkdir -p /home/app/function

WORKDIR /home/app/function

RUN bundle install

RUN addgroup -S app \
  && adduser app -S -G app

RUN chown app:app -R /home/app

USER app

WORKDIR /home/app/function

ENV fprocess="ruby handler.rb"
EXPOSE 8080

ENV upstream_url="http://127.0.0.1:5000"
ENV mode="http"

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
