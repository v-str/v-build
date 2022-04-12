#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

search_pkg=`sh /parts/4-misc/find_package.sh "qt5"`

if [ ! -z "${search_pkg}" ]; then
	msg_green "package found:" "$search_pkg"
else
	msg_res "package not found:" "$search_pkg"
	exit 1
fi

pushd /packages/${search_pkg}/${search_pkg}

export MAKE=/usr/bin/make

./configure --prefix=/opt/qt5 \
    -opensource \
    -release \
    -optimize-size \
    -confirm-license \
    -nomake examples \
    -skip qtquickcontrols \
    -skip qtwebkit \
    -skip qtwebchannel \
    -skip qtactiveqt \
    -skip qtandroidextras \
    -skip qtdeclarative \
    -skip qtimageformats \
    -skip qtmacextras \
    -skip qtx11extras \
    -skip qtxmlpatterns \
    -skip qtconnectivity \
    -skip qtdoc \
    -skip qtenginio \
    -skip qtgraphicaleffects \
    -skip qtmultimedia \
    -skip qtquick1 \
    -skip qtsensors \
    -skip qttools \
    -skip qttranslations \
    -skip qtwayland \
    -skip qtwebchannel \
    -skip qtwebengine \
    -skip qtwebkit-examples \
    -skip qtwebsockets \
    -skip qtwinextras \
    -skip qtlottie \
    -skip qtmqtt \
    -skip qtopcua \
    -skip qtquicktimeline \
    -skip qtquick3d \
    -skip qtscxml \
    -skip qtvirtualkeyboard \
    -skip qtwebview \
    -no-libjpeg \
    -no-mtdev \
    -no-xcb \
    -freetype \
    -libpng \
    -no-xcb-xlib \
    -no-pulseaudio \
    -no-opengl \
    -linuxfb

cmake --build . --parallel

popd

if [ ! -d /opt/qt5 ]; then
	mkdir -p /opt/qt5
fi

pushd /opt/qt5
cmake --install /packages/qt5/qt5
popd

exit 0


