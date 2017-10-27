#!/bin/bash

cd /home/container
if [ -f "/home/container/server" ]; then
    echo "To update ragemp. Please delete ragemp."
    chmod +x /home/container/server
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ./server"
    touch /home/container/conf.json
    echo '{
            "maxplayers" : 100,
            "name" : "RAGE:MP Unofficial server - New Server, Change my name - Powered by GameNode.Pro",
            "gamemode" : "freeroam",
            "streamdistance" : 500.0,
            "announce" : false,
            "port": '+${SERVER_PORT}+'
    }' > /home/container/conf.json
    set -e
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
    exec ${MODIFIED_STARTUP} -n -t -u
  else 
    echo "Updating mtasa. Please do not kill this process."
    wget http://static-cdn.gamenode.pro/installation/ragemp/latest.php -P /home/container -O server
    chmod +x /home/container/server
    echo "Done updating ragemp. Starting..";
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
    echo ":/home/container$ ${MODIFIED_STARTUP}"
    set -e
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
    exec ${MODIFIED_STARTUP} -n -t -u
fi
