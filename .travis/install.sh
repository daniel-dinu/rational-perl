#!/bin/bash

set -e
set -x

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    # Install some custom requirements on OS X

    echo "OSX"

    brew update
    brew install plenv
    brew install perl-build

    eval "$(plenv init -)"
    plenv install $TOXENV &> /dev/null
    plenv global $TOXENV
    plenv rehash
    perl --version
else
    # Install some custom requirements on Linux

    echo "LINUX"
fi
