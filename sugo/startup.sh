#!/bin/bash

# Set BMC info

HOST=${HOST}
USER=`node /app/encrypt.js ${USER} 16| xargs`
PASSWD=`node /app/encrypt.js ${PASSWD} | xargs`
export DISPLAY_WIDTH=1024
export DISPLAY_HEIGHT=768

if [ -z "$HOST" ];then
	echo please set "HOST" environment !
	exit 1
fi

if [ -z "$USER" ];then
	echo please set "USER" environment !
	exit 1
fi

if [ -z "$PASSWD" ];then
	echo please set "PASSWD" enviroment !
	exit 1
fi

# Login to BMC WEB Server to Get JNLP 

GET_COOKIEURL="https://${HOST}/api/secure_session"
PAYLOAD="username=${USER}&password=${PASSWD}"

GET_COOKIE=`curl -i -k -X POST -d "${PAYLOAD}" "${GET_COOKIEURL}"`

if [ -z "$GET_COOKIE" ];then
	echo "failed to login to BMC: https://${HOST}"
	exit 1
fi

SESSION=`echo "$GET_COOKIE" | grep -e "QSESSIONID=[^;]\+" | awk -F ' ' '{print $2}'`
CSRF=`echo "$GET_COOKIE" | awk -F 'CSRFToken'  '{print $2}' | awk -F ' ' '{print $2}' | awk -F '"' '{printf $2}'`

if [ -z $SESSION ];then
	echo "cannot get sesion_cookie from response : $SESSION"
	exit 1
fi

wget -O /app/jviewer.jnlp --no-check-certificate --header="Cookie:$SESSION" --header="X-CSRFTOKEN:$CSRF" "https://${HOST}/api/kvmjnlp?&JNLPSTR=JViewer&locale=root"

if [ -f /app/jviewer.jnlp ];then
	chmod +x /app/jviewer.jnlp
fi
javaws /app/jviewer.jnlp
