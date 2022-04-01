#!/bin/bash

# purifying system, remove excess files and directories

pushd /

rm -rf linux-*
rm -rf packages
rm -rf lib/python-*/test

exit 0
