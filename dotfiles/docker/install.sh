#!/usr/bin/env sh

# TODO

# add the current user to the docker group to run docker commands without sudo
usermod -aG docker $USER
