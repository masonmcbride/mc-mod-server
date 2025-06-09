# mc-mod-server/Dockerfile

FROM itzg/minecraft-server:latest

ENV TYPE=FABRIC \
    VERSION=1.20.1 \
    EULA=TRUE

COPY mods/ /mods/

COPY config/ /config/

