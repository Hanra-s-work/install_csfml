#!/bin/bash

function yes_no_question {
    while true; do
        read -p "$1 [(Y)es/(n)o]: " yn
        case $yn in
            [Yy]* ) 
                return $TRUE;
                break;;
            [Nn]* ) 
                return $FALSE;
                break;;
            * ) 
                echo "Please enter yes or no."
                echo "You have entered: $yn";;
        esac
    done
}

echo "Checking rigths"
if [[ $EUID -ne 0 ]]
then
    echo "It is recommended that this script is launched with administator rights."
    echo "If you wish to proceed, the rights will be asked at the step when required."
    yes_no_question "Do you wish to grant this script administrator rights?"
    USR_ANSW=$?
    if [[ $USR_ANSW -eq $TRUE ]]
    then
        sudo $0
        exit 0
    else
        echo "You have decided to not grant administator rights to the program."
        echo "It will thus ask them when required."
    fi
fi

CSFML_LIBS=/usr/local/lib
CSFML_HEADERS=/usr/local/include/SFML
CSFML_LICENSE=/usr/local/share/CSFML
SFML_LICENSE=/usr/local/share/SFML

echo "Updating dnf's cache"
sudo dnf makecache
echo "Removing the CSFML library"
sudo dnf remove CSFML
echo "Removing the SFML library"
sudo dnf remove SFML
echo "Removing the SFML-devel library"
sudo dnf remove SFML-devel
echo "Removing the systemd-devel library"
sudo dnf remove systemd-devel
echo "Removing the glm-evel.noarch library"
sudo dnf remove glm-devel.noarch
echo "Removing the libX11-devel.x86_64 library"
sudo dnf remove libX11-devel.x86_64
echo "Removing the libxcb-devel.x86_64 library"
sudo dnf remove libxcb-devel.x86_64
echo "Removing the libXrandr-devel.x86_64 library"
sudo dnf remove libXrandr-devel.x86_64
echo "Removing the libgudev-devel.x86_64 library"
sudo dnf remove libgudev-devel.x86_64
echo "Removing the libjpeg-turbo-devel.x86_64 library"
sudo dnf remove libjpeg-turbo-devel.x86_64
echo "Removing the libogg-devel.x86_64 library"
sudo dnf remove libogg-devel.x86_64
echo "Removing the libvorbis-devel.x86_64 library"
sudo dnf remove libvorbis-devel.x86_64
echo "Removing the xcb-util-devel.x86_64 library"
sudo dnf remove xcb-util-devel.x86_64
echo "Removing the xcb-util-image-devel.x86_64 library"
sudo dnf remove xcb-util-image-devel.x86_64
echo "Removing the mesa-libGL-devel library"
sudo dnf remove mesa-libGL-devel
echo "Removing the mesa-libEGL-devel library"
sudo dnf remove mesa-libEGL-devel
echo "Removing the openal-soft-devel.x86_64 library"
sudo dnf remove openal-soft-devel.x86_64
echo "Removing the freetype-devel.x86_64 library"
sudo dnf remove freetype-devel.x86_64
echo "Removing the flac-devel.x86_64 library"
sudo dnf remove flac-devel.x86_64
echo "Removing the CSFML documentation"
sudo dnf remove CSFML-doc.noarch
echo "Removing $CSFML_LIBS/libc_graph_prog.so"
sudo rm -rf $CSFML_LIBS/libc_graph_prog.so
echo "Removing $CSFML_LIBS/libcsfml-network.a"
sudo rm -rf $CSFML_LIBS/libcsfml-network.a
echo "Removing $CSFML_LIBS/libsfml-graphics-s.a"
sudo rm -rf $CSFML_LIBS/libsfml-graphics-s.a
echo "Removing $CSFML_LIBS/libcsfml-system.a"
sudo rm -rf $CSFML_LIBS/libcsfml-system.a
echo "Removing $CSFML_LIBS/libsfml-network-s.a"
sudo rm -rf $CSFML_LIBS/libsfml-network-s.a
echo "Removing $CSFML_LIBS/libcsfml-audio.a"
sudo rm -rf $CSFML_LIBS/libcsfml-audio.a
echo "Removing $CSFML_LIBS/libcsfml-window.a"
sudo rm -rf $CSFML_LIBS/libcsfml-window.a
echo "Removing $CSFML_LIBS/libsfml-system-s.a"
sudo rm -rf $CSFML_LIBS/libsfml-system-s.a
echo "Removing $CSFML_LIBS/libcsfml-graphics.a"
sudo rm -rf $CSFML_LIBS/libcsfml-graphics.a
echo "Removing $CSFML_LIBS/libsfml-audio-s.a"
sudo rm -rf $CSFML_LIBS/libsfml-audio-s.a
echo "Removing $CSFML_LIBS/libsfml-window-s.a"
sudo rm -rf $CSFML_LIBS/libsfml-window-s.a
echo "Removing $CSFML_LIBS/cmake/SFML"
sudo rm -rf $CSFML_LIBS/cmake/SFML
echo "Removing $CSFML_LIBS/pkgconfig/sfml-all.pc"
sudo rm -rf $CSFML_LIBS/pkgconfig/sfml-all.pc
echo "Removing $CSFML_LIBS/pkgconfig/sfml-graphics.pc"
sudo rm -rf $CSFML_LIBS/pkgconfig/sfml-graphics.pc
echo "Removing $CSFML_LIBS/pkgconfig/sfml-system.pc"
sudo rm -rf $CSFML_LIBS/pkgconfig/sfml-system.pc
echo "Removing $CSFML_LIBS/pkgconfig/sfml-audio.pc"
sudo rm -rf $CSFML_LIBS/pkgconfig/sfml-audio.pc
echo "Removing $CSFML_LIBS/pkgconfig/sfml-network.pc"
sudo rm -rf $CSFML_LIBS/pkgconfig/sfml-network.pc
echo "Removing $CSFML_LIBS/pkgconfig/sfml-window.pc"
sudo rm -rf $CSFML_LIBS/pkgconfig/sfml-window.pc
echo "Removing $CSFML_HEADERS/Audio.h"
sudo rm -rf $CSFML_HEADERS/Audio.h
echo "Removing $CSFML_HEADERS/Audio"
sudo rm -rf $CSFML_HEADERS/Audio
echo "Removing $CSFML_HEADERS/Config.hpp"
sudo rm -rf $CSFML_HEADERS/Config.hpp
echo "Removing $CSFML_HEADERS/Graphics.h"
sudo rm -rf $CSFML_HEADERS/Graphics.h
echo "Removing $CSFML_HEADERS/Network.h"
sudo rm -rf $CSFML_HEADERS/Network.h
echo "Removing $CSFML_HEADERS/System"
sudo rm -rf $CSFML_HEADERS/System
echo "Removing $CSFML_HEADERS/Window.h"
sudo rm -rf $CSFML_HEADERS/Window.h
echo "Removing $CSFML_HEADERS/GPUPreference.h"
sudo rm -rf $CSFML_HEADERS/GPUPreference.h
echo "Removing $CSFML_HEADERS/Graphics.hpp"
sudo rm -rf $CSFML_HEADERS/Graphics.hpp
echo "Removing $CSFML_HEADERS/Network.hpp"
sudo rm -rf $CSFML_HEADERS/Network.hpp
echo "Removing $CSFML_HEADERS/System.h"
sudo rm -rf $CSFML_HEADERS/System.h
echo "Removing $CSFML_HEADERS/Window.hpp"
sudo rm -rf $CSFML_HEADERS/Window.hpp
echo "Removing $CSFML_HEADERS/Audio.hpp"
sudo rm -rf $CSFML_HEADERS/Audio.hpp
echo "Removing $CSFML_HEADERS/GpuPreference.hpp"
sudo rm -rf $CSFML_HEADERS/GpuPreference.hpp
echo "Removing $CSFML_HEADERS/Main.hpp"
sudo rm -rf $CSFML_HEADERS/Main.hpp
echo "Removing $CSFML_HEADERS/OpenGL.h"
sudo rm -rf $CSFML_HEADERS/OpenGL.h
echo "Removing $CSFML_HEADERS/System.hpp"
sudo rm -rf $CSFML_HEADERS/System.hpp
echo "Removing $CSFML_HEADERS/Config.h"
sudo rm -rf $CSFML_HEADERS/Config.h
echo "Removing $CSFML_HEADERS/Graphics"
sudo rm -rf $CSFML_HEADERS/Graphics
echo "Removing $CSFML_HEADERS/Network"
sudo rm -rf $CSFML_HEADERS/Network
echo "Removing $CSFML_HEADERS/OpenGL.hpp"
sudo rm -rf $CSFML_HEADERS/OpenGL.hpp
echo "Removing $CSFML_HEADERS/Window"
sudo rm -rf $CSFML_HEADERS/Window
echo "Removing $CSFML_HEADERS"
sudo rm -rf $CSFML_HEADERS
echo "Removing $CSFML_LICENSE/license.txt"
sudo rm -rf $CSFML_LICENSE/license.txt
echo "Removing $CSFML_LICENSE/readme.txt"
sudo rm -rf $CSFML_LICENSE/readme.txt
echo "Removing $CSFML_LICENSE"
sudo rm -rf $CSFML_LICENSE
echo "Removing $SFML_LICENSE/license.md"
sudo rm -rf $SFML_LICENSE/license.md
echo "Removing $SFML_LICENSE/readme.md"
sudo rm -rf $SFML_LICENSE/readme.md
echo "Removing $SFML_LICENSE"
sudo rm -rf $SFML_LICENSE
echo "Removing /usr/share/SFML/"
sudo rm -rf /usr/share/SFML/
echo "Removing /etc/ld.so.conf.d/csfml.conf"
sudo rm -rf /etc/ld.so.conf.d/csfml.conf
echo "Running ldconfig"
sudo ldconfig

echo "This script was written by (c) Henry Letellier"
