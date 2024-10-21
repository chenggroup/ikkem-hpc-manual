# 查看队列中的作业信息：squeue

显示队列中的作业信息。如`squeue`显示：

```
JOBID PARTITION      NAME     USER ST       TIME  NODES NODELIST(REASON)
 75     ARM-CPU   arm_job     hmli  R       2:27      2 rnode[02-03]
 76    GPU-V100 gpu.slurm     hmli PD       0:00      5 (Resources)
```

(target-1)=

## squeue主要输出项

- JOBID：作业号。

- PARTITION：队列名（分区名）。

- NAME：作业名。

- USER：用户名。

- ST：状态。

  - PD：排队中，PENDING。
  - R：运行中，RUNNING。
  - CA：已取消，CANCELLED。
  - CF：配置中，CONFIGURING。
  - CG：完成中，COMPLETING
  - CD：已完成，COMPLETED。
  - F：已失败，FAILED。
  - TO：超时，TIMEOUT。
  - NF：节点失效，NODE FAILURE。
  - SE：特殊退出状态，SPECIAL EXIT STATE。

- TIME：已运行时间。

- NODELIST(REASON)：分配给的节点名列表（原因）：

  - AssociationCpuLimit： 作业指定的关联CPU已在用，作业最终会运行。
  - AssociationMaxJobsLimit：作业关联的最大作业数已到，作业最终会运行。
  - AssociationNodeLimit：作业指定的关联节点已在用，作业最终会运行。
  - AssociationJobLimit：作业达到其最大允许的作业数限制。
  - AssociationResourceLimit：作业达到其最大允许的资源限制。
  - AssociationTimeLimit：作业达到时间限制。
  - BadConstraints：作业含有无法满足的约束。
  - BeginTime：作业最早开始时间尚未达到。
  - Cleaning：作业被重新排入队列，并且仍旧在执行之前运行的清理工作。
  - Dependency：作业等待一个依赖的作业结束后才能运行。
  - FrontEndDown：没有前端节点可用于执行此作业。
  - InactiveLimit：作业达到系统非激活限制。
  - InvalidAccount：作业用户无效，建议取消该作业重新采用正确账户提交。
  - InvalidQOS：作业QOS无效，建议取消该作业重新采用正确QoS提交。
  - JobHeldAdmin：作业被系统管理员挂起。
  - JobHeldUser：作业被用户自己挂起。
  - JobLaunchFailure：作业无法被启动，有可能因为文件系统故障、无效程序名等。
  - Licenses：作业等待相应的授权。
  - NodeDown：作业所需的节点宕机。
  - NonZeroExitCode：作业停止时退出代码非零。
  - PartitionDown：作业所需的队列出于DOWN状态。
  - PartitionInactive：作业所需的队列处于Inactive状态。
  - PartitionNodeLimit：作业所需的节点超过所用队列当前限制。
  - PartitionTimeLimit：作业所需的队列达到时间限制。
  - PartitionCpuLimit：该作业使用的队列对应的CPU已经被使用，作业最终会运行。
  - PartitionMaxJobsLimit：该作业使用的队列的最大作业数已到，作业最终会运行。
  - PartitionNodeLimit：该作业使用的队列对指定的节点都已在用，作业最终会运行。
  - Priority：作业所需的队列存在高等级作业或预留。
  - Prolog：作业的PrologSlurmctld前处理程序仍旧在运行。
  - QOSJobLimit：作业的QOS达到其最大作业数限制。
  - QOSResourceLimit：作业的QOS达到其最大资源限制。
  - QOSGrpCpuLimit： 作业的QoS的指定所有CPU已被占用，作业最终会运行。
  - QOSGrpMaxJobsLimit：作业的QoS的最大作业数已到，作业最终会运行。
  - QOSGrpNodeLimit：作业的QoS指定的节点都已经被占用，作业最终会运行。
  - QOSTimeLimit：作业的QOS达到其时间限制。
  - QOSUsageThreshold：所需的QOS阈值被违反。
  - ReqNodeNotAvail：作业所需的节点无效，如节点宕机。
  - Reservation：作业等待其预留的资源可用。
  - Resources：作业将要等待所需要的资源满足后才运行。
  - SystemFailure：Slurm系统失效，如文件系统、网络失效等。
  - TimeLimit：作业超过去时间限制。
  - QOSUsageThreshold：所需的QoS阈值被违反。
  - WaitingForScheduling：等待被调度中。

