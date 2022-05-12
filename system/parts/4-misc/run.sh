#!/bin/bash

pushd /parts/4-misc

./libarchive_pkg.sh
./libuv_pkg.sh
./git_pkg.sh
./curl_pkg.sh
./cmake_pkg.sh
./qt5_pkg.sh
./v-build_test_pkg.sh

popd

exit 0

