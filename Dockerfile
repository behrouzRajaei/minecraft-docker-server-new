FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless wget curl jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/minecraft

RUN mkdir -p mods world

COPY fabric-server-launch.jar .
COPY mods ./mods

EXPOSE ${SERVER_PORT}

ENTRYPOINT ["bash","-c", "\
  echo \"eula=${EULA}\" > eula.txt && \
  java -Xms${MEMORY} -Xmx${MEMORY} \
  -jar fabric-server-launch.jar nogui \
"]
