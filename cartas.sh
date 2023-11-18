#!/bin/bash
source ./decoracion.sh

declare -A corazon
corazon=([1]='1♥' [2]='2♥' [3]='3♥' [4]='4♥' [5]='5♥' [6]='6♥' [7]='7♥' [8]='8♥' [9]='9♥' [10]='10♥' [11]='11♥' [12]='12♥')

declare -A picas
pica=([1]='1♠' [2]='2♠' [3]='3♠' [4]='4♠' [5]='5♠' [6]='6♠' [7]='7♠' [8]='8♠' [9]='9♠' [10]='10♠' [11]='11♠' [12]='12♠')

declare -A rombos
rombo=([1]='1♦' [2]='2♦' [3]='3♦' [4]='4♦' [5]='5♦' [6]='6♦' [7]='7♦' [8]='8♦' [9]='9♦' [10]='10♦' [11]='11♦' [12]='12♦')

declare -A trebol
trebol=([1]='1♣' [2]='2♣' [3]='3♣' [4]='4♣' [5]='5♣' [6]='6♣' [7]='7♣' [8]='8♣' [9]='9♣' [10]='10♣' [11]='11♣' [12]='12♣')

declare -A barajas
barajas=([1]='corazon' [2]='pica' [3]='rombo' [4]='trebol')

sacar_carta(){
    # Extrae una carta aleatoria de las 4 barajas y la elimina.

    n_baraja=$(($RANDOM%3))
    n_baraja=$(($n_baraja + 1))
    n_baraja=${barajas[$((n_baraja))]}


    n=$(($RANDOM%11))
    n=$(($n + 1))
    
    if [[ $n_baraja = 'corazon' ]]
    then
        echo ${corazon[$n]}
    elif [[ $n_baraja = 'pica' ]]
    then
        echo ${pica[$n]}
    elif [[ $n_baraja = 'rombo' ]]
    then
        echo ${rombo[$n]}
    elif [[ $n_baraja = 'trebol' ]]
    then
        echo ${trebol[$n]}
    fi


    unset $n_baraja[$n]

}

extrae_puntos(){

    # Extrae la puntuación de las cartas, pasando por ejemplo de '3♥' a 3. 
    # Siendo 10, 11 y 12 igual a 10 puntos

    if [[ ${#carta} = 2 ]]
        then
            echo ${carta: 0: 1}
        elif [[ ${#carta} = 3 ]]
        then
            echo 10
    fi
}

comprobar_blackjack(){
    # Le pasas un array y comprueba si ha conseguido blackjack con 2 cartas. Un as y una carta mayor de 10.

    declare -a compatibles
    compatibles=(1 10)
    match=0

    for x in "${compatibles[@]}"
    do
        for i in "${puntosBanca[@]}"
        do
            if [[ $(($x)) -eq $(($i)) ]]
            then
                ((match++))
                unset compatibles[0]
                break
            fi
        done
    done
    if [[ $(($match)) -eq 2 ]]
    then
        echo ""
        echo -e "\e[1;32m----- LA BANCA HA CONSEGUIDO BLACKJACK. -----\n\e[0m"
        banca="BLACKJACK"
    fi
}

comprobar_blackjack_jugador(){
    # Le pasas un array y comprueba si ha conseguido blackjack con 2 cartas. Un as y una carta mayor de 10.

    declare -a compatibles2
    compatibles2=(1 10)
    match=0
    for x in "${compatibles2[@]}"
    do
        for i in "${puntosJugadorParaBlackjack[@]}"
        do
            if [[ $(($x)) -eq $(($i)) ]]
            then
                ((match++))
                unset compatibles2[0]
                break
            fi
        done
    done
    if [[ $(($match)) -eq 2 ]]
    then
        echo ""
        echo -e "\e[1;32m----- HAS CONSEGUIDO BLACKJACK. -----\n\e[0m"
        puntosJugador="BLACKJACK"
    fi
}
comprobar_17_banca(){
# Sacar otra carta para la banca si la puntuacion es menor de 17

 if [[ $(($banca)) -le 17 ]] 
    then
        carta=$(sacar_carta)
        cartasBanca=("${cartasBanca[@]}" $carta)
        punto=$(extrae_puntos $carta)
        banca=$(( banca + punto ))
        ((n_cartas_banca++))
        echo -e "\e[1;36mLa Banca saca otra carta... \c"
        for ((i=1;i<=n_cartas_banca;i++));do echo -e "\e[1;31m|*| \c";done
        echo -e "${cartasBanca[1]} \n\e[0m"
    fi
    read -p "Pulsa intro para continuar."
    mesa_repartida $cartasJugador $cartasBanca
}