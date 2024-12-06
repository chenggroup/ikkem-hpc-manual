# 显示队列、节点信息：sinfo

`sinfo`可以查看系统存在什么队列、节点及其状态。如`sinfo -l`：

```
Fri Dec 06 09:17:43 2024
PARTITION AVAIL  TIMELIMIT   JOB_SIZE ROOT OVERSUBS     GROUPS  NODES       STATE NODELIST
cpu          up   infinite 1-infinite   no       NO        all      2    drained* cu[186,302]
cpu          up   infinite 1-infinite   no       NO        all     10       mixed cu[001,017,021,045,055-056,096,153,249,301]
cpu          up   infinite 1-infinite   no       NO        all     42   allocated cu[004-006,016,027-034,043-044,127-130,184-185,250-253,277-278,281-290,293-294,324-325,373-374]
cpu          up   infinite 1-infinite   no       NO        all    335        idle cu[002-003,007-015,018-020,022-026,035-042,046-054,057-095,097-126,131-152,154-183,187-248,254-276,279-280,291-292,295-300,303-323,326-372,375-389]
gpu          up   infinite 1-infinite   no       NO        all      6       mixed gpu[001-006]
fat*         up   infinite 1-infinite   no       NO        all      1   allocated fat001
fat*         up   infinite 1-infinite   no       NO        all      1        idle fat002
```

根据输出，可以看出不同分区的不同节点所处的状态。`idle` 表示空闲，`allocated` 表示被全部占用，`mixed` 表示部分占用，`drained` 或 `draining` 表示暂停或即将暂停接收作业，`down` 表示不可用。

例如从上方的输出可以看出：
- `cpu` 分区 (CPU 计算节点) 
	- `cu[004-006,016,027-034,043-044,127-130,184-185,250-253,277-278,281-290,293-294,324-325,373-374]` 等 42 个节点被全部占用
	- `cu[001,017,021,045,055-056,096,153,249,301]` 等 10 个节点被部分占用
	- `cu[002-003,007-015,018-020,022-026,035-042,046-054,057-095,097-126,131-152,154-183,187-248,254-276,279-280,291-292,295-300,303-323,326-372,375-389]` 等 335 个节点空闲，可以接收作业
	- `cu[186,302]` 节点因为维护等原因临时关闭了作业提交
- `gpu` 分区 (GPU 计算节点) 
	- `gpu[001-006]` 节点被部分占用。注意由于 CPU / 内存资源可能未全部分配，即使 GPU 被全部占用也可能显示为 `mix`。
- `fat` 分区 (大内存计算节点) 
	- `fat001` 被完全占用
	- `fat002` 空闲，可以接收作业
## `sinfo` 主要输出项

根据 `sinfo` 指令的不同，用户可能看到如下这些字段的信息，其含义分点列出如下：

- `AVAIL`：up表示可用，down表示不可用。
- `CPUS`：各节点上的CPU数。
- `S:C:T`：各节点上的CPU插口sockets(S)数（CPU颗数，一颗CPU含有多颗CPU核，以下类似）、CPU核cores(C)数和线程threads(T)数。
- `SOCKETS`：各节点CPU插口数，CPU颗数。
- `CORES`：各节点CPU核数。
- `THREADS`：各节点线程数。
- `GROUPS`：可使用的用户组，all表示所有组都可以用。
- `JOB_SIZE`：可供用户作业使用的最小和最大节点数，如果只有1个值，则表示最大和最小一样，infinite表示无限制。
- `TIMELIMIT`：作业运行墙上时间（walltime，指的是用计时器，如手表或挂钟，度量的实际时间）限制，infinite表示没限制，如有限制的话，其格式为“days-hours:minutes:seconds”。
- `MEMORY`：实际内存大小，单位为MB。
- `NODELIST`：节点名列表，格式类似node\[1-10,11,13-28\]。
- `NODES`：节点数。
- `NODES(A/I)`：节点数，状态格式为“available/idle”。
- `NODES(A/I/O/T)`：节点数，状态格式为“available/idle/other/total”。
- `PARTITION`：队列名。后面带有\*的，表示此队列为默认队列。
- `ROOT`：是否限制资源只能分配给root账户。
- `OVERSUBSCRIBE`：是否允许作业分配的资源超过计算资源（如CPU数）：
  - `no`：不允许超额。
  - `exclusive`：排他的，只能给这些作业用（等价于`srun --exclusive`）。
  - `force`：资源总被超额。
  - `yes`：资源可以被超额。
