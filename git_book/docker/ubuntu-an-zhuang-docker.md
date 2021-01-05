# ubuntu安装docker

安装docker

```text
apt-get update
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update
#查看可安装版本
apt-cache madison docker-ce
#指定版本安装
apt-get -y install docker-ce=5:19.03.14~3-0~ubuntu-bionic
system enable docker
```

修改配置

```text
cat > /etc/docker/daemon.json << EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-opts": {"max-size": "100m"},
  "debug" : true,
  "experimental" : true,
  "registry-mirrors": ["https://mirror.ccs.tencentyun.com",
                        "http://b611224e.m.daocloud.io",
                        "http://fa42fdd5.m.daocloud.io",
                        "https://odhacnra.mirror.aliyuncs.com"],
  "storage-driver": "overlay",
  "max-concurrent-downloads": 10,
  "live-restore": true
}
EOF
```

