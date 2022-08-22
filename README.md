# install_csfml
This is yet again another iteration of the epitech csfml script to install the csfml bindings.

## How to install the csfml binging
download the script `install_csfml.sh` or `install_cleaned.sh`
Open a terminal in the location in wich you have downloaded the script
If you have downloaded `install_csfml.sh`:
  enter this command: `chmod +x install_csfml.sh && sudo ./install_csfml.sh`
If you have downloaded `install_cleaned.sh`:
  enter this command: `chmod +x install_cleaned.sh && sudo ./install_cleaned.sh`

In either case, this will grant execution rigths to the script (before the `&&`) as well as run it (after the `&&`).

## Important
Please make sure you have administator rights.
Please also make sure that you keep an active internet connection throuought the installation.
If you are running on a non dnf based package manager, please note that you can change your manager by editing the field of this variable: `PACKAGE_MANAGER`
  However, I strongly reccomend you check the availability and names of the packages required by CSFML in your package manager (just take the package name and use the search option of your package manager)
  Ex: for dnf it is `dnf search <package-name>`, for apt (or apt-get) it is `apt search <package-name>`

## How the script works:
1. The script will display it's startup message
2. It will then start downloading required dependencies like curl or make (required to compile C)
3. It will download a test code (a program I wrote in csfml to be used as a proof that the language is installed)
4. The script will install the CSFML documentation
5. It will try and install the CSFML-devel package (most reliable)
6. The script will compile and run the test program to check the status of the installation
7. Depending on the status of the installation
    1. If the installation is successefull, the program will display a goodbye message and exit
    2. If the installation was a failure, it will thus try and install it by compiling it's source code
8. In the end, regardless of the status of this installation (that will be given when testing the status), the program will display a goodbye message and exit.


## Disclaimer
This program is provided as if and without any Warranty
Quoting the authors is appreciated

## Uninstalling CSFML
To uninstall the CSFML library, download the `uninstall_csfml.sh`
Open a terminal in the folder in wich it is located
enter `chmod +x uninstall_csfml.sh && sudo ./uninstall_csfml.sh`

## Authors
This program was created by [(c) Henry Letellier (@HenraL)](https://github.com/HenraL)\
The original source code used was created by [@gabrielhamel](https://github.com/gabrielhamel)
