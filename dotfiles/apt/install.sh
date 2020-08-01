#!/usr/bin/env sh

# Register the Microsoft repository
wget -O /tmp/microsoft-repo.deb -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i /tmp/microsoft-repo.deb
rm /tmp/microsoft-repo.deb

# update repositories
apt update

# TODO: install packages
