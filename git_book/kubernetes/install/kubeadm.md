# kubeadm

### 配置kubeadm自动补全

```text
#安装bash自动补全插件
yum install bash-completion -y
#设置kubectl与kubeadm命令补全，下次login生效
kubectl completion bash >/etc/bash_completion.d/kubectl
kubeadm completion bash > /etc/bash_completion.d/kubeadm
```





