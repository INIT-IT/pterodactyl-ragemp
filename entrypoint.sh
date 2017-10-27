#!/bin/bash

cd /home/container
if [ -f "/home/container/server" ]; then
    echo "To update ragemp. Please delete ragemp."
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ./server"
    set -e
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
    exec ${MODIFIED_STARTUP} -n -t -u
  else 
    echo "Updating mtasa. Please do not kill this process."
    wget http://static-cdn.gamenode.pro/installation/ragemp/latest.php -P /home/container -O server
    echo "Done updating ragemp. Starting..";
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ${MODIFIED_STARTUP}"
    set -e
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
    exec ${MODIFIED_STARTUP} -n -t -u
fi
