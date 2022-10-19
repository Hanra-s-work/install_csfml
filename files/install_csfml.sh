#!/bin/bash
SCRIPT_SRC="https://github.com/Pakkro/install-csfml"
GITHUB_GABRIEL="https://github.com/gabrielhamel"
GITHUB_HENRY="https://github.com/HenraL"
TEST_CODE="https://github.com/Hanra-s-work/install_csfml/blob/main/files/test_code/test_code.zip?raw=true"
ZIP_NAME="test_code.zip"
TRUE=1
FALSE=0
CSFML_TEST_FILE=test.c
PACKAGE_MANAGER=dnf
# Inherited variables from the original script

GRAPH_LIB_NAME="libc_graph_prog.so"

SFML_SOURCE_URL="https://www.sfml-dev.org/files/SFML-2.5.1-sources.zip"
CSFML_SOURCE_URL="https://www.sfml-dev.org/files/CSFML-2.5.1-sources.zip"

CSFML_ZIP="CSFML.zip"
SFML_ZIP="SFML.zip"

function download_test {
    echo "Downloading test_file"
    echo "Running: curl -Lo $TEST_CODE -o $ZIP_NAME"
    curl -Lo $TEST_CODE -o $ZIP_NAME
    echo "Extracting content"
    echo "Running: unzip -qq -u -d . $ZIP_NAME"
    unzip -qq -u -d . $ZIP_NAME
}

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
#FINAL_BIN=csfml_install.sh
echo "+=======================================================+"
echo "|This code is provided to you as if and without         |"
echo "|any warranty.                                          |"
echo "|                                                       |"
echo "|This code is based on the code that can be found on    |"
echo "|$SCRIPT_SRC                |"
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
echo "|Gabriel's github link: $GITHUB_GABRIEL |"
echo "|This script was written by: (c)Henry Letellier(@HenraL)|"
echo "|Henry's github link: $GITHUB_HENRY         |"
echo "+=======================================================+"
echo ""
echo ""
echo "Refreshing $PACKAGE_MANAGER's package cache"
echo "Running : sudo $PACKAGE_MANAGER makecache"
sudo $PACKAGE_MANAGER makecache
echo "Installing csfml dependencies"
echo "Running : sudo $PACKAGE_MANAGER group intall 'C Development Tools and Libraries'"
sudo $PACKAGE_MANAGER group install "C Development Tools and Libraries"
echo "Running : sudo $PACKAGE_MANAGER install curl patch make cmake SFML SFML-devel systemd-devel gcc-c++ glm-devel.noarch libX11-devel.x86_64 libxcb-devel.x86_64 libXrandr-devel.x86_64 libgudev-devel.x86_64 libjpeg-turbo-devel.x86_64 libogg-devel.x86_64 libvorbis-devel.x86_64 xcb-util-devel.x86_64 xcb-util-image-devel.x86_64 mesa-libGL-devel mesa-libEGL-devel openal-soft-devel.x86_64 freetype-devel.x86_64 flac-devel.x86_64"
sudo $PACKAGE_MANAGER install curl patch make cmake SFML SFML-devel systemd-devel gcc-c++ glm-devel.noarch libX11-devel.x86_64 libxcb-devel.x86_64 libXrandr-devel.x86_64 libgudev-devel.x86_64 libjpeg-turbo-devel.x86_64 libogg-devel.x86_64 libvorbis-devel.x86_64 xcb-util-devel.x86_64 xcb-util-image-devel.x86_64 mesa-libGL-devel mesa-libEGL-devel openal-soft-devel.x86_64 freetype-devel.x86_64 flac-devel.x86_64
echo ""
echo "Attempting to install the csfml library from $PACKAGE_MANAGER"
echo "Running : sudo $PACKAGE_MANAGER install CSFML-devel.x86_64"
sudo $PACKAGE_MANAGER install CSFML-devel.x86_64
compile_test $CSFML_TEST_FILE
EXECUTION_RESULT=$?
if [ $EXECUTION_RESULT -eq $FALSE ]
then
    echo "Installing SFML and CSFML sources"
    echo "Download SFML Sources"
    echo "Running: curl -Lo '$SFML_ZIP' $SFML_SOURCE_URL"
    curl -Lo "$SFML_ZIP" $SFML_SOURCE_URL
    echo "Download CSFML Sources"
    echo "Running: curl -Lo '$CSFML_ZIP' $CSFML_SOURCE_URL"
    curl -Lo "$CSFML_ZIP" $CSFML_SOURCE_URL
    echo ""
    echo "Downloading test code"
    download_test
    echo ""
    echo "Unpacking ressources"
    echo "Unzip SFML"
    echo "Running: unzip -qq -o $SFML_ZIP" 
    unzip -qq -o $SFML_ZIP
    echo "Unzip CSFML"
    echo "Running: unzip -qq -o $CSFML_ZIP"
    unzip -qq -o $CSFML_ZIP
    echo ""
    echo "Renaming the ressources"
    echo "Renaming SFML-2.5.1 to SFML"
    mv SFML-* SFML
    echo "Renaming CSFML-2.5.1 to CSFML"
    mv CSFML-* CSFML
    echo ""
    echo "Converting the relative paths to full paths"
    echo "Running: SFML_PATH=\"\$(pwd)/SFML\""
    SFML_PATH="$(pwd)/SFML"
    echo "Running: CSFML_PATH=\"\$(pwd)/CSFML\""
    CSFML_PATH="$(pwd)/CSFML"
    echo ""
    echo ""
    echo "Compiling the SFML library"
    echo "Entering the SFML folder"
    cd SFML
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
    # WARNING - END OF PATCH
    echo "Building SFML"
    echo "Running: cmake -DBUILD_SHARED_LIBS=False -DCMAKE_CXX_FLAGS=\"-fPIC\" ."
    cmake -DBUILD_SHARED_LIBS=False -DCMAKE_CXX_FLAGS="-fPIC" .
    echo "Compiling SFML"
    echo "Running: make"
    make
    echo "Installing SFML"
    echo "Running make install"
    make install
    echo "Exciting the SFML folder"
    echo "Running: cd .."
    cd ..
    echo ""
    echo ""
    echo "Compiling the CSFML library"
    echo "Displaying the path"
    echo "Running: echo \$SFML_PATH"
    echo $SFML_PATH
    echo "Accessing the folder"
    echo "Running: cd CSFML"
    cd CSFML
    echo ""
    echo "Building CSFML"
    echo "Running: cmake -DCMAKE_CXX_FLAGS=\"-fPIC\" -DSFML_STATIC_LIBRARIES=TRUE -DBUILD_SHARED_LIBS=False -DSFML_ROOT=\"\$SFML_PATH\" -DSFML_INCLUDE_DIR=\"\$SFML_PATH/include\" -DCMAKE_MODULE_PATH=\"\$SFML_PATH/cmake/Modules\" ."
    cmake -DCMAKE_CXX_FLAGS="-fPIC" -DSFML_STATIC_LIBRARIES=TRUE -DBUILD_SHARED_LIBS=False -DSFML_ROOT="$SFML_PATH" -DSFML_INCLUDE_DIR="$SFML_PATH/include" -DCMAKE_MODULE_PATH="$SFML_PATH/cmake/Modules" .
    echo "Assining the \$SFML_PATH/lib to LD_LIBRARY_PATH"
    echo "Running: LD_LIBRARY_PATH=\"\$SFML_PATH/lib\""
    LD_LIBRARY_PATH="$SFML_PATH/lib"
    echo "Compiling CSFML"
    echo "Running: make"
    make
    echo "Installing CSFML"
    echo "Running: make install"
    make install
    echo "Exiting the CSFML folder"
    echo "Running: cd .."
    cd ..
    echo ""
    echo ""
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
    -lxcb-randr -lXext -lgcc_s -lgcc
    "
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
    echo ""
    echo ""
    echo "Adding the CSFML library to the library list"
    echo "Running: sudo cp \$GRAPH_LIB_NAME /usr/local/lib/."
    sudo cp $GRAPH_LIB_NAME /usr/local/lib/
    echo "Adding the path to the library to the csfml configuration file"
    echo "Running: sudo echo \"/usr/local/lib/\" > /etc/ld.so.conf.d/csfml.conf"
    sudo echo "/usr/local/lib/" > /etc/ld.so.conf.d/csfml.conf
    echo ""
    echo ""
    # Update the Dynamic Linker Run Time Bindings
    echo "Updating the Dynamic Linker Run Time Bindings"
    echo "Running: sudo ldconfig"
    sudo ldconfig
    echo ""
    echo ""
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
    compile_test $CSFML_TEST_FILE
fi
echo "Installing csfml documentations"
echo "Runing: sudo $PACKAGE_MANAGER install CSFML CSFML-doc"
sudo $PACKAGE_MANAGER install CSFML-doc
