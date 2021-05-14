# git 问题

git 仓库过大，无法直接clone

```text
首先关闭 core.compression

git config --global core.compression 0
然后使用depth这个指令来下载最近一次提交

git clone --depth 1 url
然后获取完整库

git fetch --unshallow 
最后pull一下查看状态，问题解决

git pull --all
```