- `STATE`：节点状态，可能的状态包括：
  - `allocated`、`alloc`：已分配。
  - `completing`、`comp`：完成中。
  - `down`：宕机。
  - `drained`、`drain`：已失去活力。表示该节点暂时停止接收新作业。
  - `draining`、`drng`：失去活力中。表示该节点即将暂时停止接收新作业，等待目前运行在该节点的任务完成。
  - `fail`：失效。
  - `failing`、`failg`：失效中。
  - `future`、`futr`：将来可用。
  - `idle`：空闲，可以接收新作业。
  - `maint`：维护。
  - `mixed`：混合，节点在运行作业，但有些空闲CPU核，可接受新作业。
  - `perfctrs`、`npc`：因网络性能计数器使用中导致无法使用。
  - `power_down`、`pow_dn`：已关机。
  - `power_up`、`pow_up`：正在开机中。
  - `reserved`、`resv`：预留。
  - `unknown`、`unk`：未知原因。
  - 注意，如果状态带有后缀 `*`，表示节点没响应。
- `TMP_DISK`：/tmp所在分区空间大小，单位为MB。

## `sinfo` 主要参数

在使用 `sinfo` 命令时，可以设置如下选项以显示所需的输出：

- `-a`、`--all`：显示全部队列信息，如显示隐藏队列或本组没有使用权的队列。
- `-d`、`--dead`：仅显示无响应或已宕机节点。
- `-e`、`--exact`：精确而不是分组显示显示各节点。
- `--help`：显示帮助。
- `-i <seconds>`、`--iterate=<seconds>`：以 `<seconds>` 秒间隔持续自动更新显示信息。
- `-l`、`--long`：显示详细信息。
- `-n <nodes>`、`--nodes=<nodes>`：显示\<nodes>节点信息。
- `-N`, `--Node`：以每行一个节点方式显示信息，即显示各节点信息。
- `-p <partition>`、`--partition=<partition>`：显示 `<partition>` 队列信息。
- `-r`、`--responding`：仅显示响应的节点信息。
- `-R`、`--list-reasons`：显示不响应（down、drained、fail或failing状态）节点的原因。
- `-s`：显示摘要信息。
- `-S <sort_list>`、`--sort=<sort_list>`：设定显示信息的排序方式。排序字段参见后面输出格式部分，多个排序字段采用,分隔，字段前面的+和-分表表示升序（默认）或降序。队列字段P前面如有#，表示以Slurm配置文件slurm.conf中的顺序显示。例如：`sinfo -S +P,-m`表示以队列名升序及内存大小降序排序。
- `-t <states>`、`--states=<states>`：仅显示 `<states>` 状态的信息。`<states>`状态可以为（不区分大小写）：ALLOC、ALLOCATED、COMP、COMPLETING、DOWN、DRAIN、DRAINED、DRAINING、ERR、ERROR、FAIL、FUTURE、FUTR、IDLE、MAINT、MIX、MIXED、NO_RESPOND、NPC、PERFCTRS、POWER_DOWN、POWER_UP、RESV、RESERVED、UNK和UNKNOWN。
- `-T`, `--reservation`：仅显示预留资源信息。
- `--usage`：显示用法。
- `-v`、`--verbose`：显示冗余信息，即详细信息。
- `-V`：显示版本信息。
- `-o <output_format>`、`--format=<output_format>`：按照 `<output_format>` 格式输出信息，默认为“%#P %.5a %.10l %.6D %.6t %N”：
	  - `%all`：所有字段信息。
	  - `%a`：队列的状态及是否可用。
	  - `%A`：以“allocated/idle”格式显示状态对应的节点数。
	  - `%b`：激活的特性，参见%f。
	  - `%B`：队列中每个节点可分配给作业的CPU数。
	  - `%c`：各节点CPU数。
	  - `%C`：以“allocated/idle/other/total”格式状态显示CPU数。
	  - `%d`：各节点临时磁盘空间大小，单位为MB。
	  - `%D`：节点数。
	  - `%e`：节点空闲内存。
	  - `%E`：节点无效的原因（down、draine或ddraining状态）。
	  - `%f`：节点可用特性，参见%b。
	  - `%F`：以“allocated/idle/other/total”格式状态的节点数。
	  - `%g`：可以使用此节点的用户组。
	  - `%G`：与节点关联的通用资源（gres）。
	  - `%h`：作业是否能超用计算资源（如CPUs），显示结果可以为yes、no、exclusive或force。
	  - `%H`：节点不可用信息的时间戳。
	  - `%I`：队列作业权重因子。
	  - `%l`：以“days-hours:minutes:seconds”格式显示作业可最长运行时间。
	  - `%L`：以“days-hours:minutes:seconds”格式显示作业默认时间。
	  - `%m`：节点内存，单位MB。
	  - `%M`：抢占模式，可以为no或yes。
	  - `%n`：节点主机名。
	  - `%N`：节点名。
	  - `%o`：节点IP地址。
	  - `%O`：节点负载。
	  - `%p`：队列调度优先级。
	  - `%P`：队列名，带有\*为默认队列，参见%R。
	  - `%R`：队列名，不在默认队列后附加\*，参见%P。
	  - `%s`：节点最大作业大小。
	  - `%S`：允许分配的节点数。
	  - `%t`：以紧凑格式显示节点状态。
	  - `%T`：以扩展格式显示节点状态。
	  - `%v`：slurmd守护进程版本。
	  - `%w`：节点调度权重。
	  - `%X`：单节点socket数。
	  - `%Y`：单节点CPU核数。
	  - `%Z`：单核进程数。
	  - `%z`：扩展方式显示单节点处理器信息：sockets、cores、threads（S:C:T）数。

