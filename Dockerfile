# Use the imported FreeBSD base image
FROM localhost/freebsd

# Define build argument for version
ARG MINECRAFT_VERSION=1.16.5

# Bootstrap and install pkg
RUN /bin/sh -c 'pkg bootstrap -y && pkg update && pkg upgrade -y'

# Install wget
RUN pkg install -y wget

# Install appropriate Java version based on Minecraft version
RUN if [ "$MINECRAFT_VERSION" = "1.12.2" ]; then \
        pkg install -y openjdk8 && \
        echo "JAVA_HOME=/usr/local/openjdk8" >> /etc/profile && \
        echo "PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile; \
    elif [ "$MINECRAFT_VERSION" = "1.16.5" ]; then \
        pkg install -y openjdk11 && \
        echo "JAVA_HOME=/usr/local/openjdk11" >> /etc/profile && \
        echo "PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile; \
    elif [ "$MINECRAFT_VERSION" = "1.18.2" ]; then \
        pkg install -y openjdk17 && \
        echo "JAVA_HOME=/usr/local/openjdk17" >> /etc/profile && \
        echo "PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile; \
    elif [ "$MINECRAFT_VERSION" = "1.19.4" ]; then \
        pkg install -y openjdk17 && \
        echo "JAVA_HOME=/usr/local/openjdk17" >> /etc/profile && \
        echo "PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile; \
    fi

# Create base minecraft directory
RUN mkdir -p /minecraft/plugins

# Download Minecraft server jar based on version
RUN if [ "$MINECRAFT_VERSION" = "1.12.2" ]; then \
        wget -O /minecraft/minecraft.jar https://launcher.mojang.com/mc/game/1.12.2/server/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar && \
        wget -O /minecraft/plugins/OpenTerrainGenerator.jar https://www.openterraingenerator.org/Downloads/OpenTerrainGenerator-1.12.2-v9.4.jar; \
    elif [ "$MINECRAFT_VERSION" = "1.16.5" ]; then \
        wget -O /minecraft/minecraft.jar https://api.papermc.io/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar && \
        wget -O /minecraft/plugins/OpenTerrainGenerator.jar https://www.openterraingenerator.org/Downloads/OpenTerrainGenerator-1.16.5-0.1.10.jar; \
    elif [ "$MINECRAFT_VERSION" = "1.18.2" ]; then \
        wget -O /minecraft/minecraft.jar https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/388/downloads/paper-1.18.2-388.jar && \
        wget -O /minecraft/plugins/OpenTerrainGenerator.jar https://www.openterraingenerator.org/Downloads/OpenTerrainGenerator-Paper-1.18.2-0.0.29.jar; \
    elif [ "$MINECRAFT_VERSION" = "1.19.4" ]; then \
        wget -O /minecraft/minecraft.jar https://api.papermc.io/v2/projects/paper/versions/1.19.4/builds/550/downloads/paper-1.19.4-550.jar && \
        wget -O /minecraft/plugins/OpenTerrainGenerator.jar https://www.openterraingenerator.org/Downloads/OpenTerrainGenerator-Paper-1.19-0.0.29.jar; \
    fi

# Copy minimal config files
ADD minecraft/ /minecraft

# Set permissions
RUN chmod -R 755 /minecraft

# Set working directory
WORKDIR /minecraft

# Create required directories
RUN mkdir -p /minecraft/GravelPit_the_end \
    /minecraft/cache \
    /minecraft/GravelPit_nether \
    /minecraft/GravelPit \
    /minecraft/logs

# Declare volumes
VOLUME /minecraft/GravelPit_the_end
VOLUME /minecraft/cache
VOLUME /minecraft/GravelPit_nether
VOLUME /minecraft/GravelPit
VOLUME /minecraft/logs

# Expose all necessary Minecraft ports
EXPOSE 25565
EXPOSE 25575
EXPOSE 19132
EXPOSE 19133

# Source the profile to get the correct Java version
RUN . /etc/profile

# Set entrypoint
ENTRYPOINT ["/bin/sh", "-c", "java -jar /minecraft/minecraft.jar nogui"] 