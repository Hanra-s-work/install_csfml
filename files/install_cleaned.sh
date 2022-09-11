#!/bin/bash
##
## EPITECH PROJECT, 2022
## csfml_installation
## File description:
## install_cleaned.sh
##

PACKAGE_MANAGER=dnf

SCRIPT_SRC="https://github.com/Pakkro/install-csfml"
GITHUB_GABRIEL="https://github.com/gabrielhamel"
GITHUB_HENRY="https://github.com/HenraL"
TEST_CODE="https://github.com/Hanra-s-work/install_csfml/blob/main/files/test_code/test_code.zip?raw=true"
ZIP_NAME="test_code.zip"
TRUE=1
FALSE=0
SFML_PATH=""
CSFML_PATH=""
CSFML_PATCH=""
LD_LIBRARY_PATH=""
CSFML_TEST_FILE=test.c
# Inherited variables from the original script

GRAPH_LIB_NAME="libc_graph_prog.so"

SFML_SOURCE_URL="https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip"
CSFML_SOURCE_URL="https://www.sfml-dev.org/files/CSFML-2.5.1-sources.zip"

CSFML_ZIP="CSFML.zip"
SFML_ZIP="SFML.zip"


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

function function_is_admin {
    if [[ $EUID -ne 0 ]]
    then
        echo "It is recommended that this script is launched with administator rights."
        echo "If you wish to proceed, the rights will be asked at the step when required."
        yes_no_question "Do you wish to grant this script administrator rights?"
        USR_ANSW=$?
        if [[ $USR_ANSW -eq $TRUE ]]
        then
            sudo $1
            exit 0
        else
            echo "You have decided to not grant administator rights to the program."
            echo "It will thus ask them when required."
        fi
    fi
}

function download_test {
    echo "Downloading test_file"
    echo "Running: curl -Lo $TEST_CODE -o $ZIP_NAME"
    curl -Lo $TEST_CODE -o $ZIP_NAME
    echo "Extracting content"
    echo "Running: unzip -qq -u -d . $ZIP_NAME"
    unzip -qq -u -d . $ZIP_NAME
}

function give_credits {
    echo "+=======================================================+"
    echo "|This code is provided to you as if and without         |"
    echo "|any warranty.                                          |"
    echo "|                                                       |"
    echo "|This code is based on the code that can be found on    |"
    echo "|$1                |"
    echo "|The original code has some issues that occured with    |"
    echo "|time (some libraries were outdated causing             |"
    echo "|the installation to fail). It is thus normal that there|"
    echo "|will be a lot of similarities between the original code|"
    echo "|and this one.                                          |"
    echo "|                                                       |"
    echo "|I have also updated the csfml package version.         |"
    echo "|The original script would download the version 2.3.1   |"
    echo "|This script will download the version 2.5.1            |"
    echo "|                                                       |"
    echo "|The original code was created by: gabrielhamel         |"
    echo "|Gabriel's github link: $2 |"
    echo "|This script was written by: (c)Henry Letellier(@HenraL)|"
    echo "|Henry's github link: $3         |"
    echo "+=======================================================+"

}

function refresh_package_cache {
    echo "Refreshing $1's package cache"
    echo "Running : sudo $1 makecache"
    sudo $1 makecache
}

function install_requirements {
    echo "Installing csfml dependencies"
    echo "Running : sudo $1 group intall 'C Development Tools and Libraries'"
    sudo $1 group install "C Development Tools and Libraries"
    echo "Running : sudo $1 install curl patch make cmake SFML SFML-devel systemd-devel gcc-c++ glm-devel.noarch libX11-devel libxcb-devel libXrandr-devel libgudev-devel libjpeg-turbo-devel libogg-devel libvorbis-devel xcb-util-devel xcb-util-image-devel mesa-libGL-devel mesa-libEGL-devel openal-soft-devel freetype-devel flac-devel"
    sudo $1 install curl patch make cmake SFML SFML-devel systemd-devel gcc-c++ glm-devel.noarch libX11-devel libxcb-devel libXrandr-devel libgudev-devel libjpeg-turbo-devel libogg-devel libvorbis-devel xcb-util-devel xcb-util-image-devel mesa-libGL-devel mesa-libEGL-devel openal-soft-devel freetype-devel flac-devel
}

