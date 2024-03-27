FROM ubuntu:16.04

ARG TZ="Europe/Zurich"
RUN apt-get update  && apt-get dist-upgrade -y &&\
	apt-get install -y unzip p7zip-full curl wget lib32gcc1 iproute2 vim-tiny bzip2 jq software-properties-common apt-transport-https lib32stdc++6 && \
	apt-get clean
RUN echo "$TZ" > /etc/timezone
RUN  ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

# go with steamcmd 
RUN useradd -m steam
RUN mkdir -p /steam/steamcmd_linux
RUN chown -R steam /steam

USER steam

WORKDIR /steam/steamcmd_linux
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz 
RUN tar -xf steamcmd_linux.tar.gz

# go with hl2dm
RUN mkdir -p /steam/hl2dm
RUN ./steamcmd.sh +login anonymous +force_install_dir /steam/hl2dm +app_update 232370 +quit

WORKDIR /steam/hl2dm/

COPY --chown=steam ./dist /steam/hl2dm/
COPY --chown=steam start.sh /steam/hl2dm/

RUN chmod +x /steam/hl2dm/start.sh

EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/udp
EXPOSE 26900/udp

CMD ["./start.sh"]
