# 基本概念

## 三种模式区别

- 批处理作业（采用 `sbatch` 命令提交，最常用方式）：

  对于批处理作业（提交后立即返回该命令行终端，用户可进行其它操作）使用 `sbatch` 命令提交作业脚本，作业被调度运行后，在所分配的首个节点上执行作业脚本。在作业脚本中也可使用 `srun` 命令加载作业任务。提交时采用的命令行终端终止，也不影响作业运行。

- 交互式作业提交（采用 `srun` 命令提交）：

  资源分配与任务加载两步均通过 `srun` 命令进行：当在登录shell中执行 `srun` 命令时，`srun` 首先向系统提交作业请求并等待资源分配，然后在所分配的节点上加载作业任务。采用该模式，用户在该终端需等待任务结束才能继续其它操作，在作业结束前，如果提交时的命令行终端断开，则任务终止。一般用于短时间小作业测试。

- 实时分配模式作业（采用 `salloc` 命令提交）：

  分配作业模式类似于交互式作业模式和批处理作业模式的融合。用户需指定所需要的资源条件，向资源管理器提出作业的资源分配请求。提交后，作业处于排队，当用户请求资源被满足时，将在用户提交作业的节点上执行用户所指定的命令，指定的命令执行结束后，作业运行结束，用户申请的资源被释放。在作业结束前，如果提交时的命令行终端断开，则任务终止。典型用途是分配资源并启动一个shell，然后在这个shell中利用 `srun` 运行并行作业。

  `salloc` 后面如果没有跟定相应的脚本或可执行文件，则默认选择 `/bin/sh`，用户获得了一个合适环境变量的shell环境。

  `salloc` 和`sbatch`最主要的区别是 `salloc` 命令资源请求被满足时，直接在提交作业的节点执行相应任务，而 `sbatch` 则当资源请求被满足时，在分配的第一个节点上执行相应任务。

  `salloc` 在分配资源后，再执行相应的任务，很适合需要指定运行节点和其它资源限制，并有特定命令的作业。

## 基本用户命令

- `sacct`：显示激活的或已完成作业或作业步的记账（对应需缴纳的机时费）信息。
- `salloc`：为需实时处理的作业分配资源，典型场景为分配资源并启动一个shell，然后用此shell执行`srun`命令去执行并行任务。
- `sattach`：吸附到运行中的作业步的标准输入、输出及出错，通过吸附，使得有能力监控运行中的作业步的IO等。
- `sbatch`：提交作业脚本使其运行。此脚本一般也可含有一个或多个`srun`命令启动并行任务。
- `sbcast`：将本地存储中的文件传递分配给作业的节点上，比如`/tmp`等本地目录；对于`/home`等共享目录，因各节点已经是同样文件，无需使用。
- `scancel`：取消排队或运行中的作业或作业步，还可用于发送任意信号到运行中的作业或作业步中的所有进程。
- `scontrol`：显示或设定Slurm作业、队列、节点等状态。
- `sinfo`：显示队列或节点状态，具有非常多过滤、排序和格式化等选项。
- `speek`：查看作业屏幕输出。注：该命令是本人写的，不是slurm官方命令，在其它系统上不一定有。
- `squeue`：显示队列中的作业及作业步状态，含非常多过滤、排序和格式化等选项。
- `srun`：实时交互式运行并行作业，一般用于段时间测试，或者与`sallcoc`及`sbatch`结合。

## 基本术语

- `socket`：CPU插槽，可以简单理解为CPU。
- `core`：CPU核，单颗CPU可以具有多颗CPU核。
- `job`：作业。
- `job step`：作业步，单个作业（job）可以有个多作业步。
- `tasks`：任务数，单个作业或作业步可有多个任务，一般一个任务需一个CPU核，可理解为所需的CPU核数。
- `rank`：秩，如MPI进程号。
- `partition`：队列、分区。作业需在特定队列中运行，一般不同队列允许的资源不一样，比如单作业核数等。
- `stdin`：标准输入文件，一般指可以通过屏幕输入或采用 `< 文件名`方式传递给程序的文件，对应C程序中的文件描述符0。
- `stdout`：标准输出文件，程序运行正常时输出信息到的文件，一般指输出到屏幕的，并可采用>文件名定向到的文件，对应C程序中的文件描述符1。
- `stderr`：标准出错文件，程序运行出错时输出信息到的文件，一般指也输出到屏幕，并可采用2>定向到的文件（注意这里的2），对应C程序中的文件描述符2。

