FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Zurich"
ENV CONTENT_SERVER="http://tswb.ch/srcds"

RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates wget tzdata lib32gcc-s1 libsdl2-2.0-0:i386 iproute2 vim-tiny \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m steam \
	&& mkdir -p /steam/steamcmd_linux /steam/hl2dm \
	&& chown -R steam:steam /steam

USER steam

# install steamcmd and let it self-update once, so the first container start is faster
WORKDIR /steam/steamcmd_linux
RUN wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz \
	&& (./steamcmd.sh +quit || true)

# game files are installed/updated by start.sh into this volume on every start
VOLUME /steam/hl2dm

# own configs, plugins etc. are copied over the game files by start.sh on every start
COPY --chown=steam:steam ./dist /steam/dist/
COPY --chown=steam:steam --chmod=755 start.sh /steam/start.sh

WORKDIR /steam/hl2dm

EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/udp
EXPOSE 26900/udp

CMD ["/steam/start.sh"]
