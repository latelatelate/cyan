#!/bin/sh
#
# Initial configuration for podman host
# TODO: Build out proper initilization + automation script
#

# Base froject folder
mkdir -p /opt/cyan

git clone -b dev --verbose cyan:latelatelate/cyan.git /opt/cyan 

# Quadlet setup
mkdir -p ~/.config/containers/systemd/cyan
ln -s /opt/cyan/quadlets/* ~/.config/containers/systemd/cyan/

# SSL Certs
mkdir -p /opt/cyan/certs
cd /opt/cyan/certs
