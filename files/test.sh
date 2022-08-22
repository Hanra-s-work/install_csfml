#!/bin/bash
##
## EPITECH PROJECT, 2022
## csfml_installation
## File description:
## test.sh
##

# if [[ $EUID -ne 0 ]]; then
#     while true; do
#         read -p "Do you wish to install this program? [(Y)es/(n)o]: " yn
#         case $yn in
#             [Yy]* ) make install; break;;
#             [Nn]* ) exit;;
#             * ) echo "Please answer yes or no.";;
#         esac
#     done
#     exit 1
# fi


TRUE=1
FALSE=0

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

yes_no_question "hhhhhhh"
E=$?
echo "response: $E"
