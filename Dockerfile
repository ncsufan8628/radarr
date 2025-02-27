# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# Set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Custom Radarr Build - ${VERSION} (${BUILD_DATE})"
LABEL maintainer="ncsufan8628"

# Environment settings
ENV XDG_CONFIG_HOME="/config/xdg" \
  COMPlus_EnableDiagnostics=0 \
  TMPDIR=/run/radarr-temp

# Install dependencies
RUN apk add --no-cache icu-libs sqlite-libs xmlstarlet

# Create required directories
RUN mkdir -p /app/radarr/bin

# Copy your custom-built Radarr into the container
COPY ./docker-build/Radarr /app/radarr/bin

# Set proper permissions
RUN chmod -R 755 /app/radarr/bin

# Expose the default Radarr port
EXPOSE 7878

# Define volume
VOLUME /config

# Set the entrypoint
CMD ["/app/radarr/bin/Radarr"]