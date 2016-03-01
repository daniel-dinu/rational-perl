#!/bin/bash

set -e
set -x

plenv rehash
perl --version

perl Build.PL
./Build
./Build test
./Build install

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    cover -test
fi
