# escape=`
FROM lacledeslan/gamesvr-hl2dm

HEALTHCHECK NONE

ARG BUILDNODE="unspecified"
ARG SOURCE_COMMIT

ENV LANG=de_CH.UTF-8 LANGUAGE=de_CH.UTF-8 LC_ALL=de_CH.UTF-8
RUN sed -i "s|LC_ALL=en_US.UTF-8|LC_ALL=${LC_ALL}|g" /etc/environment

COPY --chown=HL2DM:root ./sourcemod.linux /app/hl2mp/

COPY --chown=HL2DM:root ./sourcemod-configs /app/hl2mp/

COPY --chown=HL2DM:root ./dist /app/

COPY --chown=HL2DM:root ./ll-tests/*.sh /app/ll-tests

RUN mkdir -p /app/hl2mp/logs && chown HL2DM:root /app/hl2mp/logs;

RUN chmod +x /app/ll-tests/*.sh;

USER HL2DM

WORKDIR /app

EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27020/udp
EXPOSE 26900/udp

CMD ["/bin/bash"]

ONBUILD USER root
