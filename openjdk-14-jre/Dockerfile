FROM library/ubuntu:focal AS build

ENV LANG=C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        --no-install-recommends \
        software-properties-common \
        apt-utils

RUN export DEBIAN_FRONTEND=noninteractive \
 && add-apt-repository ppa:openjdk-r/ppa

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN apt-get download \
        openjdk-14-jre \
        openjdk-14-jre-headless

RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN mkdir -p usr/bin \
 && rm -rf \
        usr/lib/debug \
        usr/lib/jvm/.*.jinfo \
        usr/lib/jvm/*/man \
        usr/lib/jvm/*/release \
        usr/lib/jvm/*/legal \
        usr/lib/jvm/*/docs \
        usr/lib/jvm/*/jre/man \
        usr/lib/jvm/*/jre/ASSEMBLY_EXCEPTION \
        usr/lib/jvm/*/jre/THIRD_PARTY_README \
        usr/share \
 && ls -1 usr/lib/jvm/java-14-openjdk-*/bin/* | xargs -I % ln -s /% usr/bin/ \
 && echo "-server KNOWN\n-client IGNORE" > $(ls -1 etc/java*/jvm-*.cfg)

WORKDIR /


FROM clover/java-common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