## 常用参考

- 作业提交：

  - `salloc`：为需实时处理的作业分配资源，提交后等获得作业分配的资源后运行，作业结束后返回命令行终端。
  - `sbatch`：批处理提交，提交后无需等待立即返回命令行终端。
  - `srun`：运行并行作业，等获得作业分配的资源并运行，作业结束后返回命令行终端。

  常用参数：

  - `--begin=<time>`：设定作业开始运行时间，如 `--begin=“18:00:00”`。
  - `--constraints <features>`：设定需要的节点特性。
  - `--cpu-per-task`：需要的CPU核数。
  - `--error=<filename>`：设定存储出错信息的文件名。
  - `--exclude=<names>`：设定不采用（即排除）运行的节点。
  - `--dependency=<state:jobid>`：设定只有当作业号的作业达到某状态时才运行。
  - `--exclusive[=user|mcs]`：设定排它性运行，不允许该节点有它人或某user用户或mcs的作业同时运行。
  - `--export=<name[=value]>`：输出环境变量给作业。
  - `--gres=<name[:count]>`：设定需要的通用资源。
  - `--input=<filename>`：设定输入文件名。
  - `--job-name=<name>`：设定作业名。
  - `--label`：设定输出时前面有标记（`仅限srun`）。
  - `--mem=<size[unit]>`：设定每个节点需要的内存。
  - `--mem-per-cpu=<size[unit]>`：设定每个分配的CPU所需的内存。
  - `-N <minnodes[-maxnodes]>`：设定所需要的节点数。
  - `-n`：设定启动的任务数。
  - `--nodelist=<names>`：设定需要的特定节点名，格式类似node\[1-10,11,13-28\]。
  - `--output=<filename>`：设定存储标准输出信息的文件名。
  - `--partition=<name>`：设定采用的队列。
  - `--qos=<name>`：设定采用的服务质量(QOS)。
  - `--signal=[B:]<num>[@time]`：设定当时间到时发送给作业的信号。
  - `--time=<time>`：设定作业运行时的 Walltime 限制。
  - `--wrap=<command_strings>`：将命令封装在一个简单的sh shell中运行（ 仅限`sbatch` ）。

- 服务质量(QoS)：`sacctmgr`

  - `sacctmgr list qos`或`sacctmgr show qos`：显示QoS

- 记账信息：`sacct`

  - `--endtime=<time>`：设定显示的截止时间之前的作业。
  - `--format=<spec>`：格式化输出。
  - `--name=<jobname>`：设定显示作业名的信息。
  - `--partition=<name>`：设定采用队列的作业信息。
  - `--state=<state_list>`：显示特定状态的作业信息。

- 作业管理

  - `scancel`：取消作业

    - `jobid <job_id_list>`：设定作业号。
    - `--name=<name>`：设定作业名。
    - `--partition=<name>`：设定采用队列的作业。
    - `--qos=<name>`：设定采用的服务质量(QOS)的作业。
    - `--reservation=<name>`：设定采用了预留测略的作业。
    - `--nodelist=<name>`：设定采用特定节点名的作业，格式类似 `node[1-10,11,13-28]`。

  - `squeue`：查看作业信息

    - `--format=<spec>`：格式化输出。
    - `--jobid <job_id_list>`：设定作业号。
    - `--name=<name>`：设定作业名。
    - `--partition=<name>`：设定采用队列的作业。
    - `--qos=<name>`：设定采用的服务质量(QOS)的作业。
    - `--start`：显示作业开始时间。
    - `--state=<state_list>`：显示特定状态的作业信息。

  - `scontrol`：查看作业、节点和队列等信息

    - `--details`：显示更详细信息。
    - `--oneline`：所有信息显示在同一行。
    - `show ENTITY ID`：显示特定入口信息，`ENTITY` 可为：job、node、partition等，`ID` 可为作业号、节点名、队列名等。
    - `update SPECIFICATION`：修改特定信息，用户一般只能修改作业的。
