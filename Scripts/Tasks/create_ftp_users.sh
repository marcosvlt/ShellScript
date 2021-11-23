#!/bin/bash
###########################
#
# Create ftp users and folders
# Example: ./create_ftp_users.sh list.txt
# list.txt uses csv
# Example: user,senha123
# Author: github.com/marcosvlt
#
###########################

LIST="$(cat "$1")"
LOG_FILE="/var/log/createFtpUsers.log"
FTP_USER_FILE="/etc/FTP.userlist"

################
# functions    #
################

err() {

  logger -s "$1" 2>> "$LOG_FILE"
  
}

create_log_file()
{

        touch "$LOG_FILE" >> "$LOG_FILE" 2>&1
        chmod 666 "$LOG_FILE" >> "$LOG_FILE" 2>&1

}

create_user()
{

        if [ ! -f "$FTP_USER_FILE" ]; then
            err "$FTP_USER_FILE don't exist."
            exit 1
        else

        logger -s "creating user: $1" 2>> $LOG_FILE
        useradd "$1" >> "$LOG_FILE" 2>&1 && echo "$1:$2" | chpasswd >> "$LOG_FILE" 2>&1 && \
        echo "$1" >> "$FTP_USER_FILE"

        fi

}

create_dirs()
{
        logger -s "creating Dirs: $1" 2>> $LOG_FILE && \
        mkdir -v /home/$1 >> $LOG_FILE 2>&1

}

backups()
{

        cp "$FTP_USER_FILE" "$FTP_USER_FILE"-"$(date +'%Y-%m-%d_%H%M')" >> $LOG_FILE 2>&1
}

main()
{

        if ! create_log_file; then
                err "Unable to create_log_file"
                exit 1
        fi

        if ! backups; then
                err "Unable to backups"
                exit 1
        fi

        for user in $LIST
            do
                USER=$(echo "$user" | awk -F ',' '{print $1}')
                PASSWORD=$(echo "$user" | awk -F ',' '{print $2}')

                if [[ "${USER}" == "root" ]]; then
                                err "Invalid user"
                                exit 1

                        else

                        if ! create_user "$USER" "$PASSWORD"; then
                                err "Unable to create_user"
                                exit 1
                        fi

                        if ! create_dirs "$USER"; then
                                err "Unable to create_dirs"
                                exit 1
                        fi

                        fi

            done
  }

main
