#!/bin/bash

# Set BMC info

HOST=${HOST}
USER=${USER}
PASSWD=${PASSWD}
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

getIdracVersion(){
	firm_version=`ipmitool -I lanplus -H ${HOST} -U ${USER} -P ${PASSWD} mc info | grep "Firmware Revision" | awk -F ':' '{printf $NF}' | xargs`
	if [ -z "$firm_version" ];then
		echo "get idrac version faild , no ipmi response [mc info]"
		exit 1
	fi

	if [[ $firm_version == 1* ]];then
		version="idrac7"
	elif [[ $firm_version == 2* ]];then
		version="idrac8"
	else
		version="idrac9"
	fi
	echo $version	
}

getIdracVersion


# Login to BMC WEB Server to Get JNLP 

GET_COOKIEURL="https://${HOST}/data/login"
PAYLOAD="user=${USER}&password=${PASSWD}"

GET_COOKIE=`curl -i -k -X POST -d "${PAYLOAD}" "${GET_COOKIEURL}"`

if [ -z "$GET_COOKIE" ];then
	echo "failed to login to BMC: https://${HOST}"
	exit 1
fi

SESSION=`echo "$GET_COOKIE" | grep -e "Cookie:[^;]\+" | awk -F ' ' '{print $2}'`
ST1=`echo "$GET_COOKIE" | grep ST1 | awk -F 'ST1=' '{print $2}' | awk -F ',ST2' '{print $1}'| xargs` 
ST2=`echo "$GET_COOKIE" | grep ST2 | awk -F 'ST2=' '{print $2}' | awk -F '</forwardUrl>' '{printf $1}' | xargs`

if [ -z $SESSION ];then
	echo "cannot get sesion_cookie from response : $SESSION"
	exit 1
fi

MIS=`date +%s`
wget -O /app/jviewer.jnlp --no-check-certificate --header="Cookie:$SESSION" --header="ST2:$ST2" "https://${HOST}/viewer.jnlp(${HOST}@0@ssasa@${MIS}@ST1=$ST1)"

if [ -f /app/jviewer.jnlp ];then
	chmod +x /app/jviewer.jnlp
fi
javaws /app/jviewer.jnlp