(target-2)=

## squeue主要参数

- -A \<account_list>, --account=\<account_list>：显示用户\<account_list>的作业信息，用户以,分隔。

- -a, --all：显示所有队列中的作业及作业步信息，也显示被配置为对用户组隐藏队列的信息。

- -r, --array：以每行一个作业元素方式显示。

- -h, --noheader：不显示头信息，即不显示第一行“PARTITION AVAIL TIMELIMIT NODES STATE NODELIST”。

- --help：显示帮助信息。

- --hide：不显示隐藏队列中的作业和作业步信息。此为默认行为，不显示配置为对用户组隐藏队列的信息。

- -i \<seconds>, --iterate=\<seconds>：以间隔\<seconds>秒方式循环显示信息。

- -j \<job_id_list>, --jobs=\<job_id_list>：显示作业号\<job_id_list>的作业，作业号以,分隔。--jobs=\<job_id_list>可与--steps选项结合显示特定作业的步信息。作业号格式为“job_id\[\_array_id\]”，默认为64字节，可以用环境变量SLURM_BITSTR_LEN设定更大的字段大小。

- -l, --long：显示更多的作业信息。

- -L, --licenses=\<license_list>：指定使用授权文件\<license_list>，以,分隔。

- -n, --name=\<name_list>：显示具有特定\<name_list>名字的作业，以,分隔。

- --noconvert：不对原始单位做转换，如2048M不转换为2G。

- -p \<part_list>, --partition=\<part_list>：显示特定队列\<part_list>信息，\<part_list>以,分隔。

- -P, --priority：对于提交到多个队列的作业，按照各队列显示其信息。如果作业要按照优先级排序时，需考虑队列和作业优先级。

- -q \<qos_list>, --qos=\<qos_list>：显示特定qos的作业和作业步，\<qos_list>以,分隔。

- -R, --reservation=reservation_name：显示特定预留信息作业。

- -s, --steps：显示特定作业步。作业步格式为“job_id\[\_array_id\].step_id”。

- -S \<sort_list>, --sort=\<sort_list>：按照显示特定字段排序显示，\<sort_list>以,分隔。如-S P,U。

- --start：显示排队中的作业的预期执行时间。

- -t \<state_list>, --states=\<state_list>：显示特定状态\<state_list>的作业信息。\<state_list>以,分隔，有效的可为：PENDING(PD)、RUNNING(R)、SUSPENDED(S)、STOPPED(ST)、COMPLETING(CG)、COMPLETED(CD)、CONFIGURING(CF)、CANCELLED(CA)、FAILED(F)、TIMEOUT(TO)、PREEMPTED(PR)、BOOT_FAIL(BF)、NODE_FAIL(NF)和SPECIAL_EXIT(SE)，注意是不区分大小写的，如“pd”和“PD”是等效的。

- -u \<user_list>, --user=\<user_list>：显示特定用户\<user_list>的作业信息，\<user_list>以,分隔。

- --usage：显示帮助信息。

- -v, --verbose：显示squeue命令详细动作信息。

- -V, --version：显示版本信息。

- -w \<hostlist>, --nodelist=\<hostlist>：显示特定节点\<hostlist>信息，\<hostlist>以,分隔。

