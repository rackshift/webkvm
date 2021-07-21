# webkvm

# RackShift 远程 WEBKVM 镜像实现
## 使用方法（IDRAC8）
```
	docker run -d -p 5803:5800 -e HOST=xxx -e USER=xxx -e PASSWD=xxx -e APP_NAME=idrac8 registry.cn-qingdao.aliyuncs.com/x-lab/kvm-dell:v1.0.0
```
# 已支持的机型
<table>
	<th>
	<td>品牌</td>
	<td>镜像</td>
	</th>
	<tr>
	<td>浪潮</td>
	<td>registry.cn-qingdao.aliyuncs.com/x-lab/kvm-inspur:v1.0.0</td>
	</tr>
	
	<tr>
	<td>曙光</td>
	<td>registry.cn-qingdao.aliyuncs.com/x-lab/kvm-sugo:v1.0.0</td>
	</tr>
	
	<tr>
	<td>华3</td>
	<td>registry.cn-qingdao.aliyuncs.com/x-lab/kvm-h3c:v1.0.0</td>
	</tr>
	
	<tr>
	<td>超微</td>
	<td>registry.cn-qingdao.aliyuncs.com/x-lab/kvm-supermicro:v1.0.0</td>
	</tr>
	
	<tr>
	<td>dell</td>
	<td>registry.cn-qingdao.aliyuncs.com/x-lab/kvm-dell:v1.0.0</td>
	</tr>
	
	
</table>
