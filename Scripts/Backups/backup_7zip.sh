#!/bin/bash
###########################
#
# Automatic backup script. 
# Used with cron
# need install notify-send to receibe desktop notification
# need install p7zip
# Example: ./backup7zip.sh ORIGEM DESTINATION NAME
#
###########################

ORIGEM=$1
DESTINO=$2
NOME=$3
LOG_FILE=(/var/log/backup/"$NOME.log")

# Secure password on shell script
# Encrypt a password with openssl and save the password on .pass.enc in a security folder with the decryption password in the file .pass.temp
# This way the password and the decryption password are not on the script
PASS=$(cat .pass.enc | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"cat .pass.temp")

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


7z a  -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p''$PASS''  "$DESTINO$NOME.$(date +%Y%m%d).7z" "$ORIGEM" >> "$LOG_FILE" 2>&1
       if [[ $? = 0 ]]; then
               echo "Backup OK" >> "$LOG_FILE"
               notify-send "Backup '$ORIGEM' Finalizado"
       else
               echo "Backup NOK" >> "$LOG_FILE"
               notify-send "Erro ao fazer backup '$ORIGEM'"
       fi

echo "Limpando arquivos de backup antigos" >> "$LOG_FILE"
find "$DESTINO" -iname "*.7z" -mtime +5 -exec gio trash {} \;  >> "$LOG_FILE" 2>&1

date >> "$LOG_FILE"