- -o \<output_format>, --format=\<output_format>：以特定格式\<output_format>显示信息。参见 -O \<output_format>, --Format=\<output_format>，采用不同参数的默认格式为：

  - default：“%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R”
  - -l, --long： “%.18i %.9P %.8j %.8u %.8T %.10M %.9l %.6D %R”
  - -s, --steps：“%.15i %.8j %.9P %.8u %.9M %N”

  每个字段的格式为“%\[\[.\]size\]type”：

  - size：字段最小尺寸，如果没有指定size，则按照所需长度显示。

  - .：右对齐显示，默认为左对齐。

  - type：类型，一些类型仅对作业有效，而有些仅对作业步有效，有效的类型为：

    - \%all：显示所有字段。

    - \%a：显示记帐信息（仅对作业有效）。

    - \%A：作业步生成的任务数（仅适用于作业步）。

    - \%A：作业号（仅适用于作业）。

    - \%b：作业或作业步所需的普通资源（gres）。

    - \%B：执行作业的节点。

    - \%c：作业每个节点所需的最小CPU数（仅适用于作业）。

    - \%C：如果作业还在运行，显示作业所需的CPU数；如果作业正在完成，显示当前分配给此作业的CPU数（仅适用于作业）。

    - \%d：作业所需的最小临时磁盘空间，单位MB（仅适用于作业）。

    - \%D：作业所需的节点（仅适用于作业）。

    - \%e：作业结束或预期结束时间（基于其时间限制）（仅适用于作业）。

    - \%E：作业依赖剩余情况。作业只有依赖的作业完成才运行，如显示NULL，则无依赖（仅适用于作业）。

    - \%f：作业所需的特性（仅适用于作业）。

    - \%F：作业组作业号（仅适用于作业）。

    - \%g：作业用户组（仅适用于作业）。

    - \%G：作业用户组ID（仅适用于作业）。

    - \%h：分配给此作业的计算资源能否被其它作业预约（仅适用于作业）。可被预约的资源包含节点、CPU颗、CPU核或超线程。值可以为：

      - YES：如果作业提交时含有oversubscribe选项或队列被配置含有OverSubscribe=Force。
      - NO：如果作业所需排他性运行。
      - USER：如果分配的计算节点设定为单个用户。
      - MCS：如果分配的计算节点设定为单个安全类（参看MCSPlugin和MCSParameters配置参数，Multi-Category Security）。
      - OK：其它（典型的分配给专用的CPU）（仅适用于作业）。

    - \%H：作业所需的单节点CPU数，显示srun --sockets-per-node提交选项，如--sockets-per-node未设定，则显示\*（仅适用于作业）。

    - \%i：作业或作业步号，在作业组中，作业号格式为“\<base_job_id>\_\<index>”，默认作业组索引字段限制到64字节，可以用环境变量`SLURM_BITSTR_LEN`设定为更大的字段大小。

    - \%I：作业所需的每颗CPU的CPU核数，显示的是srun --cores-per-socket设定的值，如--cores-per-socket未设定，则显示\*（仅适用于作业）。

    - \%j：作业或作业步名。

    - \%J：作业所需的每个CPU核的线程数，显示的是srun --threads-per-core设定的值，如--threads-per-core未被设置则显示\*（仅适用于作业）。

    - \%k：作业说明（仅适用于作业）。

    - \%K：作业组索引默认作业组索引字段限制到64字节，可以用环境变量`SLURM_BITSTR_LEN`设定为更大的字段大小（仅适用于作业）。

    - \%l：作业或作业步时间限制，格式为“days-hours:minutes:seconds”：NOT_SET表示没有建立；UNLIMITED表示没有限制。

    - \%L：作业剩余时间，格式为“days-hours:minutes:seconds”，此值由作业的时间限制减去已用时间得到：NOT_SET表示没有建立；UNLIMITED表示没有限制（仅适用于作业）。

    - \%m：作业所需的最小内存，单位为MB（仅适用于作业）。

    - \%M：作业或作业步已经使用的时间，格式为“days-hours:minutes:seconds”。

    - \%n：作业所需的节点名（仅适用于作业）。

    - \%N：作业或作业步分配的节点名，对于正在完成的作业，仅显示尚未释放资源回归服务的节点。

    - \%o：执行的命令。

    - \%O：作业是否需连续节点（仅适用于作业）。

    - \%p：作业的优先级（0.0到1.0之间），参见%Q（仅适用于作业）。

    - \%P：作业或作业步的队列。

    - \%q：作业关联服务的品质（仅适用于作业）。

    - \%Q：作业优先级（通常为非常大的一个无符号整数），参见%p（仅适用于作业）。

    - \%r：作业在当前状态的原因，参见JOB REASON CODES（仅适用于作业）。

    - \%R：参见JOB REASON CODES（仅适用于作业）：

      - 对于排队中的作业：作业没有执行的原因。
      - 对于出错终止的作业：作业出错的解释。
      - 对于其他作业状态：分配的节点。

    - \%S：作业或作业步实际或预期的开始时间。

    - \%t：作业状态，以紧凑格式显示：PD（排队pending）、R（运行running）、CA（取消cancelled）、CF(配置中configuring）、CG（完成中completing）、CD（已完成completed）、F（失败failed）、TO（超时timeout）、NF（节点失效node failure)和SE（特殊退出状态special exit state），参见JOB STATE CODES（仅适用于作业）。

    - \%T：作业状态，以扩展格式显示：PENDING、RUNNING、SUSPENDED、CANCELLED、COMPLETING、COMPLETED、CONFIGURING、FAILED、TIMEOUT、PREEMPTED、NODE_FAIL和SPECIAL_EXIT，参见JOB STATE CODES（仅适用于作业）。

    - \%u：作业或作业步的用户名。

    - \%U：作业或作业步的用户ID。

    - \%v：作业的预留资源（仅适用于作业）。

    - \%V：作业的提交时间。

    - \%w：工程量特性关键Workload Characterization Key（wckey）（仅适用于作业）。

    - \%W：作业预留的授权（仅适用于作业）。

    - \%x：作业排他性节点名（仅适用于作业）。

    - \%X：系统使用需每个节点预留的CPU核数（仅适用于作业）。

    - \%y：Nice值（调整作业调动优先级）（仅适用于作业）。

    - \%Y：对于排队中作业，显示其开始运行时期望的节点名。

    - \%z：作业所需的每个节点的CPU颗数、CPU核数和线程数（S:C:T），如（S:C:T）未设置，则显示\*（仅适用于作业）。

    - \%Z：作业的工作目录。

