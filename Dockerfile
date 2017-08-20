FROM ubuntu:16.04
MAINTAINER DoubleXMinus <doublexminus@web.de>

ENV DEBIAN_FRONTEND noninteractive
ENV _clean="rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"
ENV _apt_clean="eval apt-get clean && $_clean"

RUN apt-get update
RUN apt-get install -y tzdata language-pack-de
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure -f noninteractive tzdata


# fix locale.
RUN locale-gen de_DE.UTF-8  
ENV LANG de_DE.UTF-8  
ENV LANGUAGE de_DE:de  
ENV LC_ALL de_DE.UTF-8

RUN apt-get update
RUN apt-get install -y wget
# Install s6-overlay
RUN wget https://github.com/just-containers/s6-overlay/releases/download/v1.15.0.0/s6-overlay-amd64.tar.gz -P /tmp/
RUN tar zxf /tmp/s6-overlay-amd64.tar.gz -C / && $_clean

ENTRYPOINT [ "/init" ]
