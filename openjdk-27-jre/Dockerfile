FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/common:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN rm -rf \
    etc/X11 \
    etc/ca-certificates \
    etc/default \
    etc/fonts/conf.d/README \
    etc/pam.d \
    etc/sensors.d/.placeholder \
    usr/bin/X11 \
    usr/include \
    usr/lib/X11 \
    usr/lib/jvm/*/docs \
    usr/lib/jvm/*/legal \
    usr/lib/jvm/*/man \
    usr/lib/mime \
    usr/lib/systemd \
    usr/sbin/update-* \
    usr/share/X11 \
    usr/share/application-registry \
    usr/share/applications \
    usr/share/bash* \
    usr/share/bug \
    usr/share/doc \
    usr/share/doc-base \
    usr/share/gdb \
    usr/share/icons \
    usr/share/java \
    usr/share/lintian \
    usr/share/locale \
    usr/share/man \
    usr/share/mime-info \
    usr/share/pixmaps \
    usr/share/pkgconfig \
    usr/share/util-linux \
    usr/share/zsh* \
 && sed -i -E \
        -e 's,^[[:space:]]*[#].*$,,g' \
        -e '/^[[:space:]]*$/d' \
        etc/gtk-3.0/*.conf \
        etc/java-*/management/* \
        etc/java-*/security/*.security \
        etc/java-*/*.ja \
        etc/java-*/*.properties \
        etc/sensors3.conf \
 && sed -i -E -z \
        -e 's,<!--([^-]*|-[^-]|--[^>])*-->,,g' \
        -e 's/[[:space:]]+\n/\n/g' \
        -e 's/\n\n+/\n/g' \
        etc/fonts/conf.avail/*.conf \
        etc/fonts/fonts.conf \
        etc/java-*/jfr/*.jfc \
        usr/share/fontconfig/conf.avail/*.conf \
        usr/share/xml/fontconfig/fonts.dtd \
        usr/share/drirc.d/*.conf \
 && find usr/lib/jvm/java-27-openjdk-*/bin usr/lib/jvm/java-27-openjdk-*/lib/jexec -type f -perm -111 -exec ln -sf /{} usr/bin/ ';'

WORKDIR /

FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
