FROM ghcr.io/zhulik/fn-builder as builder

COPY function/Gemfile function/Gemfile.lock ./
RUN bundle install

FROM ghcr.io/zhulik/fn-base

RUN wget -O- https://github.com/restic/restic/releases/download/v0.15.0/restic_0.15.0_linux_amd64.bz2 | bzip2 -d > /usr/bin/restic &&\
    chmod +x /usr/bin/restic

COPY --from=builder /mnt/ .
COPY function .
USER app
