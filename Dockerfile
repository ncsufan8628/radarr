# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Custom Radarr Build: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="ncsufan8628"

# environment settings
ENV XDG_CONFIG_HOME="/config/xdg" \
  COMPlus_EnableDiagnostics=0 \
  TMPDIR=/run/radarr-temp

# Install dependencies
RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    icu-libs \
    sqlite-libs \
    xmlstarlet

# Create Radarr directory
RUN mkdir -p /app/radarr/bin

# Copy your custom build of Radarr into the container
COPY ./Radarr /app/radarr/bin

# Set permissions
RUN chmod +x /app/radarr/bin/Radarr

# Create package info file
RUN echo -e "UpdateMethod=docker\nBranch=custom\nPackageVersion=${VERSION}\nPackageAuthor=ncsufan8628" > /app/radarr/package_info

# copy local files
#COPY root/ /

# Expose the default Radarr port
EXPOSE 7878

# Define the Radarr startup command
CMD ["/app/radarr/bin/Radarr"]
