# syntax=docker/dockerfile:1

FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Roxedus,thespad"

# environment settings
ENV XDG_CONFIG_HOME="/config/xdg" \
  COMPlus_EnableDiagnostics=0 \
  TMPDIR=/run/radarr-temp

RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    icu-libs \
    sqlite-libs \
    xmlstarlet && \
    gcompat &&\

  echo "**** install radarr ****" && \
  mkdir -p /app/radarr/bin && \
  curl -L -o /tmp/radarr.tar.gz \
    "https://github.com/ncsufan8628/radarr/releases/download/latest-build/radarr-build.tar.gz" && \
  tar xzf /tmp/radarr.tar.gz -C /app/radarr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nPackageVersion=${VERSION}\nPackageAuthor=[linuxserver.io](https://linuxserver.io)" > /app/radarr/package_info && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  rm -rf \
    /app/radarr/bin/Radarr.Update \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 7878

VOLUME /config
