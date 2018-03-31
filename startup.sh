#!/usr/bin/env bash

sudo -u appuser bash - <<EOF
cd /home/appuser
git clone -b cloud-testapp  https://github.com/Otus-DevOps-2018-02/yura-shutkin_infra.git automaton && \
./automaton/install_ruby.sh && \
./automaton/install_mongodb.sh && \
./automaton/deploy.sh
rm -Rfv automaton
EOF
