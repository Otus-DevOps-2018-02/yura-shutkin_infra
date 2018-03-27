#!/usr/bin/env bash

git clone -b cloud-testapp  https://github.com/Otus-DevOps-2018-02/yura-shutkin_infra.git automaton && \
cd automaton && \
./install_ruby.sh && \
./install_mongodb.sh && \
./deploy.sh
