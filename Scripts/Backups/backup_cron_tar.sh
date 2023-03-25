#!/bin/bash
###########################
#
# Automatic backup script. 
# Used with cron
# need install notify-send to receibe desktop notification
# Example: ./backupRsync.sh ORIGEM DESTINATION NAME
#
###########################

ORIGEM=$1
DESTINO=$2
NOME=$3
LOG_FILE=(/var/log/backup/$NOME.log)

mkdir /var/log/backup >> /dev/null 2>&1
touch $LOG_FILE

notify-send "Backup '$ORIGEM' iniciado"

if [ "$ORIGEM" == "" -o "$DESTINO" == "" -o "$NOME" == "" ]; then
        echo "Ferramenta de backup"
        echo "Uso Origem Destino Nome"
        echo -e "Erro: Script sem argumentos\nUso Origem Destino Nome\nBackup NOK
        " >  $LOG_FILE
        exit 1
  fi

if [ ! -d $ORIGEM ]; then

        echo "Erro:Pasta de origem \"$ORIGEM\" inexistente" > $LOG_FILE
        exit 1
fi

if [ ! -d $DESTINO ]; then
        echo "Erro: Pasta de destino \"$DESTINO\" inexistente" > $LOG_FILE
        exit 1
fi

rsync -avP --delete $ORIGEM $DESTINO  > $LOG_FILE 2>&1
        if [[ $? = 0 ]]; then
                echo "Backup OK" >> $LOG_FILE
                notify-send "Backup '$ORIGEM' Finalizado"
        else
                echo "Backup NOK" >> $LOG_FILE
                notify-send "Erro ao fazer backup '$ORIGEM'"
        fi

date >> $LOG_FILE
