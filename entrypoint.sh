#!/bin/bash

set -e

# install npm site packages packages
npm install --update

# Run tests with npm
npm test
