#!/bin/bash
 
# Set BMC info
 
HOST=${HOST}
USER=${USER}
PASSWD=${PASSWD}
export DISPLAY_WIDTH=1280
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
 
        if [ "$firm_version" = "7.20" ];then
                version="sr650"
        fi
        echo $version   
}
 
getIdracVersion
 
 
# Login to BMC WEB Server to Get JNLP 
 
GET_TOKENURL="https://${HOST}/api/login"
JSON='{
        "username": "'${USER}'",
        "password": "'${PASSWD}'"
      }'

GET_TOKEN=`curl  -k -X POST -d "${JSON}" ${GET_TOKENURL}  --header "Content-Type: application/json"`

if [ -z "$GET_TOKEN" ];then
        echo "failed to login to BMC: https://${HOST}"
        exit 1
fi
 
TOKEN_SESSION=`echo ${GET_TOKEN}|sed 's/\"//g'|awk -F':' '{print $2}'|sed 's/}//g'`

if [ -z $TOKEN_SESSION ];then
        echo "cannot get sesion_cookie from response : $TOKEN_SESSION"
        exit 1
fi
verty_url="https://${HOST}/api/providers/rp_jnlp"
DOWN_JAVA_CLIENT="https://${HOST}/download/rp.jnlp"
verty_result=`curl -s -k -H "Authorization: Bearer ${TOKEN_SESSION}"  ${verty_url}`
result=`echo ${verty_result}|awk -F',' '{print $1}'|awk -F':' '{print $2}'|sed 's/ //g'`

if [ "$result" = "0" ];then
   curl -s -k -H "Authorization: Bearer ${TOKEN_SESSION}"  ${DOWN_JAVA_CLIENT} > /app/jviewer.jnlp
fi
if [ -f /app/jviewer.jnlp ];then
        chmod +x /app/jviewer.jnlp
fi
javaws /app/jviewer.jnlp
