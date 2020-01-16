FROM library/ubuntu:bionic AS build

ENV LANG=C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        software-properties-common \
        apt-utils

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y \
        wget

RUN mkdir -p /build /rootfs/usr/lib/jvm
WORKDIR /build
RUN wget -O /build/java.tar.gz 'https://javadl.oracle.com/webapps/download/AutoDL?BundleId=241526_1f5b5a70bf22433b84d0e960903adac8'
RUN tar -xvf /build/java.tar.gz --no-same-owner -C /rootfs/usr/lib/jvm

WORKDIR /rootfs
RUN mkdir -p usr/bin \
 && rm -rf \
        usr/lib/jvm/*/bin/ControlPanel \
        usr/lib/jvm/*/bin/jcontrol \
        usr/lib/jvm/*/lib/deploy \
        usr/lib/jvm/*/lib/desktop \
        usr/lib/jvm/*/lib/fontconfig.RedHat.* \
        usr/lib/jvm/*/lib/fontconfig.SuSE.* \
        usr/lib/jvm/*/lib/fontconfig.Turbo.* \
        usr/lib/jvm/*/man \
        usr/lib/jvm/*/plugin \
        usr/lib/jvm/*/COPYRIGHT \
        usr/lib/jvm/*/LICENSE \
        usr/lib/jvm/*/README \
        usr/lib/jvm/*/THIRDPARTYLICENSEREADME-JAVAFX.txt \
        usr/lib/jvm/*/THIRDPARTYLICENSEREADME.txt \
        usr/lib/jvm/*/Welcome.html \
        usr/lib/jvm/*/release \
 && ls -1 usr/lib/jvm/*/bin/* | xargs -I % ln -s /% usr/bin/

WORKDIR /


FROM clover/java-common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
