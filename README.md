# hpc-manual 

嘉庚智算中心 (IKKEM HPC) 用户文档。

## 部署

目前该文档部署于 https://ai4ec.ikkem.com/ikkem-hpc/doc， 
其代码位于该主机的 `/opt/hpc-manual` 目录下。

该网站通过一个 `crontab` 任务每10分钟进行一次更新，任务内容如下：

```bash
*/10 * * * * flock -n /tmp/hpc-manual.lock /opt/hpc-manual/update.sh
```

