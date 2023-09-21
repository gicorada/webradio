#!/bin/bash
# Codice di Giacomo Radaelli

INSTALLDIR="$HOME/srs_installation"

clone_srs () {
    echo "Clonando il repo github di SRS, potrebbe metterci del tempo..."

    mkdir "$INSTALLDIR" && cd "$_" || exit
    git clone -b develop https://github.com/ossrs/srs.git
}

make_srs () {
    echo "Costruzione di SRS in corso"

    cd "$INSTALLDIR/srs/trunk" || exit
    ./configure
    make >/dev/null || make

    echo "SRS è stato costruito"
}

run_srs () {
    echo "Eseguendo l'installazione di SRS contenuta in $INSTALLDIR"

    cd "$INSTALLDIR/srs/trunk" || exit
    ./objs/srs -c conf/srs.conf
    echo STATO DI SRS:
    ./etc/init.d/srs status
}


echo -e "\033[1;31;1m--- Directory di installazione corrente: $INSTALLDIR ---\nPer cambiare directory di installazione, modifica la dichiarazione alla riga 4 di questo file\033[0m"

if [[ $1 == "run" ]] # Comando completo, installa e costruisce se necessario prima di eseguire
then
    if [[ -d "$INSTALLDIR/objs" ]]
    then
        run_srs

    elif [[ -d "$INSTALLDIR" ]]
    then
        read -r -p "Sembra che SRS sia stato scaricato ma non installato. Installare? [S/n] " response
        if [[ $response =~ ^([sS])$ ]]
        then
            make_srs
        fi
        echo "Riesegui questo script con l'argomento run per avviare srs"

    else
        read -r -p "SRS non è ancora stato scaricato. Vuoi scaricare SRS da github? [S/n] " response
        if [[ $response =~ ^([sS])$ ]]
        then
            clone_srs
            make_srs
        fi
        echo "Riesegui questo script con l'argomento run per avviare srs"
    fi
elif [[ $1 == "install" ]] # Comando di installazione completa
then
    clone_srs
    make_srs
elif [[ "$1" == "clone" ]] # Comando di cloning del repo git
then
    clone_srs
elif [[ "$1" == "build" ]] # Comando per costruire il server dal codice sorgente scaricato
then
    if [[ ! -d "$INSTALLDIR" ]]
    then
        make_srs
    else
        echo "Devi eseguire prima il comando \"clone\" per poter costruire SRS"
    fi
elif [[ "$1" == "remove" ]]
then
    echo "Rimozione cartelle SRS in corso..."
    rm -rf "$HOME/srs_installation"
    echo "Cartelle rimosse"
fi