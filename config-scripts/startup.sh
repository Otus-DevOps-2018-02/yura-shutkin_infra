#!/usr/bin/env bash

sudo -u appuser bash - <<EOF
cd /home/appuser
git clone -b cloud-testapp  https://github.com/Otus-DevOps-2018-02/yura-shutkin_infra.git automaton && \
sudo ./automaton/config-scripts/install_ruby.sh && \
sudo ./automaton/config-scripts/install_mongodb.sh && \
./automaton/config-scripts/deploy.sh
rm -Rfv automaton
EOF
