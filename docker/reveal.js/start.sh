#!/bin/bash

# Fetch the latest material
cd repository
git pull
cd ..

# Start the reveal.js server
npm run --ip=0.0.0.0 --external_ip=localhost start &
npm run --ip=0.0.0.0 jupyter-server
