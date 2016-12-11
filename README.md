# shadowsocks

## 安装shadowsocks服务端
```
yum install -y python-setuptools && easy_install pip
pip install shadowsocks
```

## 安装shadowsocks客户端
```
wget https://copr.fedoraproject.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo
mv librehat-shadowsocks-epel-7.repo /etc/yum.repos.d/
yum install shadowsocks-libev
```

## 修改配置文件填写[ shadowsocks-client.json ]对应配置项

## 修改[ shadowsocks-client.sh ]配置文件地址config_path

## 在[ /etc/rc.d/rc.local ]添加一行
```
/home/user/data/shadowsocks/client/shadowsocks-client.sh start
```
