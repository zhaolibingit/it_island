# 根据header控制版本

更改istio-ingress外网访问模式改为nodeport

```text
kubectl patch service istio-ingressgateway -n istio-system -p '{"spec":{"type":"NodePort"}}'
```

构建两个镜像

{% tabs %}
{% tab title="nginx-v1.yaml" %}
```text
apiVersion: apps/v1
kind: Deployment
metadata:
    name: nginx-demo-deployment-v1
    labels:
        app: nginx-demo
        version: v1
spec:
    replicas: 2
    selector:
        matchLabels:
            app: nginx-demo
            version: v1
    template:
        metadata:
            labels:
                app: nginx-demo
                version: v1
        spec:
            containers:
                - name: nginx
                  image: registry.cn-huhehaote.aliyuncs.com/zlb_dockerhub/nginx:v1
                  imagePullPolicy: IfNotPresent
                  ports:
                      - containerPort: 80


---
apiVersion: v1
kind: Service
metadata:
    name: nginx-demo-svc-v1
    namespace: default
spec:
    selector:
        version: v1
    type: ClusterIP
    ports:
        - name: nginx-demo-v1
          port: 80
          protocol: TCP
```
{% endtab %}

{% tab title="nginx-v2.yaml" %}
```text
apiVersion: apps/v1
kind: Deployment
metadata:
    name: nginx-demo-deployment-v2
    labels:
        app: nginx-demo
        version: v2

spec:
    replicas: 2
    selector:
        matchLabels:
            app: nginx-demo
            version: v2
    template:
        metadata:
            labels:
                app: nginx-demo
                version: v2
        spec:
            containers:
                - name: nginx
                  image: registry.cn-huhehaote.aliyuncs.com/zlb_dockerhub/nginx:v2
                  imagePullPolicy: IfNotPresent
                  ports:
                      - containerPort: 80


---
apiVersion: v1
kind: Service
metadata:
    name: nginx-demo-svc-v2
    namespace: default
spec:
    selector:
        version: v2
    type: ClusterIP
    ports:
        - name: nginx-demo-v2
          port: 80
          protocol: TCP

---
apiVersion: v1
kind: Service
metadata:
    name: nginx-demo-svc
    namespace: default
spec:
    selector:
        app: nginx-demo
    type: ClusterIP
    ports:
        - name: nginx-demo
          port: 80
          protocol: TCP
```
{% endtab %}

{% tab title="nginx-vs.yaml" %}
```
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: nginx-demo-virtual-svc
spec:
  hosts:
  - nginx-demo-vsc
  http:
    - route:
      - destination:
          host: nginx-demo-svc-v1
        weight: 10
      - destination:
          host: nginx-demo-svc-v2
        weight: 90
```
{% endtab %}
{% endtabs %}

```text
for i in `seq 1 100000`; do wget -q -O - http://nginx-demo-svc && sleep 1;done
```

