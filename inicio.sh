#!/bin/bash

source ./bj.sh
resize -s 45 59 >/dev/null

respuesta="Y"

while true
do
    if [[ $respuesta == "Y" ]]
    then
        blackjack
        read -p "¿Quieres jugar de nuevo? (Y/N)" respuesta
    elif [[ $respuesta == "E" ]]
    then
        read -p "¿Quieres jugar de nuevo? (Y/N)" respuesta
    elif [[ $respuesta == "N" ]]
    then
        clear
        echo -e "\n\e[1;36mBye.\n\e[0m"
        sleep 2
        exit
    else
        echo "Respuesta incorrecta."
        respuesta="E"
    fi
done