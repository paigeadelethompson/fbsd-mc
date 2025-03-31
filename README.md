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

## Version Compatibility Notes

This server runs on Minecraft 1.16.5, which has some important implications:
- No raw copper or copper ore (added in 1.17)
- No deepslate variants (added in 1.17)
- No cave biomes (added in 1.18)
- No ancient cities (added in 1.19)

When editing biome configurations, ensure you only use blocks and features available in Minecraft 1.16.5.

## World Features

### Biome Groups and Geological Features

The world is divided into distinct biome groups, each with unique geological and environmental characteristics:

#### Hot Zones (Highest Priority, 100 Rarity)
- **Primary Biomes**: Jungles, Swamps, Warm Oceans
- **Geological Features**:
  - **Jungle Formations**:
    - Flat Regions (Primary Diamond Source):
      - Rich kimberlite pipe formations in stable, flat terrain
      - Major diamond concentrations near surface (Y=40 to Y=70)
      - Extensive pipe networks with deep root systems
      - Follows patterns where kimberlite pipes form in stable regions
    - Hills (Emerald-Rich, Diamond-Poor):
      - Rich emerald deposits from tectonic activity
      - Fewer diamonds due to geological instability
      - Multiple emerald enrichment layers (Y=30 to Y=80)
      - Results from hydrothermal fluid interactions
    - General Features:
      - Distinct mineralization zones
      - Reduced common ore generation
      - Complex underground cave networks
  - **Swamp Deposits**: 
    - Unique mineral formations in waterlogged terrain
    - Special ore concentrations in anaerobic conditions
    - Enhanced coal formation from organic material
  - **Warm Ocean Floor**: 
    - Rich coral and sedimentary deposits
    - Unique underwater cave formations
- **Config Files**:
  - Jungle Variants:
    - `jungle/Jungle.bc`
    - `jungle/Modified Jungle.bc`
    - `jungle/Bamboo Jungle.bc`
    - `jungle/Jungle Hills.bc`
    - `jungle/Jungle Edge.bc`
    - `jungle/Modified Jungle Edge.bc`
    - `jungle/Bamboo Jungle Hills.bc`
  - Swamp Variants:
    - `swamp/Swamp.bc`
    - `swamp/Swamp Hills.bc`
  - Ocean Variants:
    - `ocean/Warm Ocean.bc`
    - `ocean/Deep Warm Ocean.bc`

#### Moderate Zones (Second Priority, 90 Rarity)
- **Primary Biomes**: Plains, Forests, Standard Oceans
- **Geological Features**:
  - **Forest Regions**: 
    - Coal Formation:
      - Rich deposits (25 veins/chunk, up to 30 blocks/vein)
      - Full height range (Y=0 to Y=127)
      - Consistent ore distribution
      - Formation Process:
        1. Ancient forest regions provided abundant plant material
        2. Stable ground conditions allowed material accumulation
        3. Proper burial conditions preserved organic matter
        4. Compression and time created extensive deposits
    - Mining Implications:
      - Prime locations for coal operations
      - Surface features indicate underground wealth
      - Large vein sizes for efficient mining
      - Full height range for varied mining approaches
  - **Plains**: 
    - Balanced mineral distribution
    - Even ore spacing
    - Good for starter mines
  - **Ocean Floor**: 
    - Varied sedimentary deposits
    - Underwater cave systems
- **Config Files**:
  - Plains Variants:
    - `plains/Plains.bc`
    - `plains/Sunflower Plains.bc`
  - Forest Variants:
    - `forest/Forest.bc`
    - `forest/Dark Forest.bc`
    - `forest/Dark Forest Hills.bc`
    - `forest/Birch Forest.bc`
    - `forest/Birch Forest Hills.bc`
    - `forest/Flower Forest.bc`
    - `forest/Tall Birch Forest.bc`
    - `forest/Tall Birch Hills.bc`
    - `forest/Wooded Hills.bc`
  - Ocean and Shore Variants:
    - `ocean/Ocean.bc`
    - `ocean/Deep Ocean.bc`
    - `beach/Beach.bc`
    - `beach/Stone Shore.bc`
  - River:
    - `river/River.bc`

#### Dry Zones (Third Priority, 45 Rarity)
- **Primary Biomes**: Deserts, Savannas, Badlands
- **Geological Features**:
  - **Badlands/Mesa**:
    - Hydrothermal Deposits:
      - Rich gold veins throughout terrain
      - Primary deposits (Y=0 to Y=60)
      - Secondary enrichment zones (Y=30 to Y=70)
      - Abundant redstone deposits
    - Formation Characteristics:
      - Ancient hydrothermal activity
      - Multiple mineralization phases
      - Unique layering patterns
      - Rich in gold and redstone
  - **Desert**: 
    - Exposed mineral seams
    - Wind-carved cave systems
    - Surface deposit exposures
  - **Savanna**: 
    - Mixed mineral deposits
    - Moderate ore distribution
    - Unique plateau formations
