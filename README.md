# dts2k SWISS Half-Life 2: Deathmatch Dedicated Server

This is a Half-Life 2: Deathmatch Dedicated Server based on the Docker Server by [Laclede's LAN](https://lacledeslan.com). Its contents are customized for our own needs. For third-parties we recommend using this repo only as a reference example and then building your own using [gamesvr-hl2dm](https://github.com/LacledesLAN/gamesvr-hl2dm) as the base image for their customized server.

## Linux Container

### Build

To build your own server from this repo do:

```shell
git clone --recursive https://github.com/tschumi/hl2dmsvr.git
cd hl2dmsvr
docker build -t <yourchoosenname> .
docker push <yourchoosenname> <yourreponame/yourchoosenname>
```

#### Useful hints

If building on a machine with Apple Silicon, you have to add the --platform linux/amd64 to the build and run commands.

If using podman to push the image to docker hub, you have to add --format=v2s1 to the push command to avoid the "missing manifest" error.

To change the sv_password you could use this command on console of the running the container:
sed -i 's|sv_password \"dts2kinit\"|sv_password \"<yoursecretpassword>\"|g' /app/hl2mp/cfg/server.cfg

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm dts2k/hl2dmsvr ./ll-tests/gamesvr-hl2dm-freeplay.sh
```

### Run simple interactive lan server

```shell
docker pull dts2k/hl2dmsvr
docker run -it --rm --net=host dts2k/hl2dmsvr ./srcds_run -console -game hl2mp +map dm_carousel +maxplayers 8 +sv_lan 1
```

#### Hint

To make the server reachable from the world out there, you have to change the sv_lan variable to 0. Also make sure, the following ports are open and directing to your server:

* 27015/tcp
* 27015/udp
* 27020/udp
* 26900/udp

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with their Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of their other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
