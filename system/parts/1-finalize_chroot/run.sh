#!/bin/bash

pushd /parts/1-finalize_chroot
./create_directories.sh
./essential_files_and_symlinks.sh
./make_libstdcpp_chroot-pass2.sh
popd

exit 0


