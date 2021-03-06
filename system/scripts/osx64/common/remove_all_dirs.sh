#!/bin/bash

# check OS variables existance

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
COUNTER=1

function msg_green(){ printf "${NC}$1 ${GREEN}$2${NC}\n" ; }

msg_green "Removing build-related directories" "running\n"

sudo rm -rfv "$V_BUILD_TREE_X86_64"
rm -rfv "$V_BUILD_DIR/.extracted"
rm -rfv "$V_BUILD_DIR/.machine_name"

sleep 0.5
exit 0

