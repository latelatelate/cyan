#!/bin/sh
#
# Initial configuration for podman host
# TODO: Build out proper initilization + automation script
#
PROJECT_NAME=cyan
INSTALL_DIR=/opt/${PROJECT_NAME}
QUADLET_DIR=~/.config/containers/systemd/${PROJECT_NAME}
SOCKET_DIR=~/.config/systemd/user

# Base project folder
mkdir -p ${INSTALL_DIR}

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

sudo mv "$REPO_DIR" /opt/

# Quadlet setup
mkdir -p ${QUADLET_DIR}
mkdir -p ${SOCKET_DIR}
rsync -avu --delete ${INSTALL_DIR}/quadlets/ ${QUADLET_DIR}
cp -r ${INSTALL_DIR}/sockets/ ${SOCKET_DIR}

systemctl --user daemon-reload

# SSL Certs
mkdir -p ${INSTALL_DIR}/certs

# Allow unprivileged user to open sockets >= 80
echo "net.ipv4.ip_unprivileged_port_start=80" > /etc/sysctl.d/99-unprivileged-port.conf
sysctl -p /etc/sysctl.d/99-unprivileged-port.conf

# Enable linger for rootless user
loginctl enable-linger nm