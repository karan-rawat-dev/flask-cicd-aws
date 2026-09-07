#!/bin/bash
apt-get update
apt-get install -y python3-pip python3-venv nginx
mkdir -p /home/ubuntu/flask-app