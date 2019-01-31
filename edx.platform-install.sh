#!/bin/sh
# Native Open edX Ubuntu 16.04 64 bit Installation
# McDaniel
# October 2017
#
# To stand up a pristine single-server instance of Open edX hawthorn.master
# this is a modification of the generic instructions from:
#   Native Open edX Ubuntu 16.04 64 bit Installation
#   https://openedx.atlassian.net/wiki/spaces/OpenOPS/pages/146440579/Native+Open+edX+Ubuntu+16.04+64+bit+Installation
#
# This script takes around 2 hours to complete. It is intended to be run unattended, on a background thread using
# nohup.
#---------------------------------------------------------


cd ~

# Prerequisites: ensure that locales are set on your server. if not the ansible boostrap script below will break.
# Setting locale to spanish-guatemala
sudo locale-gen es_GT es_GT.UTF-8
sudo localectl set-locale LANG=es_GT.UTF-8
export LANG=es_GT.UTF-8
export LC_ALL="es_GT.UTF-8"
export LC_CTYPE="es_GT.UTF-8"

# 1. Set the OPENEDX_RELEASE variable:
#export OPENEDX_RELEASE=open-release/ginkgo.2
# Note: sometimes there are important bug fixes in master that are not included in the named releases.
#       to date i've always had the best luck with master.
export OPENEDX_RELEASE=open-release/hawthorn.master

# 2. Bootstrap the Ansible installation:
wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/ansible-bootstrap.sh -O - | sudo -H bash

# 3. (Optional) If this is a new installation, randomize the passwords:
wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/generate-passwords.sh -O - | bash

# 4. Install Open edX:
wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/native.sh -O - | bash > install.out
