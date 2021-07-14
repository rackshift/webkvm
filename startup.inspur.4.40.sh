#!/bin/bash

# Set BMC info

HOST=${HOST}
USER=${USER}
PASSWD=${PASSWD}

if [ -z "$HOST" ];then
	echo please set "HOST" environment !
	exit 1
fi

if [ -z "$USER" ];then
	echo please set "USER" environment !
fi

if [ -z "$PASSWD" ];then
echo please set "PASSWD" enviroment !
fi


# Login to BMC WEB Server to Get JNLP 

GET_COOKIEURL="https://${HOST}/rpc/WEBSES/create.asp"
PAYLOAD="WEBVAR_USERNAME=${USER}&WEBVAR_PASSWORD=${PASSWD}"

GET_COOKIE=`curl -i -k -X POST -H \'Content-type\':\'application/json\' -d "${PAYLOAD}" "${GET_COOKIEURL}"`

if [ -z "$GET_COOKIE" ];then
	echo "failed to login to BMC: https://${HOST}"
	exit 1
fi

SESSION=`echo "$GET_COOKIE" | grep SESSION_COOKIE | awk -F "'" '{print $4}'`

if [ -z $SESSION ];then
	echo "cannot get sesion_cookie from response : $response"
	exit 1
fi

wget -O /app/jviewer.jnlp --tries=2 --no-check-certificate --header "Cookie:SessionCookie=${SESSION};" "https://${HOST}/Java/jviewer.jnlp?EXTRNIP=${HOST}&JNLPSTR=JViewer"

if [ -f /jviewer.jnlp ];then
	chmod +x /app/jviewer.jnlp
fi
javaws /app/jviewer.jnlp
