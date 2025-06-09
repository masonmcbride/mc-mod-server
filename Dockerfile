# Use the official itzg image as our base
FROM itzg/minecraft-server:latest

# Tell the image we want Fabric 1.20.1
ENV TYPE=FABRIC \
    VERSION=1.20.1 \
    EULA=TRUE

# Copy our mods into the container’s /mods (gets synced to /data/mods)
COPY mods/ /mods/

