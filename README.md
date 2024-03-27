# Half-Life 2: Deathmatch Dedicated Server

This is a Half-Life 2: Deathmatch Dedicated Server inspired by [OpenSourceLAN GameServers-Docker](https://github.com/OpenSourceLAN/gameservers-docker/).

## Linux Container

### Run simple interactive LAN server

There are the following environment variables:

    SV_HOSTNAME: <Name of your Server>
    PUBLIC: <1 for public server, 0 for LAN server>
    RCON_PASSWORD: <your rcon password>
    SV_PASSWORD: <your sv password>
    WINLIMIT: <number of limit to win>
    MAP: <map to start with>
    MAXPLAYERS: <number of max players>

To run it directly you can use the following command and add as much environment variables with -e as you need.

```shell
docker run -it --rm --net=host dts2k/hl2dmsvr -e "SV_HOSTNAME=<Name of your Server>" -e "MAP=<map to start with>"
```

To run it with docker-compose you have to change the environment variables in the docker-compose.yml to your own needs. Example:

```
version: '3'
services:
  app:
    image: dts2k/hl2dmsvr
    container_name: hl2dmsvr
    restart: always
    network_mode: host    
    stdin_open: true
    tty: true  
    environment:
      SV_HOSTNAME: <Name of your Server>
      PUBLIC: 0
      RCON_PASSWORD: <Your RCON Password>
      SV_PASSWORD: <Your SV Password>
      WINLIMIT: 20
      MAP: canale_grande_v2 
      MAXPLAYERS: 8
```

After that, fire up your HL2DM server with:

```shell
docker-compose up
```

### Build your own

To build your own server from this repo run the following commands:

```shell
git clone --recursive https://github.com/tschumi/hl2dmsvr.git
cd hl2dmsvr
docker build -t <yourreponame/yourchoosenname> .
```

```shell
docker run -it <yourreponame/yourchoosenname>
```

#### Useful hints

If building on a machine with Apple Silicon, you have to add the --platform linux/amd64 to the build and run commands.

If using podman to push the image to docker hub, you have to add --format=v2s1 to the push command to avoid the "missing manifest" error.

#### Hint

To make the server reachable from the world out there, you have to change the sv_lan variable to 0. Also make sure, the following ports are open and directing to your server:

* 27015/tcp
* 27015/udp
* 27020/udp
* 26900/udp

