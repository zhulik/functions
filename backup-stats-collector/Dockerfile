FROM ghcr.io/zhulik/fn-builder as builder

RUN apt-get update &&\
  apt-get install -qy --no-install-recommends build-essential wget

RUN wget -O- https://github.com/restic/restic/releases/download/v0.15.0/restic_0.15.0_linux_amd64.bz2 | bzip2 -d > /usr/bin/restic &&\
    chmod +x /usr/bin/restic

COPY function/Gemfile function/Gemfile.lock ./
RUN bundle install

FROM ghcr.io/zhulik/fn-base

COPY --from=builder /mnt/ .
COPY --from=builder /usr/bin/restic /usr/bin
COPY function .
USER app
