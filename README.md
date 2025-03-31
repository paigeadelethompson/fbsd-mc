# Minecraft Server with OpenTerrainGenerator on FreeBSD Podman Jails

This repository contains a Dockerfile and configuration files for running a Minecraft server with OpenTerrainGenerator (OTG) in a FreeBSD podman jail.

## Prerequisites

- FreeBSD system with podman installed
- Root access (for podman operations)

## Building the Container

1. First, import the FreeBSD base image:
```bash
sudo podman import --os freebsd https://download.freebsd.org/ftp/releases/amd64/amd64/14.2-RELEASE/base.txz freebsd
```

2. Build the Minecraft server container:
```bash
sudo podman build -t freebsd/minecraft -t freebsd/minecraft:1.16.5 .
```

## Running the Server

To run the server with persistent storage:

```bash
sudo podman run -it --rm \
  -p 25565:25565 \
  -v /storage/GravelPit:/minecraft/GravelPit \
  -v /storage/GravelPit_the_end:/minecraft/GravelPit_the_end \
  -v /storage/GravelPit_nether:/minecraft/GravelPit_nether \
  -v /storage/GravelPit_logs:/minecraft/logs \
  -v /storage/GravelPit_cache:/minecraft/cache \
  localhost/freebsd/minecraft
```

This command:
- Maps the Minecraft server port (25565)
- Creates persistent storage for:
  - Main world data (/storage/GravelPit)
  - End dimension (/storage/GravelPit_the_end)
  - Nether dimension (/storage/GravelPit_nether)
  - Server logs (/storage/GravelPit_logs)
  - Cache files (/storage/GravelPit_cache)

## Configuration

The server is configured with:
- Minecraft version: 1.16.5
- OpenTerrainGenerator for custom world generation
- Custom biome configurations
- WorldConfig.ini for OTG settings

## Ports

- 25565: Minecraft server port
- 25575: RCON port (if enabled)
- 19132: Bedrock server port
- 19133: Bedrock server port

## Notes

- The server runs in a FreeBSD podman jail for isolation
- World generation is handled by OpenTerrainGenerator
- Custom biome configurations are included in the `biomes/` directory
- Server properties can be modified in `server.properties`
