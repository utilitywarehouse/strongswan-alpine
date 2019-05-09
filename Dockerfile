FROM alpine:latest

ENV STRONGSWAN_RELEASE https://download.strongswan.org/strongswan.tar.bz2

RUN apk add --no-cache ca-certificates ip6tables iproute2 libgcrypt gmp libgmpxx

RUN apk add --no-cache --virtual build-deps curl build-base iptables-dev libgcrypt-dev gmp-dev

RUN mkdir /tmp/strongswan
RUN curl -Lo /tmp/strongswan.tar.bz2 $STRONGSWAN_RELEASE
RUN tar --strip-components=1 -C /tmp/strongswan -xjf /tmp/strongswan.tar.bz2

WORKDIR /tmp/strongswan

RUN ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --libexecdir=/usr/lib \
        --with-ipsecdir=/usr/lib/strongswan \
        --enable-aesni \
        --enable-chapoly \
        --enable-cmd \
        --enable-dhcp \
        --enable-eap-dynamic \
        --enable-eap-identity \
        --enable-eap-md5 \
        --enable-eap-mschapv2 \
        --enable-eap-radius \
        --enable-eap-tls \
        --enable-farp \
        --enable-files \
        --enable-gcm \
        --enable-md4 \
        --enable-newhope \
        --enable-ntru \
        --enable-sha3 \
        --enable-shared \
        --enable-sha1 \
        --enable-aes \
        --enable-ikev1 \
        --disable-openssl \
        --disable-des \
        --enable-gmp \
        --enable-hmac \
        --disable-md5 \
        --enable-unity \
        --enable-curve25519 \
        --disable-rc2 \
        --disable-sha2 \
        --disable-static

RUN make && make install
RUN rm -rf /tmp/strong*
RUN apk del build-deps

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]