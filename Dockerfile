FROM ubuntu:latest

MAINTAINER Tobias

# Starting steam with validate is slow, lets make it an option
ENV CHECKFILES "false"
# Variable to enable RCON, enabled by default
ENV RCON "true"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install lib32gcc1 wget lib32stdc++6 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && mkdir -p /data/hurtworld/backup \
    && useradd -d /data/hurtworld -s /bin/bash --uid 1000 hurtworld \
    && chown -R hurtworld: /data/hurtworld/

EXPOSE 27016/udp 7778/udp
EXPOSE 32331/tcp

ADD hurtworld.sh /usr/local/bin/hurtworld

USER hurtworld 
VOLUME /data/hurtworld
WORKDIR /data/hurtworld
CMD ["hurtworld"]
