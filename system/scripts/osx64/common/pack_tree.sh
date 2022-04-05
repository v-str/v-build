#!/bin/bash

if [ ! -d "$V_BUILD_TREE_X86_64" ]; then
	printf "Nothing to pack, maybe env vars aren't set?\n"
	exit 1
else
	pushd $V_BUILD_TREE_X86_64
	sudo tar -cJpf $V_BUILD_DIR/osx64_$1_tree.tar.xz .
	popd
fi

exit 0

