# 作业提交命令共同说明

提交作业的命令主要有 `salloc`、`sbatch` 与 `srun`，其多数参数、输入输出变量等都是一样的。

对于上述三个命令各自的说明，请参阅：
- [交互式提交并行作业：srun](./srun.md)
- [批处理方式提交作业：sbatch](./sbatch.md)
- [分配式提交作业：salloc](./salloc.md)

!!! info "说明"
	关于如何在嘉庚智算上提交作业，请参阅[快速上手](../usage/quick-start.md)部分的说明。
	
	关于队列的相关设置和说明，请参阅 [分区规则和收费标准](../introduction/partition.md)。

## TLDR : 作业提交常用参数

| 参数选项                             | 含义                                                                |
| -------------------------------- | ----------------------------------------------------------------- |
| `-A` 或 `--account`               | 指定该作业使用 `<account>` 账户下的经费。                                       |
| `-N` 或 `--nodes`                 | 作业的节点数。                                                           |
| `-c` 或 `--cpus-per-task=<ncpus>` | 每个进程使用的 CPU 核数。通常设置与 `OMP_NUM_THREADS` 相同的数值。                     |
| `-n` 或 `--ntasks`                | 设定所需要的进程总数。通常设置与 `mpirun -np <nprocs>` 中的 `<nprocs>` 相同的数值。       |
| `--ntasks-per-node`              | 设定每个节点产生的进程总数。                                                    |
| `-t` 或 `--time`                  | 作业的最长运行时间，格式为 `HH:MM:SS`。                                         |
| `--mem`                          | 每个节点分配的内存量，例如 `--mem=4G` 表示 4GB 内存。                               |
| `--gres`                         | 指定通用资源（如 GPU）的数量，例如 `--gres=gpu:2` 表示使用 2 张 GPU。                  |
| `-p` 或 `--partition`             | 指定作业提交的分区（队列）。                                                    |
| `-J` 或 `--job-name`              | 指定作业的名称。                                                          |
| `-o` 或 ` --output `              | 指定标准输出文件的路径和名称。                                                   |
| `-e` 或 `--error`                 | 指定标准错误文件的路径和名称。                                                   |
| `-x` 或 ` --exclusive `           | 独占节点，不允许其他作业共享该节点。<br>**注意：此时计费按照整个节点全部资源而非所申请的资源。**              |
| `-d` 或 ` --dependency`           | 指定作业依赖关系，例如 `--dependency=afterok:<jobid>` 表示作业在 `<jobid>` 完成后开始。 |
| `-q` 或 `--qos`                   | 指定作业的服务质量（QOS, Quality of Service）。                               |
| `-D` 或 `--chdir`                 | 指定作业的工作目录，即命令执行的路径。默认为当前目录。                                       |
<!-- 需要测试可用性，暂不显示
| `--cpus-per-gpu`                  | 每张 GPU 卡使用的 CPU 核数。<br>**注意：与 `-c` 或 `--cpus-per-task` 不兼容。** |
| `--array`                          | 提交作业数组，例如 `--array=1-10` 表示提交 10 个作业。                      |
| `--export`                         | 指定环境变量，例如 `--export=ALL, VAR 1=value 1, VAR 2=value 2`。   |
| `--reservation`                    | 指定作业使用的预留资源。                                                  |
| `--mail-type`                      | 指定邮件通知的类型（如 `BEGIN`, `END`, `FAIL`）。                          |
| `--mail-user`                      | 指定接收邮件通知的用户邮箱地址。                                            |
| `--no-requeue`                     | 防止作业在系统重启后重新排队。                                              |
| `--signal`                         | 指定在作业结束前发送的信号，例如 `--signal=B: USR1@60 ` 表示在作业结束前 60 秒发送 USR 1 信号。 |
| `--open-mode`                      | 指定输出文件的打开模式（如 `append` 或 `truncate`）。                  |
| `--wrap`                           | 使用 `sbatch` 时，直接在命令行中指定作业脚本内容。                           |
-->

