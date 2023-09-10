#!/bin/bash
###########################
#
# Automatic backup script. 
# Used with cron
# need install notify-send to receibe desktop notification
# Example: ./backupTar.sh ORIGEM DESTINATION NAME
#
###########################

ORIGEM=$1
DESTINO=$2
NOME=$3
LOG_FILE=(/var/log/backup/"$NOME.full.log")

mkdir /var/log/backup >> /dev/null 2>&1
touch "$LOG_FILE"

notify-send "Backup '$ORIGEM' iniciado"

echo "Backup Iniciado" >> "$LOG_FILE"
date >> "$LOG_FILE"

if [ "$ORIGEM" == "" -o "$DESTINO" == "" -o "$NOME" == "" ]; then
        echo "Ferramenta de backup"
        echo "Uso Origem Destino Nome"
        echo -e "Erro: Script sem argumentos\nUso Origem Destino Nome\nBackup NOK
        " >>  "$LOG_FILE"
        exit 1
  fi

if [ ! -d "$ORIGEM" ]; then

        echo "Erro:Pasta de origem \"$ORIGEM\" inexistente" >> "$LOG_FILE"
        exit 1
fi

if [ ! -d "$DESTINO" ]; then

        echo "Erro: Pasta de destino \"$DESTINO\" inexistente" >> "$LOG_FILE"
        exit 1
fi

tar -cvpf "$DESTINO$NOME.$(date +%Y%m%d).tar" "$ORIGEM"  >> "$LOG_FILE" 2>&1
       if [[ $? = 0 ]]; then
               echo "Backup OK" >> "$LOG_FILE"
               notify-send "Backup '$ORIGEM' Finalizado"
       else
               echo "Backup NOK" >> "$LOG_FILE"
               notify-send "Erro ao fazer backup '$ORIGEM'"
       fi

echo "Limpando arquivos de backup antigos" >> "$LOG_FILE"
find "$DESTINO" -iname "*.tar" -mtime +3 -exec gio trash {} \;  >> $LOG_FILE 2>&1

date >> "$LOG_FILE"
