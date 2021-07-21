FROM registry.cn-qingdao.aliyuncs.com/x-lab/kvm-base:v1.0.0 

RUN apt-get install -y nodejs

COPY ./scripts /

COPY startup.sh /startapp.sh