!!! tip "提示"
	- 每节点申请的 CPU 核数=每节点进程数 (`--ntasks-per-node`) ×每进程核数 (`--cpus-per-task`) 
	- 实际分配的 CPU 核数=节点数(`-N`)×每节点 CPU 核数=总进程数 (`--ntasks`) ×每进程核数 (`--cpus-per-task`) 
	- `sbatch` 仅根据上述资源绑定关系申请对应的资源，实际 MPI 进程数和 OpenMP 线程数须由用户在作业批处理脚本中自行指定。
	- `srun` 会根据所申请的进程数和每个进程所需的核数创建对应的 MPI 进程，此时若命令未正确设置可能导致同个程序被重复运行多次。对于 MPI 任务，在使用 `srun` 的情况下，请勿重复执行 `mpirun`。
## 主要参数

以下列出  `salloc`、`sbatch` 与 `srun`  三个命令共通的主要参数。对于各命令分别对应的详细说明，请分别参见各自的文档。

- `-A`, `--account=<account>`：指定此作业的责任资源为账户 `<account>`，即账单（与计算费对应）记哪个名下，只有账户属于多个账单组才有权指定。
- `--accel-bind=<options>`：`srun` 特有，控制如何绑定作业到GPU、网络等特定资源，支持同时多个选项，支持的选项如下：
    - `g`：绑定到离分配的CPU最近的GPU
    - `m`：绑定到离分配的CPU最近的MIC
    - `n`：绑定到离分配的CPU最近的网卡
    - `v`：详细模式，显示如何绑定GPU和网卡等等信息
- `--acctg-freq`：指定作业记账和剖面信息采样间隔。支持的格式为 `--acctg-freq=<datatype>=<interval>`，其中 `<datatype>=<interval>` 指定了任务抽样间隔或剖面抽样间隔。多个 `<datatype>=<interval>` 可以采用,分隔（默认为30秒）：
    - `task=<interval>`：以秒为单位的任务抽样（需要 `jobacct_gather` 插件启用）和任务剖面（需要 `acct_gather_profile` 插件启用）间隔。
    - `energy=<interval>`：以秒为单位的能源剖面抽样间隔，需要 `acct_gather_energy` 插件启用。
    - `network=<interval>`：以秒为单位的InfiniBand网络剖面抽样间隔，需要 `acct_gather_infiniband` 插件启用。
    - `filesystem=<interval>`：以秒为单位的文件系统剖面抽样间隔，需要 `acct_gather_filesystem` 插件启用。
- `-B --extra-node-info=<sockets[:cores[:threads]]>`：选择满足 `<sockets[:cores[:threads]]>` 的节点，\*表示对应选项不做限制。对应限制可以采用下面对应选项：
    - `--sockets-per-node=<sockets>`
    - `--cores-per-socket=<cores>`
    - `--threads-per-core=<threads>`
- `--bcast[=<dest_path>]`：`srun` 特有，复制可执行程序到分配的计算节点的 `<dest_path>` 目录。如指定了 `<dest_path>`，则复制可执行程序到此；如没指定则复制到当前工作目录下的 `slurm_bcast_<job_id>.<step_id>`。如 `srun --bcast=/tmp/mine -N3 a.out` 将从当前目录复制 `a.out` 到每个分配的节点的 `/tmp/min` 并执行。
- `--begin=<time>`：设定开始分配资源运行的时间。时间格式可为HH:MM:SS，或添加AM、PM等，也可采用MMDDYY、MM/DD/YY或YYYY-MM-DD格式指定日期，含有日期及时间的格式为：`YYYY-MM-DD[THH:MM[:SS]]`，也可以采用类似now+时间单位的方式，时间单位可以为seconds（默认）、minutes、hours、days和weeks、today、tomorrow等，例如：
    - `--begin=16:00`：16:00开始。
    - `--begin=now+1hour`：1小时后开始。
    - `--begin=now+60`：60秒后开始（默认单位为秒）。
    - `--begin=2017-02-20T12:34:00`：2017-02-20T12:34:00开始。
