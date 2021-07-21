FROM registry.cn-qingdao.aliyuncs.com/x-lab/kvm-base:v1.0.0 

COPY ./scripts /

COPY startup.sh /startapp.sh
