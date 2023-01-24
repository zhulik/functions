FROM ghcr.io/zhulik/fn-builder as builder

COPY function/Gemfile function/Gemfile.lock ./
RUN bundle install

FROM ghcr.io/zhulik/fn-base

COPY --from=builder /mnt/ .
COPY function .
USER app
