#!/bin/bash

[[ -z $MAP ]] && MAP="dm_underpass"
[[ -z $MAXPLAYERS ]] && MAXPLAYERS=8

if [[ -n $PUBLIC ]]
then
    SV_LAN="+sv_lan 0"
else
	SV_LAN="+sv_lan 1"
fi

# Replace values in the existing server.cfg
SERVER_CFG="/steam/hl2dm/hl2mp/cfg/server.cfg"

if [[ -f "$SERVER_CFG" ]]; then
    # Replace hostname if SV_HOSTNAME is set
    [[ -n $SV_HOSTNAME ]] && sed -i "s/^hostname \".*\"/hostname \"$SV_HOSTNAME\"/" "$SERVER_CFG"
    
    # Replace sv_password if SV_PASSWORD is set
    if [[ -n $SV_PASSWORD ]]; then
        if grep -q "^sv_password" "$SERVER_CFG"; then
            sed -i "s/^sv_password \".*\"/sv_password \"$SV_PASSWORD\"/" "$SERVER_CFG"
        else
            # Add it after the hostname line if it doesn't exist
            sed -i "/^hostname/a sv_password \"$SV_PASSWORD\"" "$SERVER_CFG"
        fi
    fi
    
    # Replace or add rcon_password if RCON_PASSWORD is set
    if [[ -n $RCON_PASSWORD ]]; then
        if grep -q "^rcon_password" "$SERVER_CFG"; then
            sed -i "s/^rcon_password .*/rcon_password \"$RCON_PASSWORD/" "$SERVER_CFG"
        else
            # Add it after sv_password if it doesn't exist
            sed -i "/^sv_password/a rcon_password \"$RCON_PASSWORD\"" "$SERVER_CFG"
        fi
    fi
    
    # Replace or add mp_winlimit if WINLIMIT is set
    if [[ -n $WINLIMIT ]]; then
        if grep -q "^mp_winlimit" "$SERVER_CFG"; then
            sed -i "s/^mp_winlimit .*/mp_winlimit $WINLIMIT/" "$SERVER_CFG"
        else
            # Add it in the gameplay settings section
            sed -i "/^\/\/==ESSENTIAL GAMEPLAY SETTINGS/a mp_winlimit $WINLIMIT" "$SERVER_CFG"
        fi
    fi
    
    # Handle MAPCYCLE_FILE if set
    [[ -n $MAPCYCLE_FILE ]] && sed -i "s|^exec mapcycle.*|exec $MAPCYCLE_FILE|" "$SERVER_CFG"
fi

exec ./srcds_run -game hl2mp $SV_LAN -ip 0.0.0.0 +exec server.cfg +map $MAP -maxplayers $MAXPLAYERS
