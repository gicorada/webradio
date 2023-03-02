#!/bin/bash
# Codice di Giacomo Radaelli

INSTALLDIR="srs_installation"
cd ~ || exit

if [ -d $INSTALLDIR ]; then
    echo "La cartella $INSTALLDIR esiste. Si presuppone che il server sia già installato e funzionante"
    echo "Se vuoi ricostruire il server cancella la cartella srs_server, o apri il file e copia la parte tra ***"
    
    cd $INSTALLDIR || exit
    cd srs/trunk || exit
    ./objs/srs -c conf/srs.conf
    echo STATO DI SRS:
    ./etc/init.d/srs status
else
    echo "Sembra che srs non sia ancora stato installato. Installare?"
    read -r -s -p $'Premi Enter per installare\n' -d $'\n'
    # Download e costruzione
    # ***
    mkdir $INSTALLDIR && cd $INSTALLDIR || exit
    echo "CLONANDO SRS (PESO STIMATO 250MB, PROCEDURA LENTA)"
    git clone -b develop https://github.com/ossrs/srs.git
    cd srs/trunk || exit
    ./configure
    make
    # ***
    
    echo "Riesegui questo programma per avviare il server"
fi


