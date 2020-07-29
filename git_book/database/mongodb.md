# mongodb

## 介绍

MongoDB 是由C++语言编写的，是一个基于分布式文件存储的开源数据库系统。在高负载的情况下，添加更多的节点，可以保证服务器性能。MongoDB 旨在为WEB应用提供可扩展的高性能数据存储解决方案。MongoDB 将数据存储为一个文档，数据结构由键值\(key=&gt;value\)对组成。MongoDB 文档类似于 JSON 对象。字段值可以包含其他文档，数组及文档数组。

```text
{
    "name": "sue",
    "age": 26,
    "status": "A",
    "group": [
        "news",
        "group"
    ]
}
```

