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

- NodeName：节点名。
- Arch：系统架构。
- CoresPerSocket：12。
- CPUAlloc：分配给的CPU核数。
- CPUErr：出错的CPU核数。
- CPUTot：总CPU核数。
- CPULoad：CPU负载。
- AvailableFeatures：可用特性。
- ActiveFeatures：激活的特性。
- Gres：通用资源。如上面 `Gres=gpu:v100:2` 指明了有两块V100 GPU。
- NodeAddr：节点IP地址。
- NodeHostName：节点名。
- Version：Slurm版本。
- OS：操作系统 。
- RealMemory：实际物理内存，单位GB。
- AllocMem：已分配内存，单位GB。
- FreeMem：可用内存，单位GB。
- Sockets：CPU颗数。
- Boards：主板数。
- State：状态。
- ThreadsPerCore：每颗CPU核线程数。
- TmpDisk：临时存盘硬盘大小。
- Weight：权重。
- BootTime：开机时间。
- SlurmdStartTime：Slurmd守护进程启动时间。