- **Config Files**:
  - Desert Variants:
    - `desert/Desert.bc`
    - `desert/Desert Hills.bc`
    - `desert/Desert Lakes.bc`
  - Savanna Variants:
    - `savanna/Savanna.bc`
    - `savanna/Shattered Savanna.bc`
    - `savanna/Savanna Plateau.bc`
    - `savanna/Shattered Savanna Plateau.bc`
  - Badlands Variants:
    - `mesa/Badlands.bc`
    - `mesa/Badlands Plateau.bc`
    - `mesa/Eroded Badlands.bc`
    - `mesa/Modified Badlands Plateau.bc`
    - `mesa/Wooded Badlands Plateau.bc`
    - `mesa/Modified Wooded Badlands Plateau.bc`
  - Ocean Variants:
    - `ocean/Lukewarm Ocean.bc`
    - `ocean/Deep Lukewarm Ocean.bc`

#### Cold Zones (Fourth Priority, 40 Rarity)
- **Primary Biomes**: Mountains, Taigas, Cold Oceans
- **Geological Features**:
  - **Taiga Regions**:
    - Enhanced mineral preservation due to cold climate
    - High coal content (25-30 veins/chunk)
    - Increased iron deposits (25 veins/chunk)
    - Moderate precious metal concentration
  - **Snowy Taiga**:
    - Superior mineral preservation
    - Highest coal concentration (30 veins/chunk)
    - Rich iron deposits (30 veins/chunk)
    - Enhanced precious metal deposits
  - **Ice Spikes**:
    - Unique glacial mineral concentration
    - Maximum iron content (35 veins/chunk)
    - Rich precious metal deposits (5 gold veins/chunk)
    - Enhanced rare mineral preservation
    - Extensive gravel deposits from glacial action
- **Config Files**:
  - Mountain Variants:
    - `extreme_hills/Mountains.bc`
    - `extreme_hills/Mountain Edge.bc`
    - `extreme_hills/Wooded Mountains.bc`
    - `extreme_hills/Gravelly Mountains.bc`
    - `extreme_hills/Modified Gravelly Mountains.bc`
    - `extreme_hills/Gravelly Mountains+.bc`
  - Taiga Variants:
    - `taiga/Taiga.bc`
    - `taiga/Taiga Hills.bc`
    - `taiga/Taiga Mountains.bc`
    - `taiga/Giant Tree Taiga.bc`
    - `taiga/Giant Tree Taiga Hills.bc`
    - `taiga/Giant Spruce Taiga.bc`
    - `taiga/Giant Spruce Taiga Hills.bc`
  - Ocean Variants:
    - `ocean/Cold Ocean.bc`
    - `ocean/Deep Cold Ocean.bc`

#### Coastal Zones
- **Primary Biomes**: Beaches, Stone Shores, Snowy Beaches
- **Geological Features**:
  - **Stone Shores**:
    - Exposed mineral veins
    - High igneous rock content
    - Enhanced iron deposits (30 veins/chunk)
    - Moderate precious metal concentration
  - **Regular Beaches**:
    - Extensive sedimentary deposits
    - Maximum gravel concentration (30 veins/chunk)
    - Placer gold deposits
    - Reduced igneous rock presence
  - **Snowy Beaches**:
    - Well-preserved mineral deposits
    - High precious metal content
    - Enhanced iron concentration
    - Significant glacial gravel deposits

#### Arctic Zones (Fifth Priority, 20 Rarity)
- **Primary Biomes**: Snowy Plains, Frozen Oceans, Ice Spikes
- **Geological Features**:
  - Preserved mineral deposits under ice sheets
  - Unique ice spike formations
  - Frozen cave systems
  - Enhanced mineral concentration from glacial activity
- **Config Files**:
  - Snow Variants:
    - `snowy_plains/Snowy Plains.bc`
    - `icy/Snowy Mountains.bc`
    - `icy/Ice Spikes.bc`
  - Snowy Taiga Variants:
    - `snowy_taiga/Snowy Taiga.bc`
    - `snowy_taiga/Snowy Taiga Mountains.bc`
    - `snowy_taiga/Snowy Taiga Hills.bc`
  - Frozen Water Variants:
    - `ocean/Frozen Ocean.bc`
    - `ocean/Deep Frozen Ocean.bc`
    - `river/Frozen River.bc`
    - `beach/Snowy Beach.bc`

#### Ancient Mycelium Realms (Rarity: 1)
- **Primary Biomes**: Mushroom Fields, Mushroom Shores
- **Geological Features**:
  - Unique mycelium-based terrain
  - Special ore formations
  - No hostile mob spawns
  - Isolated ecosystem
- **Config Files**:
  - `mushroom/Mushroom Fields.bc`
  - `mushroom/Mushroom Fields Shore.bc`

Each biome group creates distinct gameplay experiences through its unique combination of terrain features, ore distribution, and environmental characteristics. The rarity values determine biome frequency, while geological features influence resource availability and mining strategies.

Mining Strategies by Region:
- Hot Zones: Focus on diamond and emerald hunting in appropriate terrain types
- Moderate Zones: Extensive coal mining operations in forests
- Dry Zones: Rich gold deposits in badlands, focus on hydrothermal formations
- Cold Zones: 
  - Taiga: Focus on coal and iron extraction
  - Ice Spikes: Premium location for iron and precious metals
  - Snowy Taiga: Balanced mining of all resources
- Coastal Zones:
  - Stone Shores: Focus on exposed mineral veins
  - Beaches: Placer deposit mining
  - Snowy Beaches: Combined glacial and coastal deposit extraction
- Arctic Zones: Deep mining under ice sheets
- Ancient Mycelium Realms: Unique ore formations in isolated environments

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
