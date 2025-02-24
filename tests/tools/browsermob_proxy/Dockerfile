# https://github.com/lightbody/browsermob-proxy
# https://browsermob-proxy-py.readthedocs.io/en/stable/

FROM openjdk:15-jdk-oraclelinux7

ARG BROWSERMOB_PROXY_VERSION=2.1.4

RUN yum -y install wget unzip

WORKDIR /opt
RUN wget https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-$BROWSERMOB_PROXY_VERSION/browsermob-proxy-$BROWSERMOB_PROXY_VERSION-bin.zip && \
    unzip browsermob-proxy-$BROWSERMOB_PROXY_VERSION-bin.zip

ENTRYPOINT ./browsermob-proxy-2.1.4/bin/browsermob-proxy
