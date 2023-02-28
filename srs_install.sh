#!/bin/bash
# Codice di Giacomo Radaelli

INSTALLDIR="srs_server"

if [ -d $INSTALLDIR ]; then
    echo "$INSTALLDIR esiste. Si presuppone che il server sia già installato e funzionante"
    echo "Se vuoi ricostruire il server cancella la cartella srs_server, o apri il file e copia la parte tra ***"
else
    # Download e costruzione
    # ***
    mkdir $INSTALLDIR && cd $INSTALLDIR
    echo "CLONANDO SRS (PESO STIMATO 250MB, PROCEDURA LENTA)"
    git clone -b develop https://github.com/ossrs/srs.git
    cd srs/trunk
    ./configure
    make
    # ***
fi

cd $INSTALLDIR
cd srs/trunk
pwd
./objs/srs -c conf/srs.conf
echo STATO DI SRS:
./etc/init.d/srs status
