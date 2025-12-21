#!/bin/sh
#
# Initial configuration for podman host
# TODO: Build out proper initilization + automation script
#

# Base project folder
mkdir -p /opt/cyan

git clone -b dev --verbose cyan:latelatelate/cyan.git /opt/cyan 

# Quadlet setup
mkdir -p ~/.config/containers/systemd/cyan
rsync -avu --delete /opt/cyan/quadlets/ ~/.config/containers/systemd/cyan

# SSL Certs
mkdir -p /opt/cyan/certs

# Allow unprivileged user to open sockets >= 80
echo "net.ipv4.ip_unprivileged_port_start=80" > /etc/sysctl.d/99-unprivileged-port.conf
sysctl -p /etc/sysctl.d/99-unprivileged-port.conf

# Enable linger for rootless user
loginctl enable-linger nm