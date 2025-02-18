FROM harbor.tid.es/la-qa/python/python-base-laqacommons:3.11.11 AS base

ENV LANG=es_ES.UTF-8

LABEL maintainer = "LA QA Team <qacdcolivingapps@telefonica.com>"

ARG NEXUS_LA_USER
ARG NEXUS_LA_PASSWORD

WORKDIR /app

#=================
# Install packages with pip
#=================
COPY ./tests/acceptance/requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
