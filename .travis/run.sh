#!/bin/bash

set -e
set -x

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    eval "$(plenv init -)"
    plenv rehash
fi

perl --version

perl Build.PL
./Build
./Build test
./Build install

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    cover -test
fi
