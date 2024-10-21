# 查看详细队列信息：scontrol show partition

`scontrol show partition`显示全部队列信息，`scontrol show partition PartitionName`或
`scontrol show partition=PartitionName`显示队列名PartitionName的队列信息，输出类似：

```
PartitionName=CPU-Large AllowGroups=ALL AllowAccounts=ALL AllowQos=ALL
AllocNodes=ALL Default=YES QoS=N/A DefaultTime=NONE DisableRootJobs=YES
ExclusiveUser=NO GraceTime=0 Hidden=NO MaxNodes=UNLIMITED
MaxTime=UNLIMITED MinNodes=0 LLN=NO MaxCPUsPerNode=UNLIMITED
Nodes=cnode[001-720] PriorityJobFactor=1 PriorityTier=1 RootOnly=NO
ReqResv=NO OverSubscribe=NO OverTimeLimit=NONE PreemptMode=OFF State=UP
TotalCPUs=28800 TotalNodes=720 SelectTypeParameters=NONE
JobDefaults=(null) DefMemPerNode=UNLIMITED MaxMemPerNode=UNLIMITED

PartitionName=GPU-V100 AllowGroups=ALL AllowAccounts=ALL AllowQos=ALL
AllocNodes=ALL Default=NO QoS=N/A DefaultTime=NONE DisableRootJobs=YES
ExclusiveUser=NO GraceTime=0 Hidden=NO MaxNodes=UNLIMITED
MaxTime=UNLIMITED MinNodes=0 LLN=NO MaxCPUsPerNode=UNLIMITED
Nodes=gnode[01-10] PriorityJobFactor=1 PriorityTier=1 RootOnly=NO
ReqResv=NO OverSubscribe=NO OverTimeLimit=NONE PreemptMode=OFF State=UP
TotalCPUs=400 TotalNodes=10 SelectTypeParameters=NONE JobDefaults=(null)
DefMemPerNode=UNLIMITED MaxMemPerNode=UNLIMITED

PartitionName=2TB-AEP-Mem AllowGroups=ALL AllowAccounts=ALL AllowQos=ALL
AllocNodes=ALL Default=NO QoS=N/A DefaultTime=NONE DisableRootJobs=YES
ExclusiveUser=NO GraceTime=0 Hidden=NO MaxNodes=UNLIMITED
MaxTime=UNLIMITED MinNodes=0 LLN=NO MaxCPUsPerNode=UNLIMITED
Nodes=anode[01-08] PriorityJobFactor=1 PriorityTier=1 RootOnly=NO
ReqResv=NO OverSubscribe=NO OverTimeLimit=NONE PreemptMode=OFF State=UP
TotalCPUs=320 TotalNodes=8 SelectTypeParameters=NONE JobDefaults=(null)
DefMemPerNode=UNLIMITED MaxMemPerNode=UNLIMITED

PartitionName=ARM-CPU AllowGroups=ALL AllowAccounts=ALL AllowQos=ALL
AllocNodes=ALL Default=NO QoS=N/A DefaultTime=NONE DisableRootJobs=YES
ExclusiveUser=NO GraceTime=0 Hidden=NO MaxNodes=UNLIMITED
MaxTime=UNLIMITED MinNodes=0 LLN=NO MaxCPUsPerNode=UNLIMITED
Nodes=rnode[01-09] PriorityJobFactor=1 PriorityTier=1 RootOnly=NO
ReqResv=NO OverSubscribe=NO OverTimeLimit=NONE PreemptMode=OFF State=UP
TotalCPUs=864 TotalNodes=9 SelectTypeParameters=NONE JobDefaults=(null)
DefMemPerNode=UNLIMITED MaxMemPerNode=UNLIMITED
```

## scontrol show partition主要输出项

- `PartitionName`：队列名。

- `AllowGroups`：允许的用户组。

- `AllowAccounts`：允许的用户。

- `AllowQos`：允许的QoS。

- `AllocNodes`：允许的节点。

- `Default`：是否为默认队列。

- `QoS`：服务质量。

- `DefaultTime`：默认时间。

- `DisableRootJobs`：是否禁止root用户提交作业。

- `ExclusiveUser`：排除的用户。

- `GraceTime`：抢占的款显时间，单位秒。

- `Hidden`：是否为隐藏队列。

- `MaxNodes`：最大节点数。

- `MaxTime`：最大运行时间。

- `MinNodes`：最小节点数。

- `LLN`：是否按照最小负载节点调度。

- `MaxCPUsPerNode`：每个节点的最大CPU颗数。

- `Nodes`：节点名。

- `PriorityJobFactor`：作业因子优先级。

- `PriorityTier`：调度优先级。

- `RootOnly`：是否只允许Root。

- `ReqResv`：要求预留的资源。

- `OverSubscribe`：是否允许超用。

- `PreemptMode`：是否为抢占模式。

- `State`：状态：

  - `UP`：可用，作业可以提交到此队列，并将运行。
  - `DOWN`：作业可以提交到此队列，但作业也许不会获得分配开始运行。已运行的作业还将继续运行。
  - `DRAIN`：不接受新作业，已接受的作业可以被运行。
  - `INACTIVE`：不接受新作业，已接受的作业未开始运行的也不运行。

- `TotalCPUs`：总CPU核数。

- `TotalNodes`：总节点数。

- `SelectTypeParameters`：资源选择类型参数。

- `DefMemPerNode`：每个节点默认分配的内存大小，单位MB。

- `MaxMemPerNode`：每个节点最大内存大小，单位MB。
