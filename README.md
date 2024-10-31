# hpc-manual 

嘉庚智算中心 (IKKEM HPC) 用户文档。

## 部署

目前该文档部署于 https://ai4ec.ikkem.com/ikkem-hpc/doc， 
其代码位于该主机的 `/opt/hpc-manual` 目录下。

该网站通过一个 `crontab` 任务每10分钟进行一次更新，任务内容如下：

```bash
*/10 * * * * flock -n /tmp/hpc-manual.lock /opt/hpc-manual/update.sh
```

## 变更

每次更新后请在 `index.md` 修改文档更新时间。

对于每次集群面向用户发布的公告请归档在 `introduction/changelog.md` 中。
