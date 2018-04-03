#!/usr/bin/env bash
set -e

git clone -b $RELEASE https://github.com/express42/reddit.git
cd reddit
echo '{"version": "'$(git rev-parse HEAD)'"}' > version.json
rm -Rf .git*
bundle install
puma -d