- `-O <output_format>, --Format=<output_format>`：按照 `<output_format>`  格式输出信息，类似 `-o <output_format>、--format=\<output_format>` 。

  每个字段的格式为 `type[:[.]size]` ：
  - `size`：最小字段大小，如没指明，则最大为20个字符。
  - `.`：指明为右对齐，默认为左对齐。
  - 可用`type`：
    - `all`：所有字段信息。
    - `allocmem`：节点上分配的内存总数，单位 MB。
    - `allocnodes`：允许分配的节点。
    - `available`：队列的 State/availability 状态。
    - `cpus`：各节点 CPU 数。
    - `cpusload`：节点负载。
    - `freemem`：节点可用内存，单位 MB。
    - `cpusstate`：以 `allocated/idle/other/total` 格式状态的CPU数。
    - `cores`：单颗 CPU 的 CPU 核数。
    - `disk`：各节点临时磁盘空间大小，单位为MB。
    - `features`：节点可用特性。
    - `features_act`：节点激活的特性，参见 `features`。
    - `groups`：可以使用此节点的用户组。
    - `gres`：与节点关联的通用资源（gres）。
    - `maxcpuspernode`：队列中各节点最大可用CPU数。
    - `memory`：节点内存，单位MB。
    - `nodeai`：以“allocated/idle”格式显示状态对应的节点数。
    - `nodes`：节点数。
    - `nodeaiot`：以“allocated/idle/other/total”格式状态的节点数。
    - `nodehost`：节点主机名。
    - `nodelist`：节点名，格式类似 `node[1-10,11,13-28]`。
    - `oversubscribe`：作业是否能超用计算资源（如CPUs），显示结果可以为 `yes`、`no`、`exclusive` 或 `force`。
    - `partition`：队列名，带有 `*`  为默认队列，参见 `%R`。
    - `partitionname`：队列名，默认队列不附加 `*` ，参见 `%P`。
    - `preemptmode`：抢占模式，可以为 `no` 或 `yes`。
    - `priorityjobfactor`：队列作业权重因子。
    - `prioritytier` 或 `priority`：队列调度优先级。
    - `reason`：节点无效的原因（`down`、`drained` 或 `draining`  状态）。
    - `size`：节点最大作业数。
    - `statecompact`：紧凑格式节点状态。
    - `statelong`：扩展格式节点状态。
    - `sockets`：各节点CPU颗数。
    - `socketcorethread`：扩展方式显示单节点处理器信息：`sockets`、`cores`、`threads`（`S:C:T`）数。
    - `time`：以 `days-hours:minutes:seconds` 格式显示作业可最长运行时间。
    - `timestamp`：节点不可用信息的时间戳。
    - `threads`：CPU核线程数。
    - `weight`：节点调度权重。
    - `version`：slurmd守护进程版本。
