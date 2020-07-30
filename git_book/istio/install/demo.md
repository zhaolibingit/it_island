# demo

#### 安装dem

```text
istioctl manifest apply --set profile=demo
```

#### 卸载demo

```text
istioctl manifest generate --set profile=demo | kubectl delete -f -
```

