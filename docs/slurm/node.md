# 查看详细节点信息：scontrol show node

`scontrol show node` 显示全部节点信息，`scontrol show node NODENAME` 或
`scontrol show node=NODENAME` 显示节点名NODENAME的节点信息，输出类似：

```
  NodeName=anode01 Arch=x86_64 CoresPerSocket=20

    CPUAlloc=0 CPUTot=40 CPULoad=0.01
    AvailableFeatures=(null)
    ActiveFeatures=(null)
    Gres=(null)
    NodeAddr=anode01 NodeHostName=anode01 Version=19.05.4
    OS=Linux 3.10.0-1062.el7.x86_64 #1 SMP Wed Aug 7 18:08:02 UTC 2019
    RealMemory=2031623 AllocMem=0 FreeMem=1989520 Sockets=2 Boards=1
    State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
    Partitions=2TB-AEP-Mem
    BootTime=2019-11-09T15:47:56 SlurmdStartTime=2019-12-01T19:01:59
    CfgTRES=cpu=40,mem=2031623M,billing=40
    AllocTRES=
    CapWatts=n/a
    CurrentWatts=0 AveWatts=0
    ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

  NodeName=gnode01 Arch=x86_64 CoresPerSocket=20

    CPUAlloc=0 CPUTot=40 CPULoad=0.01
    AvailableFeatures=(null)
    ActiveFeatures=(null)
    Gres=gpu:v100:2
    NodeAddr=gnode01 NodeHostName=gnode01 Version=19.05.4
    OS=Linux 3.10.0-1062.el7.x86_64 #1 SMP Wed Aug 7 18:08:02 UTC 2019
    RealMemory=385560 AllocMem=0 FreeMem=368966 Sockets=2 Boards=1
    State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
    Partitions=GPU-V100
    BootTime=2019-11-13T16:51:31 SlurmdStartTime=2019-12-01T19:54:55
    CfgTRES=cpu=40,mem=385560M,billing=40,gres/gpu=2
    AllocTRES=
    CapWatts=n/a
    CurrentWatts=0 AveWatts=0
    ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
```

## scontrol show node主要输出项

- `NodeName`：节点名。
- `Arch`：系统架构，如 `x86_64`。
- `CoresPerSocket`：每颗 CPU 处理器的核数。
- `CPUAlloc`：已分配的 CPU 核数。
- `CPUErr`：出错的 CPU 核数。
- `CPUTot`：总 CPU 核数。
- `CPULoad`：CPU 当前负载。
- `AvailableFeatures`：可用特性。
- `ActiveFeatures`：激活的特性。
- `Gres`：通用资源，包括 GPU 等。例如上面 `Gres=gpu:v100:2` 指明了该节点上安装有两块V100 GPU。
- `NodeAddr`：节点 IP 地址或当前主机可以访问的主机名。
- `NodeHostName`：节点名。
- `Version`：Slurm版本。
- `OS`：操作系统及版本信息 。
- `RealMemory`：实际物理内存，单位 MB。
- `AllocMem`：已分配内存，单位 MB。
- `FreeMem`：可用内存，单位 MB。
- `Sockets`：CPU 颗数。
- `Boards`：主板数。
- `State`：状态。
- `ThreadsPerCore`：每颗CPU核线程数。
- `TmpDisk`：设定的临时存储空间大小。
- `Weight`：权重。
- `BootTime`：开机时间。
- `SlurmdStartTime`：Slurmd守护进程启动时间。
