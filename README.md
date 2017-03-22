# shadowsocks

## Server

### 安装shadowsocks服务端
```
yum install -y python-setuptools \
&& easy_install pip \
&& pip install shadowsocks
```

### 放置文件到对应位置
```
cp server/shadowsocks.json /etc/shadowsocks.json
cp server/shadowsocks.service /usr/lib/systemd/system/shadowsocks.service
```

### 设置端口与密码
```
{
    "server": "0.0.0.0",
    "local_port": 1081,
    "port_password": {
        "1777": "password",
        "1888": "password-2"
    },
    "timeout": 300,
    "method": "aes-256-cfb"
}

```

### 启动
```
systemctl start shadowsocks
```

## Client

### 安装shadowsocks客户端
```
wget https://copr.fedoraproject.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo \
&& mv librehat-shadowsocks-epel-7.repo /etc/yum.repos.d/ \
&& yum install shadowsocks-libev
```

### 修改配置文件填写 shadowsocks-client.json 对应配置项
```
{
    "server": "",
    "server_port": "1777",
    "local_port": "1080",
    "password": "password",
    "method": "aes-256-cfb"
}
```

### 修改 shadowsocks-client.sh 配置文件地址config_path
```
config_path=/home/user/data/shadowsocks/client/shadowsocks-client.json
```

### 在 /etc/rc.d/rc.local 添加一行
```
/home/user/data/shadowsocks/client/shadowsocks-client.sh start
```
