#!/bin/bash
#./install_ruby.sh
set -e

# Install ruby
apt update
apt install -y ruby-full ruby-bundler build-essential
