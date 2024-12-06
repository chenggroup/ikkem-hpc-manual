# 查看详细作业信息：scontrol show job

`scontrol show job`显示全部作业信息，`scontrol show job JOBID`或`scontrol show job=JOBID`显示作业号为JOBID的作业信息，输出类似下面：

```
JobId=358106 JobName=nvt_lammps
	UserId=ymchen(32672) GroupId=ymchen-g(42170) MCS_label=N/A
	Priority=5000 Nice=0 Account=ai4eceeg QOS=normal
	JobState=RUNNING Reason=None Dependency=(null)
	Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
	RunTime=21:40:51 TimeLimit=2-00:00:00 TimeMin=N/A
	SubmitTime=2024-12-04T16:13:40 EligibleTime=2024-12-04T16:13:40
	AccrueTime=2024-12-04T16:13:40
	StartTime=2024-12-05T12:17:44 EndTime=2024-12-07T12:17:44 Deadline=N/A
	SuspendTime=None SecsPreSuspend=0 LastSchedEval=2024-12-05T12:17:44 Scheduler=Backfill
	Partition=gpu AllocNode:Sid=mu012:2233526
	ReqNodeList=(null) ExcNodeList=(null)
	NodeList=gpu003
	BatchHost=gpu003
	NumNodes=1 NumCPUs=4 NumTasks=4 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
	TRES=cpu=4,mem=64G,node=1,billing=4,gres/gpu:tesla=1
	Socks/Node=* NtasksPerN:B:S:C=4:0:*:* CoreSpec=*
	MinCPUsNode=4 MinMemoryCPU=16G MinTmpDiskNode=0
	Features=(null) DelayBoot=00:00:00
	OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
	Command=/public/home/ymchen/znotf-pc/2-11/mlmd/nvt/dpmd.slurm
	WorkDir=/public/home/ymchen/znotf-pc/2-11/mlmd/nvt
	StdErr=/public/home/ymchen/znotf-pc/2-11/mlmd/nvt/slurm-358106.out
	StdIn=/dev/null
	StdOut=/public/home/ymchen/znotf-pc/2-11/mlmd/nvt/slurm-358106.out
	Power=
	TresPerNode=gres:gpu:1
```

## `scontrol show job` 主要输出项
- `JobId`：作业号。
- `JobName`：作业名称。
- `UserId`：用户名（用户ID）。
- `GroupId`：用户组（组ID）。
- `MCS_label`：MCS标记。
- `Priority`：优先级，越大越优先，如果为0则表示被管理员挂起，不允许运行。
- `Nice`：Nice值，越小越优先，-20到19。
- `Account`：账户名。
- `QOS`：作业的服务质量。
- `JobState`：作业状态。
  - `PENDING`：排队中。
  - `RUNNING`：运行中。
  - `CANCELLED`：已取消。
  - `CONFIGURING`：配置中。
  - `COMPLETING`：完成中。
  - `COMPLETED`：已完成。
  - `FAILED`：已失败。
  - `TIMEOUT`：超时。
  - `NODE FAILURE`：节点失效。
  - `SPECIAL EXIT STATE`：特殊退出状态。
- `Reason`：原因。
- `Dependency`：依赖关系。
- `Requeue`：节点失效时，是否重排队，0为否，1为是。
- `Restarts`：失败时，是否重运行，0为否，1为是。
- `BatchFlag`：是否为批处理作业（即通过 `sbatch` 提交的作业脚本），0为否，1为是。
- `Reboot`：节点空闲时是否重启节点，0为否，1为是。
- `ExitCode`：作业退出代码。
- `RunTime`：已运行时间。
- `TimeLimit`：作业允许的剩余运行时间。
- `TimeMin`：最短运行时间。
- `SubmitTime`：提交时间。
- `EligibleTime`：获得认可时间。
- `StartTime`：开始运行时间。
- `EndTime`：预计最晚结束时间。
- `Deadline`：截止时间。
- `PreemptTime`：先占时间。
- `SuspendTime`：挂起时间。
- `SecsPreSuspend`：0。
- `Partition`：对列名。
- `AllocNode`：Sid：分配的节点：系统ID号。
- `ReqNodeList`：需要的节点列表，格式类似 `node[1-10,11,13-28]`。
- `ExcNodeList`：排除的节点列表，格式类似 `node[1-10,11,13-28]`。
- `NodeList`：实际运行节点列表，格式类似 `node[1-10,11,13-28]`。
- `BatchHost`：批处理节点名。
- `NumNodes`：节点数。
- `NumCPUs`：CPU核数。
- `NumTasks`：任务数。
- `CPUs/Task`：CPU核数/任务数。
- `ReqB:S:C:T`：所需的主板数:每主板CPU颗数:每颗CPU核数:每颗CPU核的线程数，`<baseboard_count>:<socket_per_baseboard_count>:<core_per_socket_count>:<thread_per_core_count>`。
- `TRES`：显示分配给作业的可被追踪的资源。
- `Socks/Node`：每节点CPU颗数。
- `NtasksPerN:B:S:C`：每主板数:每主板CPU颗数:每颗CPU的核数:每颗CPU核的线程数启动的作业进程数，`<tasks_per_node>:<tasks_per_baseboard>:<tasks_per_socket>:<tasks_per_core>`。
- `CoreSpec`：各节点系统预留的CPU核数，如未包含，则显示 `*` 。
- `MinCPUsNode`：每节点最小CPU核数。
- `MinMemoryNode`：每节点最小内存大小，0表示未限制。
- `MinTmpDiskNode`：每节点最小临时存盘硬盘大小，0表示未限制。
- `Features`：特性。
- `Gres`：通用资源。
- `Reservation`：预留资源。
- `OverSubscribe`：是否允许与其它作业共享资源，OK允许，NO不允许。
- `Contiguous`：是否要求分配连续节点，OK是，NO否。
- `Licenses`：软件授权。
- `Network`：网络。
- `Command`：作业命令。
- `WorkDir`：工作目录。
- `StdErr`：标准出错输出文件。
- `StdIn`：标准输入文件。
- `StdOut`：标准输出文件。