- -O \<output_format>, --Format=\<output_format>：以特定格式\<output_format>显示信息，参见-o \<output_format>, --format=\<output_format> 每个字段的格式为“%\[\[.\]size\]type”：

  - size：字段最小尺寸，如果没有指定size，则最长显示20个字符。

  - .：右对齐显示，默认为左对齐。

  - type：类型，一些类型仅对作业有效，而有些仅对作业步有效，有效的类型为：

    - account：作业记账信息（仅适用于作业）。

    - allocnodes：作业分配的节点（仅适用于作业）。

    - allocsid：用于提交作业的会话ID（仅适用于作业）。

    - arrayjobid：作业组中的作业ID。

    - arraytaskid：作业组中的任务ID。

    - associd：作业关联ID（仅适用于作业）。

    - batchflag：是否批处理设定了标记（仅适用于作业）。

    - batchhost：执行节点（仅适用于作业）：

      - 对于分配的会话：显示的是会话执行的节点（如，`srun`或`salloc`命令执行的节点）。
      - 对于批处理作业：显示的执行批处理的节点。

    - chptdir：作业checkpoint的写目录（仅适用于作业步）。

    - chptinter：作业checkpoint时间间隔（仅适用于作业步）。

    - command：作业执行的命令（仅适用于作业）。

    - comment：作业关联的说明（仅适用于作业）。

    - contiguous：作业是否要求连续节点（仅适用于作业）。

    - cores：作业所需的每颗CPU的CPU核数，显示的是srun --cores-per-socket设定的值，如--cores-per-socket未设定，则显示\*（仅适用于作业）。

    - corespec：为了系统使用所预留的CPU核数（仅适用于作业）。

    - cpufreq：分配的CPU主频（仅适用于作业步）。

    - cpuspertask：作业分配的每个任务的CPU颗数（仅适用于作业）。

    - deadline：作业的截止时间（仅适用于作业）。

    - dependency：作业依赖剩余。作业只有依赖的作业完成才运行，如显示NULL，则无依赖（仅适用于作业）。

    - derivedec：作业的起源退出码，对任意作业步是最高退出码（仅适用于作业）。

    - eligibletime：预计作业开始运行时间（仅适用于作业）。

    - endtime：作业实际或预期的终止时间（仅适用于作业）。

    - exit_code：作业退出码（仅适用于作业）。

    - feature：作业所需的特性（仅适用于作业）。

    - gres：作业或作业步需的通用资源（gres）。

    - groupid：作业用户组ID（仅适用于作业）。

    - groupname：作业用户组名（仅适用于作业）。

    - jobarrayid：作业组作业ID（仅适用于作业）。

    - jobid：作业号（仅适用于作业）。

    - licenses：作业预留的授权（仅适用于作业）。

    - maxcpus：分配给作业的最大CPU颗数（仅适用于作业）。

    - maxnodes：分配给作业的最大节点数（仅适用于作业）。

    - mcslabel：作业的MCS_label（仅适用于作业）。

    - minmemory：作业所需的最小内存大小，单位MB（仅适用于作业）。

    - mintime：作业的最小时间限制（仅适用于作业）。

    - mintmpdisk：作业所需的临时磁盘空间，单位MB（仅适用于作业）。

    - mincpus：作业所需的各节点最小CPU颗数，显示的是`srun --mincpus`设定的值（仅适用于作业）。

    - name：作业或作业步名。

    - network：作业运行的网络。

    - nice Nice值(调整作业调度优先值)（仅适用于作业）。

    - nodes：作业或作业步分配的节点名，对于正在完成的作业，仅显示尚未释放资源回归服务的节点。

    - nodelist：作业或作业步分配的节点，对于正在完成的作业，仅显示尚未释放资源回归服务的节点，格式类似node\[1-10,11,13-28\]。

    - ntpercore：作业每个CPU核分配的任务数（仅适用于作业）。

    - ntpernode：作业每个节点分配的任务数（仅适用于作业）。

    - ntpersocket：作业每颗CPU分配的任务数（仅适用于作业）。

    - numcpus：作业所需的或分配的CPU颗数。

    - numnodes：作业所需的或分配的最小节点数（仅适用于作业）。

    - numtask：作业或作业号需的任务数，显示的--ntasks设定的。

    - oversubscribe：分配给此作业的计算资源能否被其它作业预约（仅适用于作业）。可被预约的资源包含节点、CPU颗、CPU核或超线程。值可以为：

      - YES：如果作业提交时含有oversubscribe选项或队列被配置含有OverSubscribe=Force。
      - NO：如果作业所需排他性运行。
      - USER：如果分配的计算节点设定为单个用户。
      - MCS：如果分配的计算节点设定为单个安全类（参看MCSPlugin和MCSParameters配置参数）。
      - OK：其它(典型分配给指定CPU)。

    - partition：作业或作业步的队列。

    - priority：作业的优先级（0.0到1.0之间），参见%Q（仅适用于作业）。

    - prioritylong：作业优先级（通常为非常大的一个无符号整数），参见%p（仅适用于作业）。

    - profile：作业特征（仅适用于作业）。

    - preemptime：作业抢占时间（仅适用于作业）。

    - qos：作业的服务质量（仅适用于作业）。

    - reason：作业在当前的原因，参见JOB REASON CODES（仅适用于作业）。

    - reasonlist：参见JOB REASON CODES（仅适用于作业）。

      - 对于排队中的作业：作业没有执行的原因。
      - 对于出错终止的作业：作业出错的解释。
      - 对于其他作业状态：分配的节点。

    - reqnodes：作业所需的节点名（仅适用于作业）。

    - requeue：作业失败时是否需重新排队运行（仅适用于作业）。

    - reservation：预留资源（仅适用于作业）。

    - resizetime：运行作业的变化时间总和（仅适用于作业）。

    - restartcnt：作业的重启checkpoint数（仅适用于作业）。

    - resvport：作业的预留端口（仅适用于作业步）。

    - schednodes：排队中的作业开始运行时预期将被用的节点列表（仅适用于作业）。

    - sct：各节点作业所需的CPU数、CPU核数和线程数（S:C:T），如（S:C:T）未设置，则显示\*（仅适用于作业）。

    - selectjobinfo：节点选择插件针对作业指定的数据，可能的数据包含：资源分配的几何维度（X、Y、Z维度）、连接类型（TORUS、MESH或NAV == torus else mesh），是否允许几何旋转（yes或no），节点使用（VIRTUAL或COPROCESSOR）等（仅适用于作业）。

    - sockets：作业每个节点需的CPU数，显示srun时的--sockets-per-node选项，如--sockets-per-node未设置，则显示\*（仅适用于作业）。

    - sperboard：每个主板分配给作业的CPU数（仅适用于作业）。

    - starttime：作业或作业布实际或预期开始时间。

    - state：扩展格式作业状态：排队中PENDING、运行中RUNNING、已停止STOPPED、被挂起SUSPENDED、被取消CANCELLED、完成中COMPLETING、已完成COMPLETED、配置中CONFIGURING、已失败FAILED、超时TIMEOUT、预取PREEMPTED、节点失效NODE_FAIL、特定退出SPECIAL_EXIT，参见JOB STATE CODES部分（仅适用于作业）。

    - statecompact：紧凑格式作业状态：PD（排队中pending）、R（运行中running）、CA（已取消cancelled）、CF(配置中configuring）、CG（完成中completing）、CD（已完成completed）、F（已失败failed）、TO（超时timeout）、NF（节点失效node failure）和SE（特定退出状态special exit state），参见JOB STATE CODES部分（仅适用于作业）。

    - stderr：标准出错输出目录（仅适用于作业）。

    - stdin：标准输入目录（仅适用于作业）。

    - stdout：标准输出目录（仅适用于作业）。

    - stepid：作业或作业步号。在作业组中，作业号格式为“\<base_job_id>\_\<index>”（仅适用于作业步）。

    - stepname：作业步名（仅适用于作业步）。

    - stepstate：作业步状态（仅适用于作业步）。

    - submittime：作业提交时间（仅适用于作业）。

    - threads：作业所需的每颗CPU核的线程数，显示srun的--threads-per-core参数，如--threads-per-core未设置，则显示\*（仅适用于作业）。

    - timeleft：作业剩余时间，格式为“days-hours:minutes:seconds”，此值是通过其时间限制减去已运行时间得出的：如未建立则显示“NOT_SET”；如无限制则显示“UNLIMITED”（仅适用于作业）。

    - timelimit：作业或作业步的时间限制。

    - timeused：作业或作业步以使用时间，格式为“days-hours:minutes:seconds”，days和hours只有需要时才显示。对于作业步，显示从执行开始经过的时间，因此对于被曾挂起的作业并不准确。节点间的时间差也会导致时间不准确。如时间不对（如，负值），将显示“INVALID”。

    - tres：显示分配给作业的可被追踪的资源。

    - userid：作业或作业步的用户ID。

    - username：作业或作业步的用户名。

    - wait4switch：需满足转轨器数目的总等待时间（仅适用于作业）。

    - wckey：工作负荷特征关键（wckey）（仅适用于作业）。

    - workdir：作业工作目录（仅适用于作业）。
