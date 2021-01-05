# ubuntu安装docker

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
```

