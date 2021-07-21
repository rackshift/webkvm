FROM registry.cn-qingdao.aliyuncs.com/x-lab/kvm-base:v1.0.0 

RUN apt-get install -y nodejs

ADD * /

COPY startup.sh /startapp.sh
