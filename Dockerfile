FROM        alpine:3.2
MAINTAINER  Steve Durrheimer <s.durrheimer@gmail.com>

ENV GLIBC_VERSION="2.25-r1"

# https://github.com/gliderlabs/docker-alpine/issues/11
RUN \
    apk add --update -t deps wget ca-certificates \
    && cd /tmp \
    && wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
    && apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib/ \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && apk del --purge deps \
    && rm /tmp/* /var/cache/apk/*
