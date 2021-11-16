#!/bin/sh
###########################
#
# Automatic backup script. 
# Used with cron
# Example: ./backup_cron_tar.sh ORIGEM DESTINATION NAME
#
###########################


ORIGEM=$1
DESTINO=$2
NOME=$3
LOG_FILE=(/var/log/backup/$NOME.log)

mkdir /var/log/backup >> /dev/null 2>&1
touch $LOG_FILE

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

tar cvzf  /$DESTINO/$NOME.$(date +%Y%m%d-%H%M%S).tar.gz  $ORIGEM  > $LOG_FILE 2>&1
date >> $LOG_FILE
        if [[ $? = 0 ]]; then
                echo "Backup OK" >> $LOG_FILE
        else
                echo "Backup NOK" >> $LOG_FILE
        fi

# Deleta arquivos com mais de 5 dias
find /$DESTINO/ -mindepth 1 -mtime +5 -delete