function install_CSFML_devel {
    echo "Attempting to install the csfml library from $1"
    echo "Running : sudo $1 install CSFML-devel"
    sudo $1 install CSFML-devel
}

function download_sources {
    echo "Installing SFML and CSFML sources"
    echo "Download SFML Sources"
    echo "Running: curl -Lo '$SFML_ZIP' $SFML_SOURCE_URL"
    curl -Lo "$SFML_ZIP" $SFML_SOURCE_URL
    echo "Download CSFML Sources"
    echo "Running: curl -Lo '$CSFML_ZIP' $CSFML_SOURCE_URL"
    curl -Lo "$CSFML_ZIP" $CSFML_SOURCE_URL
}

function unpack_ressources {
    echo "Unpacking ressources"
    echo "Unzip SFML"
    echo "Running: unzip -qq -o $SFML_ZIP" 
    unzip -qq -o $SFML_ZIP
    echo "Unzip CSFML"
    echo "Running: unzip -qq -o $CSFML_ZIP"
    unzip -qq -o $CSFML_ZIP
}

function rename_ressources {
    echo "Renaming the ressources"
    echo "Renaming SFML-2.5.1 to SFML"
    mv SFML-* SFML
    echo "Renaming CSFML-2.5.1 to CSFML"
    mv CSFML-* CSFML
}

function convert_relative_paths {
    echo "Converting the relative paths to full paths"
    echo "Running: SFML_PATH=\"\$(pwd)/SFML\""
    SFML_PATH="$(pwd)/SFML"
    echo "Running: CSFML_PATH=\"\$(pwd)/CSFML\""
    CSFML_PATH="$(pwd)/CSFML"
}

function prep_source {
    download_sources
    echo ""
    unpack_ressources
    echo ""
    rename_ressources
    echo ""
    convert_relative_paths
    echo ""
    echo ""
}

