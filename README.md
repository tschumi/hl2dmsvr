# dts2k SWISS Half-Life 2: Deathmatch Dedicated Server

This is a Half-Life 2: Deathmatch Dedicated Server based on the Docker Server by [Laclede's LAN](https://lacledeslan.com). Its contents are customized for our own needs. For third-parties we recommend using this repo only as a reference example and then building your own using [gamesvr-hl2dm](https://github.com/LacledesLAN/gamesvr-hl2dm) as the base image for their customized server.

## Linux Container

### Download

```shell
docker pull dts2k/hl2dmsvr;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm dts2k/hl2dmsvr ./ll-tests/gamesvr-hl2dm-freeplay.sh;
```

### Run simple interactive server

```shell
docker run -it --rm --net=host dts2k/hl2dmsvr ./srcds_run -console -game hl2mp +map dm_carousel +maxplayers 8 +sv_lan 0
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with their Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of their other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
