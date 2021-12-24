# RackShift 远程 WEBKVM
## 使用方法（IDRAC8）
```
docker run -d -p 5800:5800 -e VENDOR=DELL -e HOST=xxx -e USER=xxx -e PASSWD=xxx -e APP_NAME=IDRAC8 registry.cn-qingdao.aliyuncs.com/x-lab/kvm:v1.0.0
```
直接打开 http://ip:5800
其中 VENDOR 支持的参数为：Inspur,DELL,H3C,Supermicro,Suma

# 已支持的机型
| 品牌 | BMC 版本 |
| :-----| :----- | 
| 浪潮 | 4.40 | 
| 曙光 | 1.80 |
| 华3 | 1.30 |
| 超微 | 1.71 |
| DELL | 2.50 IDRAC8 等同 |
| 联想 | 1.72 |
其他不支持的版本欢迎提交  ISSUE

# 效果图
![runnob](https://fit2cloud2-offline-installer.oss-cn-beijing.aliyuncs.com/rackshift/img/webkvm.png)