- `--bell`：分配资源时终端响铃，参见 `--no-bell`。
- `--cpu-bind=[quiet,verbose,]type`：`srun` 特有，设定CPU绑定模式。
- `--comment=<string>`：作业说明。
- `--contiguous`：需分配到连续节点，一般来说连续节点之间网络会快一点，如在同一个IB交换机内，但有可能导致开始运行时间推迟（需等待足够多的连续节点）。
- `--cores-per-socket=<cores>`：分配的节点需要每颗CPU至少 `<cores>` CPU核。
- `--cpus-per-gpu=<ncpus>`：每颗GPU需 `<ncpus>` 个CPU核，与 `--cpus-per-task` 不兼容。
- `-c`, `--cpus-per-task=<ncpus>`：每个进程需 `<ncpus>` 颗CPU核，一般运行OpenMP等多线程程序时需，普通MPI程序不需。
- `--deadline=<OPT>`：如果在此 deadline（start > (deadline - time\[-min\]）之前没有结束，那么移除此作业。默认没有 deadline，有效的时间格式为：
    - `HH:MM[:SS] [AM|PM]`
    - `MMDD[YY]`或 `MM/DD[/YY]` 或 `MM.DD[.YY]`
    - `MM/DD[/YY]-HH:MM[:SS]`
    - `YYYY-MM-DD[THH:MM[:SS]]]`
- `-d`, `--dependency=<dependency_list>`：满足依赖条件 `<dependency_list>` 后开始分配。`<dependency_list>` 可以为 `<type:job_id[:job_id][,type:job_id[:job_id]]>` 或\<type:job_id\[:job_id\]\[?type:job_id\[:job_id\]\]>。依赖条件如果用,分隔，则各依赖条件都需要满足；如果采用?分隔，那么只要任意条件满足即可。可以为：
  - after:job_id\[:jobid...\]：当指定作业号的作业结束后开始运行。
  - afterany:job_id\[:jobid...\]：当指定作业号的任意作业结束后开始运行。
  - aftercorr:job_id\[:jobid...\]：当相应任务号任务结束后，此作业组中的开始运行。
  - afternotok:job_id\[:jobid...\]：当指定作业号的作业结束时具有异常状态（非零退出码、节点失效、超时等）时。
  - afterok:job_id\[:jobid...\]：当指定的作业正常结束（退出码为0）时开始运行。
  - expand:job_id：分配给此作业的资源将扩展给指定作业。
  - singleton：等任意通账户的相同作业名的前置作业结束时。
- -D, --chdir=\<path>：在切换到\<path>工作目录后执行命令。
- -e, --error=\<mode>：设定标准错误如何重定向。非交互模式下，默认srun重定向标准错误到与标准输出同样的文件（如指定）。此参数可以指定重定向到不同文件。如果指定的文件已经存在，那么将被覆盖。参见IO重定向。`salloc`无此选项。
- --epilog=\<executable>：`srun特有`，作业结束后执行\<executable>程序做相应处理。
- -E, --preserve-env：将环境变量`SLURM_NNODES`和`SLURM_NTASKS`传递给可执行文件，而无需通过计算命令行参数。
- --exclusive\[=user|mcs\]：排他性运行，独占性运行，此节点不允许其他\[user\]用户或mcs选项的作业共享运行作业。
- --export=\<\[ALL,\]environment variables|ALL|NONE>：`sbatch与srun特有`，将环境变量传递给应用程序
  - ALL：复制所有提交节点的环境变量，为默认选项。
  - NONE：所有环境变量都不被传递，可执行程序必须采用绝对路径。一般用于当提交时使用的集群与运行集群不同时。
  - \[ALL,\]environment variables：复制全部环境变量及特定的环境变量及其值，可以有多个以,分隔的变量。如：“--export=EDITOR,ARG1=test”。
- --export-file=\<filename | fd>：`sbatch特有`，将特定文件中的变量设置传递到计算节点，这允许在定义环境变量时有特殊字符。
- -F, --nodefile=\<node file>：类似--nodelist指定需要运行的节点，但在一个文件中含有节点列表。

- -G, --gpus=\[\<type>:\]\<number>：设定使用的GPU类型及数目，如--gpus=v100:2。

- --gpus-per-node=\[\<type>:\]\<number>：设定单个节点使用的GPU类型及数目。

- --gpus-per-socket=\[\<type>:\]\<number>：设定每个socket需要的GPU类型及数目。

- --gpus-per-task=\[\<type>:\]\<number>：设定每个任务需要的GPU类型及数目。

- --gres=\<list>：设定通用消费资源，可以以,分隔。每个\<list>格式为“name\[\[:type\]:count\]”。name是可消费资源；count是资源个数，默认为1；

- -H, --hold：设定作业将被提交为挂起状态。挂起的作业可以利用scontrol release \<job_id>使其排队运行。

- -h, --help：显示帮助信息。

- --hint=\<type>：绑定任务到应用提示：

  - compute_bound：选择设定计算边界应用：采用每个socket的所有CPU核，每颗CPU核一个进程。
  - memory_bound：选择设定内存边界应用：仅采用每个socket的1颗CPU核，每颗CPU核一个进程。
  - multithread：在in-core multi-threading是否采用额外的线程，对通信密集型应用有益。仅当task/affinity插件启用时。
  - help：显示帮助信息

- -I, --immediate\[=\<seconds>\]：`salloc与srun特有`，在\<seconds>秒内资源未满足的话立即退出。格式可以为“-I60”，但不能之间有空格是“-I 60”。

- --ignore-pbs：`sbatch特有`，忽略批处理脚本中的“#PBS”选项。

- -i, --input=\<mode>：`sbatch与srun特有`，指定标准输入如何重定向。默认，srun对所有任务重定向标准输入为从终端。参见IO重定向。

- -J, --job-name=\<jobname>：设定作业名\<jobname>，默认为命令名。

- --jobid=\<jobid>：`srun特有`，初始作业步到某个已分配的作业号\<jobid>下的作业下，类似设置了`SLURM_JOB_ID`环境变量。仅对作业步申请有效。

- -K, --kill-command\[=signal\]：`salloc特有`，设定需要终止时的signal，默认，如没指定，则对于交互式作业为SIGHUP，对于非交互式作业为SIGTERM。格式类似可以为“-K1”，但不能包含空格为“-K 1”。

- -K,–kill-on-bad-exit\[=0|1\]：`srun特有`，设定是否任何一个任务退出码为非0时，是否终止作业步。

- -k, --no-kill：如果分配的节点失效，那么不会自动终止。

- -L, --licenses=\<license>：设定使用的\<license>。

- -l, --label：`srun特有`，在标注正常输出或标准错误输出的行前面添加作业号。

- --mem=\<size\[units\]>：设定每个节点的内存大小，后缀可以为\[K|M|G|T\]，默认为MB。

- --mem-per-cpu=\<size\[units\]>：设定分配的每颗CPU对应最小内存，后缀可以为\[K|M|G|T\]，默认为MB。

- --mem-per-gpu=\<size\[units\]>：设定分配的每颗GPU对应最小内存，后缀可以为\[K|M|G|T\]，默认为MB。

- --mincpus=\<n>：设定每个节点最小的逻辑CPU核/处理器。

- --mpi=\<mpi_type>：`srun特有`，指定使用的MPI环境，\<mpi_type>可以主要为：

  - list：列出可用的MPI以便选择。
  - pmi2：启用PMI2支持
  - pmix：启用PMIx支持
  - none：默认选项，多种其它MPI实现有效。

- --multi-prog：`srun特有`，让不同任务运行不同的程序及参数，需指定一个配置文件，参见MULTIPLE PROGRAM CONFIGURATION。

- -N, --nodes=\<minnodes\[-maxnodes\]>：采用特定节点数运行作业，如没指定maxnodes则需特定节点数，注意，这里是节点数，不是CPU核数，实际分配的是节点数×每节点CPU核数。

- --nice\[=adjustment\]：设定NICE调整值。负值提高优先级，正值降低优先级。调整范围为：+/-2147483645。

- -n, --ntasks=\<number>：设定所需要的任务总数。默认是每个节点1个任务，注意是节点，不是CPU核。仅对作业起作用，不对作业步起作用。--cpus-per-task选项可以改变此默认选项。

- --ntasks-per-core=\<ntasks>：每颗CPU核运行\<ntasks>个任务，需与-n, --ntasks=\<number>配合，并自动绑定\<ntasks>个任务到每个CPU核。仅对作业起作用，不对作业步起作用。

- --ntasks-per-node=\<ntasks>：每个节点运行\<ntasks>个任务，需与-n, --ntasks=\<number>配合。仅对作业起作用，不对作业步起作用。

- --ntasks-per-socket=\<ntasks>：每颗CPU运行\<ntasks>个任务，需与-n, --ntasks=\<number>配合，并绑定\<ntasks>个任务到每颗CPU。仅对作业起作用，不对作业步起作用。

- --no-bell：`salloc特有`，资源分配时不终端响铃。参见--bell。

- --no-shell：`salloc特有`，分配资源后立即退出，而不运行命令。但Slurm作业仍旧被生成，在其激活期间，且保留这些激活的资源。用户会获得一个没有附带进程和任务的作业号，用户可以采用提交srun命令到这些资源。

- -o, --output=\<mode>：`sbatch与srun特有`，指定标准输出重定向。在非交互模式中，默认srun收集各任务的标准输出，并发送到吸附的终端上。采用--output可以将其重定向到同一个文件、每个任务一个文件或/dev/null等。参见IO重定向。

- --open-mode=\<append|truncate>：`sbtach与srun特有`，对标准输出和标准错误输出采用追加模式还是覆盖模式。

- -O, --overcommit：采用此选项可以使得每颗CPU运行不止一个任务。

- --open-mode=\<append|truncate>：标准输出和标准错误输出打开文件的方式：

  - append：追加。
  - truncate：截断覆盖。

- -p, --partition=\<partition_names>：使用\<partition_names>队列

- --prolog=\<executable>：`srun特有`，作业开始运行前执行\<executable>程序，做相应处理。

- -Q, --quiet：采用安静模式运行，一般信息将不显示，但错误信息仍将被显示。

- --qos=\<qos>：需要特定的服务质量(QS)。

- --quit-on-interrupt：`srun特有`，当SIGINT (Ctrl-C)时立即退出。

- -r, --relative=\<n>：`srun特有`，在当前分配的第n节点上运行作业步。该选项可用于分配一些作业步到当前作业占用的节点外的节点，节点号从0开始。-r选项不能与-w或-x同时使用。仅对作业步有效。

- --reservation=\<name>：从\<name>预留资源分配。

- –requeue：`sbtach特有`，当非配的节点失效或被更高级作业抢占资源后，重新运行该作业。相当于重新运行批处理脚本，小心已运行的结果被覆盖等。

- --no-requeue：任何情况下都不重新运行。

- -S, --core-spec=\<num>：指定预留的不被作业使用的各节点CPU核数。但也会被记入费用。

- --signal=\<sig_num>\[@\<sig_time>\]：设定到其终止时间前信号时间\<sig_time>秒时的信号。由于Slurm事件处理的时间精度，信号有可能比设定时间早60秒。信号可以为10或USER1，信号时间sig_time必须在0到65535之间，如没指定，则默认为60秒。

- --sockets-per-node=\<sockets>：设定每个节点的CPU颗数。

- -T, --threads=\<nthreads>：`srun特有`，限制从srun进程发送到分配节点上的并发线程数。

- -t, --time=\<time>：作业最大运行总时间\<time>，到时间后将被终止掉。时间\<time>的格式可以为：分钟、分钟:秒、小时:分钟:秒、天-小时、天-小时:分钟、天-小时:分钟:秒

- --task-epilog=\<executable>：`srun特有`，任务终止后立即执行\<executable>，对应于作业步分配。

- --task-prolog=\<executable>：`srun特有`，任务开始前立即执行\<executable>，对应于作业步分配。

- --test-only：`sbatch与srun特有`，测试批处理脚本，并预计将被执行的时间，但并不实际执行脚本。

- --thread-spec=\<num>：设定指定预留的不被作业使用的各节点线程数。

- --threads-per-core=\<threads>：每颗CPU核运行\<threads>个线程。

- --time-min=\<time>：设定作业分配的最小时间，设定后作业的运行时间将使得--time设定的时间不少于--time-min设定的。时间格式为：minutes、minutes:seconds、hours:minutes:seconds、days-hours、days-hours:minutes和days-hours:minutes:seconds。

- --usage：显示简略帮助信息

- --tmp=\<size\[units\]>：设定/tmp目录最小磁盘空间，后缀可以为\[K|M|G|T\]，默认为MB。

- -u, --usage：显示简要帮助信息。

- -u, --unbuffered：`srun特有`，该选项使得输出可以不被缓存立即显示出来。默认应用的标准输出被glibc缓存，除非被刷新(flush)或输出被设定为步缓存。

- --use-min-nodes：设定如果给了一个节点数范围，分配时，选择较小的数。

- -V, --version：显示版本信息。

- -v, --verbose：显示详细信息，多个v会显示更详细的详细。

- -W, --wait=\<seconds>：设定在第一个任务结束后多久结束全部任务。

- -w, --nodelist=\<host1,host2,... or filename>：在特定\<host1,host2>节点或filename文件中指定的节点上运行。

- --wait-all-nodes=\<value>：`salloc与sbatch特有`，控制当节点准备好时何时运行命令。默认，当分配的资源准备好后`salloc`命令立即返回。\<value>可以为：

  - 0：当分配的资源可以分配时立即执行，比如有节点以重启好。
  - 1：只有当分配的所有节点都准备好时才执行

- -X, --disable-status：`srun特有`，禁止在srun收到SIGINT (Ctrl-C)时显示任务状态。

- -x, --exclude=\<host1,host2,... or filename>：在特定\<host1,host2>节点或filename文件中指定的节点之外的节点上运行。

## IO重定向

默认标准输出文件和标准出错文件将从所有任务中被重定向到`sbatch和srun` `（salloc不存在IO重定向）`的标准输出文件和标准出错文件，标准输入文件从srun的标准输输入文件重定向到所有任务。如果标准输入仅仅是几个任务需要，建议采用读文件方式而不是重定向方式，以免输入错误数据。

以上行为可以通过--output、--error和--input(-o、-e、-i)等选项改变，有效的格式为：

- all：标准输出和标准出错从所有任务定向到srun，标准输入文件从srun的标准输输入文件重定向到所有任务（默认）。

- none：标准输出和标准出错不从任何任务定向到srun，标准输入文件不从srun定向到任何任务。

- taskid：标准输出和/或标准出错仅从任务号为taskid的任务定向到srun，标准输入文件仅从srun定向到任务号为taskid任务。

- filename: srun将所有任务的标准输出和标准出错重定向到filename文件，标准输入文件将从filename文件重定向到全部任务。

- 格式化字符：srun允许生成采用格式化字符命名的上述IO文件，如可以结合作业号、作业步、节点或任务等。

  - \\：不处理任何代替符。
  - \%%：字符“%”。
  - \%A：作业组的主作业分配号。
  - \%a：作业组ID号。
  - \%J：运行作业的作业号.步号（如128.0）。
  - \%j：运行作业的作业号
  - \%s：运行作业的作业步号。
  - \%N：短格式节点名，每个节点将生成的不同的IO文件。
  - \%n：当前作业相关的节点标记（如“0”是运行作业的第一个节点），每个节点将生成的不同的IO文件。
  - \%t：与当前作业相关的任务标记(rank)，每个rank将生成一个不同的IO文件。
  - \%u：用户名。

  在%与格式化标记符之间的数字可以用于生成前导零，如：

  - job%J.out：job128.0.out。
  - job%4j.out：job0128.out。
  - job%j-%2t.out：job128-00.out、job128-01.out、...。
