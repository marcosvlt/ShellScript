#!/bin/bash
# Script to check numbers of databases
# Author https://github.com/marcosvlt
# 11/2020 - V.0.2
# ###################################


BANCOS=$(mysql -P3306 -USER -p'PASSWORD' -e "select count(*) from information_schema.SCHEMATA;" | grep -v  count)
OK_NUMBER=100
WARNING=200
if [ "$?" -eq 0 ]; then


        if [ "$BANCOS" -lt "$OK_NUMBER" ]; then
              
              echo -e "OK - Numero de Banco de Dados. $BANCOS "

        elif [ "$BANCOS" -ge "$OK_NUMBER" ] && [ "$BANCOS" -lt "$WARNING" ]; then
              
                echo  "Warning - Numero de Banco de Dados: $BANCOS"
          else
              
                echo  "Critical - Numero de Banco de Dados: $BANCOS"
        fi

else

        
        echo "Critical - Problema de conexão  no script de verificação"

fi

exit $STATUS
