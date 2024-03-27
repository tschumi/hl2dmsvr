#!/bin/bash

[[ -n $RCON_PASSWORD ]] && RCON_PASSWORD="rcon_password $RCON_PASSWORD"
[[ -n $WINLIMIT ]] && WINLIMIT="mp_winlimit $WINLIMIT"
[[ -n $SV_PASSWORD ]] && SV_PASSWORD="sv_password $SV_PASSWORD"
[[ -z $MAP ]] && MAP="dm_underpass"
[[ -z $MAXPLAYERS ]] && MAXPLAYERS=8

if [[ -n $PUBLIC ]]
then
    SV_LAN="+sv_lan 0"
else
	SV_LAN="+sv_lan 1"
fi

cat <<EOF >/steam/hl2dm/hl2mp/cfg/server.cfg
hostname "$SV_HOSTNAME"
$RCON_PASSWORD
$SV_PASSWORD
$WINLIMIT
$MAPCYCLE_FILE
EOF

exec ./srcds_run -game hl2mp $SV_LAN -ip 0.0.0.0 +exec server.cfg +map $MAP -maxplayers $MAXPLAYERS
