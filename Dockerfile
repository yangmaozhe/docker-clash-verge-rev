FROM ghcr.io/azicen/debian-desktop:latest

ARG TARGETARCH
ARG VERSION

ENV TITLE="Clash Verge"

ADD https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v$VERSION/Clash.Verge_$VERSION_$TARGETARCH.deb /tmp/clash-verge.deb

RUN apt update && \
    apt install -y --no-install-recommends \
        libayatana-appindicator3-1 \
        libwebkit2gtk-4.0-37 && \
    dpkg -i /tmp/clash-verge.deb && \
    apt autoremove -y && \
    apt autoclean -y && \
    apt clean && \
    rm -rf \
        /config/.cache \
        /config/.launchpadlib \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

COPY /root /

VOLUME /config/.local/share/io.github.clash-verge-rev.clash-verge-rev

EXPOSE 7897 9097
