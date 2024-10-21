# 查看服务质量(QoS)

服务质量(Quality Of Service-QoS)，或者理解为资源限制或者优先级，只有达到QoS要求时作业才能运行，QoS将在以下三个方面影响作业运行：

- 作业调度优先级
- 作业抢占
- 作业限制

可以用 `sacctmgr show | list qos` 查看。
