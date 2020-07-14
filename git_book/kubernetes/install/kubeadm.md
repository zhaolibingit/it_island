# kubeadm

### 开启ipvs

```text
# kube-proxy开启ipvs的前置条件

cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs 
modprobe -- ip_vs_rr 
modprobe -- ip_vs_wrr 
modprobe -- ip_vs_sh 
modprobe -- nf_conntrack_ipv4 
EOF

chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4
```

### 安装docker

```text
# 安装docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo 
yum update -y && yum install -y docker-ce

# 创建/etc/docker目录
mkdir /etc/docker
# 配置daemon.josn
cat > /etc/docker/daemon.json <<EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {"max-size": "100m"}
} 
EOF

mkdir -p /etc/systemd/system/docker.service.d 
# 重启docker服务 
systemctl daemon-reload && systemctl restart docker && systemctl enable docker
```

### 安装kubeadm

```text
# 安装kubeadm

cat << EOF > /etc/yum.repos.d/kubernetes.repo 
[kubernetes] 
name=Kubernetes 
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1 
gpgcheck=0 
repo_gpgcheck=0 
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg 
http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg 
EOF

yum -y install  kubeadm-1.18.2 kubectl-1.18.2 kubelet-1.18.2
systemctl enable kubelet.service
```

### 配置kubeadm自动补全

```text
#安装bash自动补全插件
yum install bash-completion -y
#设置kubectl与kubeadm命令补全，下次login生效
kubectl completion bash >/etc/bash_completion.d/kubectl
kubeadm completion bash > /etc/bash_completion.d/kubeadm
```





