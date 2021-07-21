# RackShift 远程 WEBKVM
## 使用方法（IDRAC8）
```
docker run -d -p 5803:5800 -e HOST=xxx -e USER=xxx -e PASSWD=xxx -e APP_NAME=IDRAC8 registry.cn-qingdao.aliyuncs.com/x-lab/kvm-dell:v1.0.0
```
# 已支持的机型
| 品牌 | 镜像 |
| :-----| :----- | 
| 浪潮 | registry.cn-qingdao.aliyuncs.com/x-lab/kvm-inspur:v1.0.0 | 
| 曙光 | registry.cn-qingdao.aliyuncs.com/x-lab/kvm-sugo:v1.0.0 |
| 华3 | registry.cn-qingdao.aliyuncs.com/x-lab/kvm-h3c:v1.0.0 |
| 超微 | registry.cn-qingdao.aliyuncs.com/x-lab/kvm-supermicro:v1.0.0 |
| DELL | registry.cn-qingdao.aliyuncs.com/x-lab/kvm-dell:v1.0.0 |
