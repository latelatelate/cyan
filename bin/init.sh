#!/bin/sh
#
# Initial configuration for podman host
# TODO: Build out proper initilization + automation script
#
INSTALL_DIR=/opt/cyan
QUADLET_DIR=~/.config/containers/systemd/cyan

# Base project folder
mkdir -p ${INSTALL_DIR}

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

sudo mv "$REPO_DIR" /opt/

# Quadlet setup
mkdir -p ${QUADLET_DIR}
rsync -avu --delete ${INSTALL_DIR}/quadlets/ ${QUADLET_DIR}

# SSL Certs
mkdir -p ${INSTALL_DIR}/certs

# Allow unprivileged user to open sockets >= 80
echo "net.ipv4.ip_unprivileged_port_start=80" > /etc/sysctl.d/99-unprivileged-port.conf
sysctl -p /etc/sysctl.d/99-unprivileged-port.conf

# Enable linger for rootless user
loginctl enable-linger nm