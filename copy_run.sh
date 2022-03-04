#!/bin/bash

cp ../v-build_build/io_lib/libio_lib.so.1.0.0 system/libs/libio_lib.so.1.0.0
cp ../v-build_build/navigation_lib/libnavigation_lib.so.1.0.0 system/libs/libnavigation_lib.so.1.0.0
cp ../v-build_build/osx64_lib/libosx64_lib.so.1.0.0 system/libs/libosx64_lib.so.1.0.0

rm -rf ../v-build_build/v-build/system
mkdir ../v-build_build/v-build/system

chown -R $USER:$USER ../v-build_build/v-build/system

cp -r system/* ../v-build_build/v-build/system

if [ -d "../v-build_run" ]; then
	rm -rf ../v-build_run/system
	rm -rf ../v-build_run/v-build
	mkdir ../v-build_run/system
	chown -R $USER:$USER ../v-build_run/system
else
	mkdir ../v-build_run
	mkdir ../v-build_run/system
fi

cp ../v-build_build/v-build/v-build ../v-build_run/v-build
cp -r ../v-build_build/v-build/system/* ../v-build_run/system

cd ../v-build_run && ./v-build
#cd ../v-build_run && valgrind --leak-check=full ./v-build

