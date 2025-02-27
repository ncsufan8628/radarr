# syntax=docker/dockerfile:1

# Use LinuxServer.io's base Alpine image
FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# Set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Custom Radarr version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ncsufan8628"

# Set environment variables
ENV XDG_CONFIG_HOME="/config/xdg" \
    COMPlus_EnableDiagnostics=0 \
    TMPDIR=/run/radarr-temp

# Install dependencies
RUN apk add --no-cache \
    icu-libs \
    sqlite-libs \
    xmlstarlet

# Create directories for Radarr
RUN mkdir -p /app/radarr/bin

# Copy your custom-built Radarr from the workflow
COPY ./Radarr /app/radarr/bin

# Set permissions
RUN chmod +x /app/radarr/bin/Radarr

# Expose the default Radarr port
EXPOSE 7878

# Set default working directory
WORKDIR /app/radarr/bin

# Run Radarr
CMD ["/app/radarr/bin/Radarr", "--no-browser", "-data=/config"]
