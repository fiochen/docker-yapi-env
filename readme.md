# docker-Yapi

Dockerized Yapi environment.

## 使用

### 安装

1. 编译镜像: `make build`
2. yapi 安装: `make install`

### 使用

* 运行服务: `make run`
* 停止服务: `make stop`
* 进入容器: `make exec`
* 查看log: `make log`

### notice
 
* 使用端口 3000:3000，可以在 Makefile 中定义 EXPOSE_PORT
* yapi 版本 为 `v1.3.6`，可以在 Makefile 中定义 YAPI_VERSION
* 管理员帐号 `admin@admin.com` 密码：`ymfe.org` 切记修改密码
