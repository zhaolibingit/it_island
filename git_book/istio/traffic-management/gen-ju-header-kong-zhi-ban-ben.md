# 根据header控制版本

构建两个镜像

{% tabs %}
{% tab title="First Tab" %}
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

{% tab title="Second Tab" %}
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

{% tab title="" %}
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



