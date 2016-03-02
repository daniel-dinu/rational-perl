#!/bin/bash

set -e
set -x

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    # Install some custom requirements on OS X

    brew update
    brew install plenv
    brew install perl-build

    eval "$(plenv init -)"

    plenv install $TOXENV &> /dev/null
    plenv global $TOXENV
    plenv rehash

    perl --version

    plenv install-cpanm
    cpanm --quiet --notest --skip-satisfied Module::Build
    plenv rehash
else
    # Install some custom requirements on Linux

    cpanm --quiet --notest --skip-satisfied Devel::Cover Devel::Cover::Report::Codecov
fi
