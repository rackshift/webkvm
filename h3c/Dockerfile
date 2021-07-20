FROM domistyle/idrac6

MAINTAINER zhangdahai

RUN apt-get update && \
apt-get install -y vim net-tools && \
apt-get install -y icedtea-netx && \
apt-get install -y curl

COPY jviewer-template.jnlp /app
COPY startup.sh /startapp.sh
