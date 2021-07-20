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


#Base64 encode

USER=`echo -n $USER | base64 | base64`
PASSWD=`echo -n $PASSWD | base64 | base64`

# Login to BMC WEB Server to Get JNLP 

GET_COOKIEURL="https://${HOST}/api/session"
PAYLOAD="username=${USER}&password=${PASSWD}&log_type=1"

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

#GET jnlp token
TOKEN_RES=`curl -i -k -X GET -H "Cookie:$SESSION;" -H "X-CSRFTOKEN:$CSRF" "https://${HOST}/api/kvm/token"`
TOKEN=`echo $TOKEN_RES | awk -F 'token' '{print $2}' | awk -F '"' '{printf $3}'`
SESSION=`echo "$SESSION" | awk -F ';' '{printf $1}' | awk -F 'QSESSIONID=' '{print $2}'`

sed -i "s/\${HOST}/${HOST}/g" /app/jviewer-template.jnlp
sed -i "s/\${TOKEN}/${TOKEN}/g" /app/jviewer-template.jnlp
sed -i "s/\${SESSION}/${SESSION}/g" /app/jviewer-template.jnlp

mv /app/jviewer-template.jnlp /app/jviewer.jnlp

if [ -f /jviewer.jnlp ];then
	chmod +x /app/jviewer.jnlp
fi
javaws /app/jviewer.jnlp
