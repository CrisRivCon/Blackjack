#!/bin/bash

source ./cartas.sh
source ./decoracion.sh


blackjack(){
    clear
    cabecera
    while true; 
    do
        read -p "Nombre del jugador? (Máx 8 car) " jugador

    if [[ $jugador == "" ]]
    then
        echo "Debes introducir un nombre (Máx 8 car)."
    else
        break
    fi

    done

    jugador=${jugador:0:8}
    mesa_presentacion $jugador


    #-----------------------REPARTIENDO CARTAS-------------------------
    # Cartas para la banca

    banca=0
    declare -a cartasBanca
    declare -a puntosBanca

    for ((i=1;i<=2;i++))
    do

        carta=$(sacar_carta)
        cartasBanca=("${cartasBanca[@]}" $carta)
        punto=$(extrae_puntos $carta)
        banca=$(( banca + punto ))
        puntosBanca=("${puntosBanca[@]}" $punto)

    done

    echo -e   "\e[1;36mPara la Banca......\e[0m \e[1;31m|*| $carta \n\e[0m"
    sleep 2

    # Cartas para el jugador

    declare -A puntos
    puntosJugador=0
    declare -a cartasJugador
    declare -a puntosJugadorParaBlackjack

    for ((i=1;i<=2;i++))
    do

        carta=$(sacar_carta)
        cartasJugador=("${cartasJugador[@]}" $carta)
        punto=$(extrae_puntos $carta)
        puntosJugador=$((puntosJugador + $punto))
        puntosJugadorParaBlackjack=("${puntosJugadorParaBlackjack[@]}" $punto)
    done

    echo -e   "\e[1;36mTus cartas.........\e[0m\e[1;31m ${cartasJugador[@]}\n \e[0m"
    sleep 2
    mesa_repartida $cartasJugador $cartasBanca
    comprobar_blackjack $puntosBanca
    comprobar_blackjack_jugador $puntosJugadorParaBlackjack

    # -- Despues de repartir las cartas iniciales, se da la opción de coger otra carta o pasar.
    n_cartas_banca=1

    while true; do
        if [[ $((${puntosJugador})) -gt $((21)) ]]
        then
            opcion="l"
        elif [[ $banca == "BLACKJACK" ]] || [[ $puntosJugador == "BLACKJACK" ]]
        then
            opcion="bw"
        elif [[ $(($banca)) -gt $((21)) ]]
        then
            opcion="bp"
        else
            echo -e "$lineaPuntosCian\n"
            echo -e "\e[1;36mCarta, te plantas o pasa (c, tp, p): \e[0m"
            read opcion
            echo ""
        fi

        case $opcion in
                c )
                    carta=$(sacar_carta)

                    cartasJugador=("${cartasJugador[@]}" $carta)
                    punto=$(extrae_puntos $carta)
                    puntosJugador=$((${puntosJugador[@]} + $punto))

                    echo -e "\e[1;36mTus cartas... \e[1;31m${cartasJugador[@]} \n\e[0m"

                    comprobar_17_banca $banca $cartasBanca $n_cartas_banca
                    ;;
                tp )
                    comprobar_17_banca $banca $cartasBanca $n_cartas_banca
                    plantarse
                    puntuacion $banca $cartasBanca $puntosJugador $jugador $cartasJugador
                    break
                    ;;
                p )
                    pasar
                    comprobar_17_banca $banca $cartasBanca $n_cartas_banca
                    ;;
                l )
                    puntuacion $banca $cartasBanca $puntosJugador $jugador $cartasJugador
                    echo -e "\e[1;32m\n----- Te has pasado paquete, has perdido. -----\n\e[0m"
                    break
                    ;;
                bp )
                    puntuacion $banca $cartasBanca $puntosJugador $jugador $cartasJugador
                    echo -e "\e[1;32m\n----- La banca pierde. -----\n\e[0m"
                    break
                    ;;
                bw )
                    puntuacion $banca $cartasBanca $puntosJugador $jugador $cartasJugador
                    break
                    ;;
                miau )
                    echo "Los gatos no juegan al blackjack...."
                    break
                    ;;
                * )
                    echo "Opción incorrecta"
                    ;;
        esac
    done
}
