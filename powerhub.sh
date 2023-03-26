#!/bin/bash

if [[ $(uname -s) == Linux ]]
then
    HOST_IP=$(ifconfig eth0 | awk '/ *inet /{print $2}')
    echo "detected host ip: $HOST_IP"
else
    HOST_IP=$(ifconfig en0 | awk '/ *inet /{print $2}')
    echo "detected host ip: $HOST_IP"
fi

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

AUTH=${AUTH:-powerhub:powerhub}
LHOST=${LHOST:-0.0.0.0}
LPORT=${LPORT:-8080}
SSL_PORT=${SSL_PORT:-8443}
FLASK_PORT=${FLASH_PORT:-3000}
WEBDAV_PORT=${WEBDAV_PORT:-5001}
WEBDAV_AUTH=${WEBDAV_AUTH:-powerhub:powerhub}
URI_HOST=${URI_HOST:-$HOST_IP}
URI_PORT=${URI_PORT:-$SSL_PORT}
URI_PATH=${URI_PATH:-''}

docker run -it --rm \
    -p $LPORT:$LPORT -p $SSL_PORT:$SSL_PORT -p $FLASK_PORT:$FLASK_PORT -p $WEBDAV_PORT:$WEBDAV_PORT \
    -e AUTH=$AUTH -e LHOST=$LHOST -e LPORT=$LPORT -e SSL_PORT=$SSL_PORT -e FLASK_PORT=$FLASK_PORT -e WEBDAV_PORT=$WEBDAV_PORT -e WEBDAV_AUTH=$WEBDAV_AUTH -e URI_HOST=$URI_HOST -e URI_PORT=$URI_PORT -e URI_PATH=$URI_PATH \
    -v ${PWD}/data:/root/.local/share/powerhub/ \
    isaudits/powerhub /bin/bash