#!/bin/bash

lineaCian="\e[1;36m---------------------------------------------------------\e[0m"

lineaBajaCian="\e[1;36m_________________________________________________________"

lineaPuntosCian="\e[1;36m.........................................................\e[0m"

lineaEspaciosCian="\e[1;36m|                                                         |\e[0m"

fVerLinea="\e[1;35;40m"
fVerCar="\e[1;31;40m"
fVerNom="\e[1;36;40m"
finFondo="\e[0m"

cabecera() {
    clear
    echo -e " $lineaBajaCian"
    echo -e   "$lineaEspaciosCian"
    echo -e   "$lineaEspaciosCian"
    echo -e   "\e[1;36m|                        BLACKJACK                        |\e[0m"
    echo -e   "$lineaEspaciosCian"
    echo -e   "\e[1;36m|$lineaBajaCian|\e[0m"
    echo ""    
}

barajando(){
    echo ""
    echo -e   "\e[1;36mBarajando......\e[0m"
    sleep 1
    echo -e $lineaPuntosCian
    sleep 1
    echo -e "$lineaPuntosCian\n"
    sleep 2
}


mesa_presentacion(){
    clear
    echo -e "\n$fVerLinea _________________________________________________________ "
    echo -e "|     _______       ____________________      _______     |"
    echo -e "|    |       |     |                    |    |       |    |"
    echo -e "|    |  /\   |     |       $fVerNom BANCA $fVerLinea      |    |   /\  |    |"
    echo -e "|    | /  \  |     |                    |    |  /  \ |    |"
    echo -e "|    |/ /\ \ |     |         $fVerCar|*|$fVerLinea        |    | / /\ \|    |"
    echo -e "|    | /__\ \|     |                    |    |/ /__\ |    |"
    echo -e "|    |       |     |                    |    |       |    |"
    echo -e "|    | DEALER|     |                    |    |       |    |"
    echo -e "|    |_______|     |____________________|    |_______|    |"
    echo -e "|                                                         |"
    echo -e "|                                                         |"
    echo -e "|                |¯¯¯¯¯¯¯|    |¯¯¯¯¯¯¯|                   |"
    echo -e "|                |       |    |       |                   |"
    echo -e "|                |  /\   |    |   /\  |                   |"
    echo -e "|                | /  \  |    |  /  \ |                   |"
    echo -e "|                |/ /\ \ |    | / /\ \|                   |"
    echo -e "|                | /__\ \|    |/ /__\ |                   |"
    echo -e "|                |_______|    |_______|                   |"
    echo -e "|                                                         |"
    echo -e "|                                                         |"
    echo -e "|        ___________________    ___________________       |"
    echo -e "|       |                   |  |                   |      |"
    printf  "|       |    1 $fVerNom%-9s$fVerLinea    |  |     Jugador 2     |      |\n" $jugador 
    echo -e "|       |                   |  |                   |      |"
    echo -e "|       |                   |  |                   |      |"
    echo -e "|       |                   |  |                   |      |"
    echo -e "|       |___________________|  |___________________|      |"
    echo -e "|                                                         |"
    echo -e "|_________________________________________________________|$finFondo"
    barajando

}
mostrar_linea(){
    for ((i=0;i<${#linea[@]};i++));do printf "$fVerCar |%5s|" ${linea[i]};done
}
mostrar_linea2(){
    for ((i=0;i<${#linea2[@]};i++));do printf "$fVerCar|%5s|" ${linea2[i]};done
}
mesa_repartida(){
    clear
    declare -a linea
    declare -a linea2
    if [[ $((${#cartasJugador[@]})) -lt 3 ]]
    then
        linea=${cartasJugador[@]}

    else
        for ((i=0;i<${#cartasJugador[@]};i++))
        do 
            if [[ $(($i)) -lt 3 ]]
            then
                linea=("${linea[@]}" ${cartasJugador[i]})
            else
                linea2=("${linea2[@]}" ${cartasJugador[i]}) 
            fi
        done
    fi

    echo -e "$fVerLinea _________________________________________________________ "
    echo -e "|     _______       ____________________      _______     |"
    echo -e "|    |       |     |                    |    |       |    |"
    echo -e "|    |  /\   |     |       $fVerNom BANCA $fVerLinea      |    |   /\  |    |"
    echo -e "|    | /  \  |     |                    |    |  /  \ |    |"
    echo -e "|    |/ /\ \ |     |        $fVerCar |*| $fVerLinea       |    | / /\ \|    |"
    echo -e "|    | /__\ \|     |                    |    |/ /__\ |    |"
    
    if [[ $((${#cartasBanca[@]})) -eq 3 ]]
    then
        echo -e "|    |       |     |   \c"
        printf "$fVerCar|*| |*| |%5s|    $fVerLinea|    |       |    |\n" ${cartasBanca[1]}
    elif [[ $((${#cartasBanca[@]})) -eq 4 ]]
    then
        echo -e "|    |       |     | \c"
        printf "$fVerCar|*| |*| |*| |%5s|  $fVerLinea|    |       |    |\n" ${cartasBanca[1]}
    else
    echo -e "|    |       |     |      \c"
    printf "$fVerCar|*| |%5s|     $fVerLinea|    |       |    |\n" ${cartasBanca[1]}
    fi
    echo -e "|    | DEALER|     |                    |    |       |    |"
    echo -e "|    |_______|     |____________________|    |_______|    |"
    echo -e "|                                                         |"
    echo -e "|                                                         |"
    echo -e "|                |¯¯¯¯¯¯¯|    |¯¯¯¯¯¯¯|                   |"
    echo -e "|                |       |    |       |                   |"
    echo -e "|                |  /\   |    |   /\  |                   |"
    echo -e "|                | /  \  |    |  /  \ |                   |"
    echo -e "|                |/ /\ \ |    | / /\ \|                   |"
    echo -e "|                | /__\ \|    |/ /__\ |                   |"
    echo -e "|                |_______|    |_______|                   |"
    echo -e "|                                                         |"
    echo -e "|                                                         |"
    echo -e "|        ___________________    ___________________       |"
    echo -e "|       |                   |  |                   |      |"
    printf  "|       |    1 $fVerNom%-9s $fVerLinea   |  |     Jugador 2     |      |\n" $jugador 
    echo -e "|       |                   |  |                   |      |"
    if [[ $((${#cartasJugador[@]})) -lt 3 ]]
    then
        echo -e "|       |   \c"
        mostrar_linea $linea
        echo -e "$fVerLinea    |  |                   |      |"
    elif [[ $((${#cartasJugador[@]})) -eq 3 ]]
    then
        echo -e "|       |\c"
        mostrar_linea $linea
        echo -e "$fVerLinea |  |                   |      |"
    elif [[ $((${#cartasJugador[@]})) -eq 4 ]]
    then
        echo -e "|       |\c"
        mostrar_linea $linea
        echo -e "$fVerLinea |  |                   |      |"
        echo -e "|       | \c"
        mostrar_linea2 $linea2
        echo -e "$fVerLinea             |  |                   |      |"
    elif [[ $((${#cartasJugador[@]})) -eq 5 ]]
    then
        echo -e "|       |\c"
        mostrar_linea $linea
        echo -e "$fVerLinea |  |                   |      |"
        echo -e "|       | \c"
        mostrar_linea2 $linea2
        echo -e "$fVerLinea        |  |                   |      |"
    elif [[ $((${#cartasJugador[@]})) -eq 6 ]]
    then
        echo -e "|       |\c"
        mostrar_linea $linea
        echo -e "$fVerLinea |  |                   |      |"
        echo -e "|       | \c"
        mostrar_linea2 $linea2
        echo -e "$fVerLinea|  |                   |      |"
    fi
    echo -e "|       |                   |  |                   |      |"
    echo -e "|       |___________________|  |___________________|      |"
    echo -e "|                                                         |"
    echo -e "|_________________________________________________________|\e[0m"
}

puntuacion(){
    echo ""
    echo -e   "\e[1;36mCalculando puntuación......\n\e[0m"
    sleep 2
    mostrar_resultado $banca $cartasBanca
    mostrar_resultado_jugador $puntosJugador $jugador $cartasJugador
}

mostrar_resultado(){
    if [[ $banca == "BLACKJACK" ]]
    then
        echo -e "\e[0;36mLA \e[0;35mBANCA\e[0;36m TIENE \e[1;31m$banca.\e[0m"
        echo -e "\e[1;31m ${cartasBanca[@]} \n\e[0m"
    else
        echo -e "\e[0;36mPuntuación de la \e[0;35mBANCA\e[0;36m, \e[1;31m$banca \e[0;36mpuntos.\e[0m"
        echo -e "\e[1;31m ${cartasBanca[@]} \n\e[0m"
    fi
}
mostrar_resultado_jugador(){
    if [[ $puntosJugador == "BLACKJACK" ]]
    then
        echo -e "\e[0;36mEL \e[0;35mJUGADOR $jugador\e[0;36m TIENE \e[1;31m$puntosJugador.\e[0m"
        echo -e "\e[1;31m ${cartasJugador[@]} \n\e[0m"
    else
        echo -e "\e[0;36mJugador \e[0;35m$jugador\e[0;36m, \e[1;31m${puntosJugador} \e[0;36mpuntos.\e[0m"
        echo -e "\e[1;31m ${cartasJugador[@]} \n\e[0m"
    fi
}

plantarse(){
    echo -e "\e[1;36mTe has plantado. Se procederá a calcular la puntuación.\n\e[0m"
    sleep 2
}

pasar(){
    echo -e "\e[1;36mHas pasado de esta ronda.\n\e[0m"
    sleep 2
}