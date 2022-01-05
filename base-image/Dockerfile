FROM domistyle/idrac6

MAINTAINER zhangdahai

COPY icedtea-7-plugin_1.5-1ubuntu1_amd64.deb /usr/lib/jvm/icedtea/icedtea-7-plugin_1.5-1ubuntu1_amd64.deb
COPY icedtea-netx_1.5-1ubuntu1_amd64.deb /usr/lib/jvm/icedtea/icedtea-netx_1.5-1ubuntu1_amd64.deb
COPY icedtea-netx-common_1.5-1ubuntu1_all.deb /usr/lib/jvm/icedtea/icedtea-netx-common_1.5-1ubuntu1_all.deb


RUN apt-get update && \
apt-get install -y vim net-tools && \
apt-get install -y ipmitool && \
apt-get install -y curl nodejs

RUN dpkg -i /usr/lib/jvm/icedtea/icedtea-netx-common_1.5-1ubuntu1_all.deb
RUN dpkg -i /usr/lib/jvm/icedtea/icedtea-netx_1.5-1ubuntu1_amd64.deb
RUN dpkg -i /usr/lib/jvm/icedtea/icedtea-7-plugin_1.5-1ubuntu1_amd64.deb

RUN sed -i '701,705d' /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security ; \
    sed -i 's|jdk.tls.disabledAlgorithms|# jdk.tls.disabledAlgorithms|g' /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security