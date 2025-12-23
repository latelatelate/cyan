#!/bin/sh
#
# Initial configuration for cyan pod
#
set -e
PROJECT_NAME=cyan
INSTALL_DIR=/opt/${PROJECT_NAME}
QUADLET_DIR=$HOME/.config/containers/systemd/${PROJECT_NAME}
SOCKET_DIR=$HOME/.config/systemd/user
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Create cyan dir and move repo into it
mkdir -p ${INSTALL_DIR}
mv "$REPO_DIR" /opt/

# Quadlet setup
mkdir -p ${QUADLET_DIR}
mkdir -p ${SOCKET_DIR}
rsync -avu --delete ${INSTALL_DIR}/quadlets/ ${QUADLET_DIR}
cp -r ${INSTALL_DIR}/sockets/ ${SOCKET_DIR}

# SSL Certs
mkdir -p ${INSTALL_DIR}/certs

# Allow unprivileged user to open sockets >= 80
echo "net.ipv4.ip_unprivileged_port_start=80" > /etc/sysctl.d/99-unprivileged-port.conf
sysctl -p /etc/sysctl.d/99-unprivileged-port.conf

# Enable linger for rootless user
loginctl enable-linger nm

systemctl --user daemon-reload

# Enable socket + quadlet at startup
systemctl --user enable cyan-proxy.socket
systemctl --user enable cyan.pod