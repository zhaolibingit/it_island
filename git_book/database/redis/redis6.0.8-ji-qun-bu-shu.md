---
description: redis安装
---

# redis6.0.8 集群部署

### 一、单机安装部署

#### 1.下载redis源码包并解压 （官网[https://redis.io/download](https://redis.io/download)）

```bash
cd /data/redis/
wget https://download.redis.io/releases/redis-6.0.8.tar.gz
tar -zxvf redis-6.0.8.tar.gz
cd redis-6.0.8/
```

#### 2.安装编译环境以及依赖

```bash
# 安装gcc
yum instal gcc -y

# make 时候发现gcc版本不够，更新gcc版本

# 安装scl源
yum install centos-release-scl scl-utils-build
# 列出scl可用源
yum list all --enablerepo='centos-sclo-rh'
# 安装8版本的gcc、gcc-c++、gdb工具链（toolchian）
yum install -y devtoolset-8-toolchain
scl enable devtoolset-8 bash
# 安装完成后查看版本
gcc --version
```

#### 3.安装并指定安装目录

```bash
make install PREFIX=/usr/local/redis
#拷贝一份配置文件
cp /data/redis/redis-6.0.8/redis.conf /usr/local/redis/bin/
```

#### 至此安装完成

### 二、主从集群安装

#### 1.说明

主从复制模型中有且只有一个节点Master，从节点Slave可以有多个。只要网络正常，Master节点会一直将自己的数据更新同步给Slaves，保持主从同步。

主节点Master可读可写，从节点Slave只读（read-only\)

因此，主从模型可以提高读的能力，在一定程度上缓解了写的能力，因为写仍然只有Master节点一个，可以将读的操作全部移交到从几点上，变相提高了写的能力。

#### 2.配置安装（单机多实例）





