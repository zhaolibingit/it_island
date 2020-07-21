# install-rancher

#### 单机容器启动

```text
docker run -d --restart=always --name rancher -p 80:80 -p 443:443 rancher/rancher:stable
```

#### helm 部署（未完）

```text
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system
helm install rancher rancher-stable/rancher  --namespace cattle-system  --set hostname=rancher.sfkj.sit --set ingress.tls.source=secret
```



