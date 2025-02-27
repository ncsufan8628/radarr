# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# Set version label
ARG BUILD_DATE
ARG VERSION
ARG RADARR_RELEASE
LABEL build_version="Custom Radarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ncsufan8628"

# Set environment variables
ARG RADARR_BRANCH="master"
ENV XDG_CONFIG_HOME="/config/xdg" \
  COMPlus_EnableDiagnostics=0 \
  TMPDIR=/run/radarr-temp

# Install dependencies
RUN apk add --no-cache \
    icu-libs \
    sqlite-libs \
    xmlstarlet

# Create application directory
RUN mkdir -p /app/radarr/bin

# Copy your prebuilt Radarr binary into the container
COPY ./docker-build/Radarr/ /app/radarr/bin/

# Set permissions
RUN chmod +x /app/radarr/bin/Radarr

# Expose the default Radarr port
EXPOSE 7878

# Set volume for configuration persistence
VOLUME /config

# Define the entrypoint
CMD ["/app/radarr/bin/Radarr"]