function apply_patch {
    echo "Applying patch for SFML"
    echo "Check the code to see the patch, to big to display"
    # WARNING - START PATCH FOR __cpu_model symbol problem
    echo "PATCH SFML CMake to fix a problem with __cpu_model"
    CSFML_PATCH='
diff --git a/src/SFML/Graphics/CMakeLists.txt b/src/SFML/Graphics/CMakeLists.txt
index 6f02fb6..61638d2 100644
--- a/src/SFML/Graphics/CMakeLists.txt
+++ b/src/SFML/Graphics/CMakeLists.txt
@@ -150,6 +150,10 @@ if(SFML_COMPILER_GCC)
    set_source_files_properties(${SRCROOT}/ImageLoader.cpp PROPERTIES COMPILE_FLAGS -fno-strict-aliasing)
endif()

+if (SFML_COMPILER_GCC)
+    list(APPEND GRAPHICS_EXT_LIBS "-lgcc_s -lgcc")
+endif()
+
# define the sfml-graphics target
sfml_add_library(sfml-graphics
                SOURCES ${SRC} ${DRAWABLES_SRC} ${RENDER_TEXTURE_SRC} ${STB_SRC}
'
    echo "Adding the patch to the patch variable"
    echo "Running: patch -p1 <<< \$(echo \"\$CSFML_PATCH\")"
    patch -p1 <<< $(echo "$CSFML_PATCH")
}

function cmake_SFML {
    echo "Building SFML"
    echo "Running: cmake -DBUILD_SHARED_LIBS=False -DCMAKE_CXX_FLAGS=\"-fPIC\" ."
    cmake -DBUILD_SHARED_LIBS=False -DCMAKE_CXX_FLAGS="-fPIC" .
}

function make_SFML {
    echo "Compiling SFML"
    echo "Running: make"
    make
}

function make_install_SFML {
    echo "Installing SFML"
    echo "Running make install"
    make install
}

function compile_SFML {
    echo "Compiling the SFML library"
    echo "Entering the SFML folder"
    cd SFML
    apply_patch
    cmake_SFML
    make_SFML
    make_install_SFML
    echo "Exciting the SFML folder"
    echo "Running: cd .."
    cd ..
}

function cmake_CSFML {
    echo "Building CSFML"
    echo "Running: cmake -DCMAKE_CXX_FLAGS=\"-fPIC\" -DSFML_STATIC_LIBRARIES=TRUE -DBUILD_SHARED_LIBS=False -DSFML_ROOT=\"\$SFML_PATH\" -DSFML_INCLUDE_DIR=\"\$SFML_PATH/include\" -DCMAKE_MODULE_PATH=\"\$SFML_PATH/cmake/Modules\" ."
    cmake -DCMAKE_CXX_FLAGS="-fPIC" -DSFML_STATIC_LIBRARIES=TRUE -DBUILD_SHARED_LIBS=False -DSFML_ROOT="$SFML_PATH" -DSFML_INCLUDE_DIR="$SFML_PATH/include" -DCMAKE_MODULE_PATH="$SFML_PATH/cmake/Modules" .
}

function make_CSFML {
    echo "Compiling CSFML"
    echo "Running: make"
    make
}

function make_install_CSFML {
    echo "Installing CSFML"
    echo "Running: make install"
    make install
}

function compile_CSFML {
    echo "Compiling the CSFML library"
    echo "Displaying the path"
    echo "Running: echo \$SFML_PATH"
    echo $SFML_PATH
    echo "Accessing the folder"
    echo "Running: cd CSFML"
    cd CSFML
    echo ""
    cmake_CSFML
    echo "Assining the \$SFML_PATH/lib to LD_LIBRARY_PATH"
    echo "Running: LD_LIBRARY_PATH=\"\$SFML_PATH/lib\""
    LD_LIBRARY_PATH="$SFML_PATH/lib"
    make_CSFML
    make_install_CSFML
    echo "Exiting the CSFML folder"
    echo "Running: cd .."
    cd ..
}

function compile_both {
    echo "Building the Graphical programming library"
    echo "Running: sudo g++ -Wl,--whole-archive \
 CSFML/lib/libcsfml-audio.a CSFML/lib/libcsfml-graphics.a \
 CSFML/lib/libcsfml-system.a CSFML/lib/libcsfml-window.a \
 CSFML/lib/libcsfml-network.a SFML/lib/libsfml-audio-s.a \
 SFML/lib/libsfml-graphics-s.a SFML/lib/libsfml-system-s.a \
 SFML/lib/libsfml-window-s.a SFML/lib/libsfml-network-s.a \
 -Wl,--no-whole-archive -shared -o $GRAPH_LIB_NAME \
 -lFLAC -lfreetype -lGL -ljpeg \
 -logg -lopenal -lpthread -lrt \
 -ludev -lvorbis -lvorbisenc -lvorbisfile \
 -lX11 -lX11-xcb -lxcb -lxcb-image \
 -lxcb-randr -lXext -lgcc_s -lgcc"
    sudo g++ -Wl,--whole-archive \
            CSFML/lib/libcsfml-audio.a \
            CSFML/lib/libcsfml-graphics.a \
            CSFML/lib/libcsfml-system.a \
            CSFML/lib/libcsfml-window.a \
            CSFML/lib/libcsfml-network.a \
            SFML/lib/libsfml-audio-s.a \
            SFML/lib/libsfml-graphics-s.a \
            SFML/lib/libsfml-system-s.a \
            SFML/lib/libsfml-window-s.a \
            SFML/lib/libsfml-network-s.a \
            -Wl,--no-whole-archive -shared -o $GRAPH_LIB_NAME \
            -lFLAC \
            -lfreetype \
            -lGL \
            -ljpeg \
            -logg \
            -lopenal \
            -lpthread \
            -lrt \
            -ludev \
            -lvorbis \
            -lvorbisenc \
            -lvorbisfile \
            -lX11 \
            -lX11-xcb \
            -lxcb \
            -lxcb-image \
            -lxcb-randr \
            -lXext \
            -lgcc_s \
            -lgcc
}

function apply_changes {
    echo "Adding the CSFML library to the library list"
    echo "Running: sudo cp \$GRAPH_LIB_NAME /usr/local/lib/."
    sudo cp $GRAPH_LIB_NAME /usr/local/lib/
    echo "Adding the path to the library to the csfml configuration file"
    echo "Running: sudo echo \"/usr/local/lib/\" > /etc/ld.so.conf.d/csfml.conf"
    sudo echo "/usr/local/lib/" > /etc/ld.so.conf.d/csfml.conf
}

function update_dynamic_linker {
    # Update the Dynamic Linker Run Time Bindings
    echo "Updating the Dynamic Linker Run Time Bindings"
    echo "Running: sudo ldconfig"
    sudo ldconfig
}

function cleanup {
    echo "Cleaning up"
    echo "Removing: $CSFML_ZIP, $CSFML_PATH, $SFML_ZIP, $SFML_PATH folders"
    echo "Running: sudo rm -rf \"$CSFML_ZIP\""
    sudo rm -rf "$CSFML_ZIP"
    echo "Running: sudo rm -rf \"$CSFML_PATH\""
    sudo rm -rf "$CSFML_PATH"
    echo "Running: sudo rm -rf \"$SFML_ZIP\""
    sudo rm -rf "$SFML_ZIP"
    echo "Running: sudo rm -rf \"$SFML_PATH\""
    sudo rm -rf "$SFML_PATH"
}

function install_documentation {
    echo "Installing csfml documentations"
    echo "Runing: sudo $1 install CSFML CSFML-doc"
    sudo $1 install CSFML-doc
}

function install_from_source { 
    # This option is used when the default install did not work
    prep_source
    compile_SFML
    echo ""
    echo ""
    compile_CSFML
    echo ""
    echo ""
    compile_both
    echo ""
    echo ""
    apply_changes
    echo ""
    echo ""
    update_dynamic_linker
    echo ""
    echo ""
    cleanup
}

function run_file {
    if [ -f "$1" ]
    then
        echo "Running $1 program"
        ./$1
        return $TRUE
    else
        return $FALSE
    fi
}

function compile_test {
    if [ -f "$1" ]
    then
        echo "Compiling test program"
        gcc $1 -lcsfml-graphics -lcsfml-audio -o test.out
        run_file test.out
        RUN_RESULT = $?
        if [ $RUN_RESULT -eq $TRUE ]
        then
            echo "The installation was successefull"
        fi
        return $RUN_RESULT
    else
        echo "file $1 not found, cannot test the status of the installation."
        echo "The program will now end"
        return $TRUE
    fi
}

function goodbye {
    echo "Goodbye, see you next time"
    echo "This script was written by (c) Henry Letellier"
}

echo "Checking rigths"
function_is_admin $0
give_credits $SCRIPT_SRC $GITHUB_GABRIEL $GITHUB_HENRY
echo ""
echo ""
refresh_package_cache $PACKAGE_MANAGER
install_requirements $PACKAGE_MANAGER
echo ""
echo "Downloading test code"
download_test
install_documentation $PACKAGE_MANAGER
install_CSFML_devel $PACKAGE_MANAGER
compile_test $CSFML_TEST_FILE
RUN_STATUS = $?
if [ $RUN_STATUS -eq $FALSE ]
then
    echo "Common installation failed, installing from source"
    install_from_source
    compile_test $CSFML_TEST_FILE
fi
goodbye
