FROM domistyle/idrac6

MAINTAINER zhangdahai

RUN apt-get update && \
apt-get install -y vim net-tools && \
apt-get install -y icedtea-netx && \
apt-get install -y ipmitool && \
apt-get install -y curl nodejs

RUN sed -i '701,705d' /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security ; \
    sed -i 's|jdk.tls.disabledAlgorithms|# jdk.tls.disabledAlgorithms|g' /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security
