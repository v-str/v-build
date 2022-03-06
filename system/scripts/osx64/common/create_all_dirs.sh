#!/bin/bash

# check OS variables existance

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
COUNTER=1

function msg_green(){ printf "${NC}$1 ${GREEN}$2${NC}\n" ; }

msg_green "Preparing current directory" "running\n"

mkdir -v "$V_BUILD_PATCH_DIR"
mkdir -v "$V_BUILD_ARCHIVE_DIR"

sleep 0.5
exit 0

