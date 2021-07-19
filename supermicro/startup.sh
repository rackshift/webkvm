#!/bin/bash

# Set BMC info

HOST=${HOST}
USER=${USER}
PASSWD=${PASSWD}
export DISPLAY_WIDTH=1024
export DISPLAY_HEIGHT=800

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

GET_COOKIEURL="https://${HOST}/cgi/login.cgi"
PAYLOAD="name=${USER}&pwd=${PASSWD}"

GET_COOKIE=`curl -i -k -X POST -d "${PAYLOAD}" "${GET_COOKIEURL}"`

if [ -z "$GET_COOKIE" ];then
	echo "failed to login to BMC: https://${HOST}"
	exit 1
fi

SESSION=`echo "$GET_COOKIE" | grep -e "SID=[^;]\+" | awk -F ' ' '{print $2}'`

if [ -z $SESSION ];then
	echo "cannot get sesion_cookie from response : $SESSION"
	exit 1
fi

wget -O /app/jviewer.jnlp --tries=2 --no-check-certificate --header "Cookie:${SESSION};" "https://${HOST}/cgi/url_redirect.cgi?url_name=ikvm&url_type=jwsk" 

if [ -f /jviewer.jnlp ];then
	chmod +x /app/jviewer.jnlp
fi
javaws /app/jviewer.jnlp
