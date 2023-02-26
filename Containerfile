# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15

FROM ghcr.io/awesome-containers/alpine-build-essential:3.17 AS build

# hadolint ignore=DL3018
RUN apk add --no-cache linux-headers

# https://ftp.gnu.org/gnu/openssl/
ARG OPENSSL_VERSION=3.0.8

WORKDIR /src/openssl
RUN set -xeu; \
    curl -#Lo openssl.tar.gz \
        "https://github.com/openssl/openssl/releases/download/openssl-$OPENSSL_VERSION/openssl-$OPENSSL_VERSION.tar.gz"; \
    tar -xvf openssl.tar.gz --strip-components=1; \
    rm -f openssl.tar.gz

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    ./config no-deprecated no-shared no-tests no-weak-ssl-ciphers -static; \
    perl configdata.pm -m; \
    make install_sw INSTALLTOP=./dist; \
    chmod -cR 755 dist/bin/openssl; \
    chown -cR 0:0 dist/bin/openssl; \
    ! ldd dist/bin/openssl && :; \
    ./dist/bin/openssl version

# static openssl image
FROM ghcr.io/awesome-containers/static-bash:$STATIC_BASH_VERSION

COPY --from=build /src/openssl/dist/bin/openssl /bin/openssl
ENV OPENSSL_CONF=/etc/openssl.cnf
COPY --from=build /src/openssl/apps/openssl.cnf /etc/openssl.cnf
ENV SSL_CERT_DIR=/etc/ssl/certs
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
