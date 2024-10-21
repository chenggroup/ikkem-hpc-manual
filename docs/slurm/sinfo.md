# 显示队列、节点信息：sinfo

`sinfo`可以查看系统存在什么队列、节点及其状态。如`sinfo -l`：

```
PARTITION   AVAIL  TIMELIMIT   JOB_SIZE ROOT OVERSUBS     GROUPS  NODES       STATE NODELIST
CPU-Large*     up   infinite 1-infinite   no       NO        all    720        idle cnode[001-720]
GPU-V100       up   infinite 1-infinite   no       NO        all     10        idle gnode[01-10]
2TB-AEP-Mem    up   infinite 1-infinite   no       NO        all      8       mixed anode[01-08]
ARM-CPU        up   infinite 1-infinite   no       NO        all      2       down* rnode[01,09]
ARM-CPU        up   infinite 1-infinite   no       NO        all      2   allocated rnode[02-03]
ARM-CPU        up   infinite 1-infinite   no       NO        all      5        idle rnode[04-08]
```

## sinfo主要输出项

- AVAIL：up表示可用，down表示不可用。

- CPUS：各节点上的CPU数。

- S:C:T：各节点上的CPU插口sockets(S)数（CPU颗数，一颗CPU含有多颗CPU核，以下类似）、CPU核cores(C)数和线程threads(T)数。

- SOCKETS：各节点CPU插口数，CPU颗数。

- CORES：各节点CPU核数。

- THREADS：各节点线程数。

- GROUPS：可使用的用户组，all表示所有组都可以用。

- JOB_SIZE：可供用户作业使用的最小和最大节点数，如果只有1个值，则表示最大和最小一样，infinite表示无限制。

- TIMELIMIT：作业运行墙上时间（walltime，指的是用计时器，如手表或挂钟，度量的实际时间）限制，infinite表示没限制，如有限制的话，其格式为“days-hours:minutes:seconds”。

- MEMORY：实际内存大小，单位为MB。

- NODELIST：节点名列表，格式类似node\[1-10,11,13-28\]。

- NODES：节点数。

- NODES(A/I)：节点数，状态格式为“available/idle”。

- NODES(A/I/O/T)：节点数，状态格式为“available/idle/other/total”。

- PARTITION：队列名，后面带有\*的，表示此队列为默认队列。

- ROOT：是否限制资源只能分配给root账户。

- OVERSUBSCRIBE：是否允许作业分配的资源超过计算资源（如CPU数）：

  - no：不允许超额。
  - exclusive：排他的，只能给这些作业用（等价于`srun --exclusive`）。
  - force：资源总被超额。
  - yes：资源可以被超额。

- STATE：节点状态，可能的状态包括：

  - allocated、alloc：已分配。
  - completing、comp：完成中。
  - down：宕机。
  - drained、drain：已失去活力。
  - draining、drng：失去活力中。
  - fail：失效。
  - failing、failg：失效中。
  - future、futr：将来可用。
  - idle：空闲，可以接收新作业。
  - maint：保持。
  - mixed：混合，节点在运行作业，但有些空闲CPU核，可接受新作业。
  - perfctrs、npc：因网络性能计数器使用中导致无法使用。
  - power_down、pow_dn：已关机。
  - power_up、pow_up：正在开机中。
  - reserved、resv：预留。
  - unknown、unk：未知原因。

  注意，如果状态带有后缀\*，表示节点没响应。

- TMP_DISK：/tmp所在分区空间大小，单位为MB。

## sinfo主要参数

- -a、--all：显示全部队列信息，如显示隐藏队列或本组没有使用权的队列。

- -d、--dead：仅显示无响应或已宕机节点。

- -e、--exact：精确而不是分组显示显示各节点。

- --help：显示帮助。

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

- -O \<output_format>, --Format=\<output_format>：按照\<output_format>格式输出信息，类似-o \<output_format>、--format=\<output_format>。

  每个字段的格式为“type\[:\[.\]size\]”：

  - size：最小字段大小，如没指明，则最大为20个字符。

  - .：指明为右对齐，默认为左对齐。

  - 可用type：

    - all：所有字段信息。
    - allocmem：节点上分配的内存总数，单位MB。
    - allocnodes：允许分配的节点。
    - available：队列的State/availability状态。
    - cpus：各节点CPU数。
    - cpusload：节点负载。
    - freemem：节点可用内存，单位MB。
    - cpusstate：以“allocated/idle/other/total”格式状态的CPU数。
    - cores：单CPU颗CPU核数。
    - disk：各节点临时磁盘空间大小，单位为MB。
    - features：节点可用特性，参见features_act。
    - features_act：激活的特性，参见features。
    - groups：可以使用此节点的用户组。
    - gres：与节点关联的通用资源（gres）。
    - maxcpuspernode：队列中各节点最大可用CPU数。
    - memory：节点内存，单位MB。
    - nodeai：以“allocated/idle”格式显示状态对应的节点数。
    - nodes：节点数。
    - nodeaiot：以“allocated/idle/other/total”格式状态的节点数。
    - nodehost：节点主机名。
    - nodelist：节点名，格式类似node\[1-10,11,13-28\]。
    - oversubscribe：作业是否能超用计算资源（如CPUs），显示结果可以为yes、no、exclusive或force。
    - partition：队列名，带有\*为默认队列，参见%R。
    - partitionname：队列名，默认队列不附加\*，参见%P。
    - preemptmode：抢占模式，可以为no或yes。
    - priorityjobfactor：队列作业权重因子。
    - prioritytier或priority：队列调度优先级。
    - reason：节点无效的原因（down、draine或ddraining状态）。
    - size：节点最大作业数。
    - statecompact：紧凑格式节点状态。
    - statelong：扩展格式节点状态。
    - sockets：各节点CPU颗数。
    - socketcorethread：扩展方式显示单节点处理器信息：sockets、cores、threads（S:C:T）数。
    - time：以“days-hours:minutes:seconds”格式显示作业可最长运行时间。
    - timestamp：节点不可用信息的时间戳。
    - threads：CPU核线程数。
    - weight：节点调度权重。
    - version：slurmd守护进程版本。
