# 交互式提交并行作业：srun

`srun` 可以交互式提交运行并行作业，提交后，作业等待运行，等运行完毕后，才返回终端。

基本语法为：

```bash
srun [OPTIONS...] executable [args...]
```

## 主要输入环境变量

一些提交选项可通过环境变量来设置，命令行的选项优先级高于设置的环境变量，将覆盖掉环境变量的设置。环境变量与对应的参数如下：

- `SLURM_ACCOUNT`：类似-A, --account。
- `SLURM_ACCTG_FREQ`：类似--acctg-freq。
- `SLURM_BCAST`：类似--bcast。
- `SLURM_COMPRESS`：类似--compress。
- `SLURM_CORE_SPEC`：类似--core-spec。
- `SLURM_CPU_BIND`：类似--cpu-bind。
- `SLURM_CPUS_PER_GPU`：类似-c, --cpus-per-gpu。
- `SLURM_CPUS_PER_TASK`：类似-c, --cpus-per-task。
- `SLURM_DEBUG`：类似-v, --verbose。
- `SLURM_DEPENDENCY`：类似-P, --dependency=\<jobid>。
- `SLURM_DISABLE_STATUS`：类似-X, --disable-status。
- `SLURM_DIST_PLANESIZE`：类似-m plane。
- `SLURM_DISTRIBUTION`：类似-m, --distribution。
- `SLURM_EPILOG`：类似--epilog。
- `SLURM_EXCLUSIVE`：类似--exclusive。
- `SLURM_EXIT_ERROR`：Slurm出错时的退出码。
- `SLURM_EXIT_IMMEDIATE`：当--immediate使用时且资源当前无效时的Slurm退出码。
- `SLURM_GEOMETRY`：类似-g, --geometry。
- `SLURM_GPUS`：类似-G, --gpus。
- `SLURM_GPU_BIND`：类似--gpu-bind。
- `SLURM_GPU_FREQ`：类似--gpu-freq。
- `SLURM_GPUS_PER_NODE`：类似--gpus-per-node。
- `SLURM_GPUS_PER_TASK`：类似--gpus-per-task。
- `SLURM_GRES`：类似--gres，参见`SLURM_STEP_GRES`。
- `SLURM_HINT`：类似--hint。
- `SLURM_IMMEDIATE`：类似-I, --immediate。
- `SLURM_JOB_ID`：类似--jobid。
- `SLURM_JOB_NAME`：类似-J, --job-name。
- `SLURM_JOB_NODELIST`：类似-w, –nodelist=\<host1,host2,... or filename>，格式类似node\[1-10,11,13-28\]。
- `SLURM_JOB_NUM_NODES`：分配的总节点数。
- `SLURM_KILL_BAD_EXIT`：类似-K, --kill-on-bad-exit。
- `SLURM_LABELIO`：类似-l, --label。
- `SLURM_LINUX_IMAGE`：类似--linux-image。
- `SLURM_MEM_BIND`：类似--mem-bind。
- `SLURM_MEM_PER_CPU`：类似--mem-per-cpu。
- `SLURM_MEM_PER_NODE`：类似--mem。
- `SLURM_MPI_TYPE`：类似--mpi。
- `SLURM_NETWORK`：类似--network。
- `SLURM_NNODES`：类似-N, --nodes，即将废弃。
- `SLURM_NO_KILL`：类似-k, --no-kill。
- `SLURM_NTASKS`：类似-n, --ntasks。
- `SLURM_NTASKS_PER_CORE`：类似--ntasks-per-core。
- `SLURM_NTASKS_PER_SOCKET`：类似--ntasks-per-socket。
- `SLURM_NTASKS_PER_NODE`：类似--ntasks-per-node。
- `SLURM_OPEN_MODE`：类似--open-mode。
- `SLURM_OVERCOMMIT`：类似-O, --overcommit。
- `SLURM_PARTITION`：类似-p, --partition。
- `SLURM_PROFILE`：类似--profile。
- `SLURM_PROLOG`：类似--prolog，`仅限srun`。
- `SLURM_QOS`：类似--qos。
- `SLURM_REMOTE_CWD`：类似-D, --chdir=。
- `SLURM_RESERVATION`：类似--reservation。
- `SLURM_RESV_PORTS`：类似--resv-ports。
- `SLURM_SIGNAL`：类似--signal。
- `SLURM_STDERRMODE`：类似-e, --error。
- `SLURM_STDINMODE`：类似-i, --input。
- `SLURM_SRUN_REDUCE_TASK_EXIT_MSG`：如被设置，并且非0,那么具有相同退出码的连续的任务退出消息只显示一次。
- `SLURM_STEP_GRES`：类似--gres（仅对作业步有效，不影响作业分配），参见`SLURM_GRES`。
- `SLURM_STEP_KILLED_MSG_NODE_ID=ID`：如被设置，当作业或作业步被信号终止时只特定ID的节点下显示信息。
- `SLURM_STDOUTMODE`：类似-o, --output。
- `SLURM_TASK_EPILOG`：类似--task-epilog。
- `SLURM_TASK_PROLOG`：类似--task-prolog。
- `SLURM_TEST_EXEC`：如被定义，在计算节点执行之前先在本地节点上测试可执行程序。
- `SLURM_THREAD_SPEC`：类似--thread-spec。
- `SLURM_THREADS`：类似-T, --threads。
- `SLURM_TIMELIMIT`：类似-t, --time。
- `SLURM_UNBUFFEREDIO`：类似-u, --unbuffered。
- `SLURM_USE_MIN_NODES`：类似--use-min-nodes。
- `SLURM_WAIT`：类似-W, --wait。
- `SLURM_WORKING_DIR`：类似-D, --chdir。
- `SRUN_EXPORT_ENV`：类似--export，将覆盖掉`SLURM_EXPORT_ENV`。

## 主要输出环境变量

`srun`会在执行的节点上设置如下环境变量：

- `SLURM_CLUSTER_NAME`：集群名。
- `SLURM_CPU_BIND_VERBOSE`：--cpu-bind详细情况(quiet、verbose)。
- `SLURM_CPU_BIND_TYPE`：--cpu-bind类型(none、rank、map-cpu:、mask-cpu:)。
- `SLURM_CPU_BIND_LIST`：--cpu-bind映射或掩码列表。
- `SLURM_CPU_FREQ_REQ`：需要的CPU频率资源，参见--cpu-freq和输入环境变量`SLURM_CPU_FREQ_REQ`。
- `SLURM_CPUS_ON_NODE`：节点上的CPU颗数。
- `SLURM_CPUS_PER_GPU`：每颗GPU对应的CPU颗数，参见--cpus-per-gpu选项指定。
- `SLURM_CPUS_PER_TASK`：每作业的CPU颗数，参见--cpus-per-task选项指定。
- `SLURM_DISTRIBUTION`：分配的作业的分布类型，参见-m, --distribution。
- `SLURM_GPUS`：需要的GPU颗数，仅提交时有-G, --gpus时。
- `SLURM_GPU_BIND`：指定绑定任务到GPU，仅提交时具有--gpu-bind参数时。
- `SLURM_GPU_FREQ`：需求的GPU频率，仅提交时具有--gpu-freq参数时。
- `SLURM_GPUS_PER_NODE`：需要的每个节点的GPU颗数，仅提交时具有--gpus-per-node参数时。
- `SLURM_GPUS_PER_SOCKET`：需要的每个socket的GPU颗数，仅提交时具有--gpus-per-socket参数时。
- `SLURM_GPUS_PER_TASK`：需要的每个任务的GPU颗数，仅提交时具有--gpus-per-task参数时。
- `SLURM_GTIDS`：此节点上分布的全局任务号，从0开始，以,分隔。
- `SLURM_JOB_ACCOUNT`：作业的记账名。
- `SLURM_JOB_CPUS_PER_NODE`：每个节点的CPU颗数，格式类似40(x3),3，顺序对应`SLURM_JOB_NODELIST`节点名顺序。
- `SLURM_JOB_DEPENDENCY`：依赖关系，参见--dependency选项。
- `SLURM_JOB_ID`：作业号。
- `SLURM_JOB_NAME`：作业名，参见--job-name选项或srun启动的命令名。
- `SLURM_JOB_PARTITION`：作业使用的队列名。
- `SLURM_JOB_QOS`：作业的服务质量QOS。
- `SLURM_JOB_RESERVATION`：作业的高级资源预留。
- `SLURM_LAUNCH_NODE_IPADDR`：任务初始启动节点的IP地址。
- `SLURM_LOCALID`：节点本地任务号。
- `SLURM_MEM_BIND_LIST`：--mem-bind映射或掩码列表（\<list of IDs or masks for this node>）。
- `SLURM_MEM_BIND_PREFER`：--mem-bin prefer优先权。
- `SLURM_MEM_BIND_TYPE`：--mem-bind类型（none、rank、map-mem:、mask-mem:）。
- `SLURM_MEM_BIND_VERBOSE`：内存绑定详细情况，参见--mem-bind verbosity（quiet、verbose）。
- `SLURM_MEM_PER_GPU`：每颗GPU需求的内存，参见--mem-per-gpu。
- `SLURM_NODE_ALIASES`：分配的节点名、通信IP地址和节点名，每组内采用:分隔，组间通过,分隔，如：`SLURM_NODE_ALIASES`=0:1.2.3.4:foo,ec1:1.2.3.5:bar。
- `SLURM_NODEID`：当前节点的相对节点号。
- `SLURM_NODELIST`：分配的节点列表，格式类似node\[1-10,11,13-28\]。
- `SLURM_NTASKS`：任务总数。
- `SLURM_PRIO_PROCESS`：作业提交时的调度优先级值（nice值）。
- `SLURM_PROCID`：当前MPI秩号。
- `SLURM_SRUN_COMM_HOST`：节点的通信IP。
- `SLURM_SRUN_COMM_PORT`：srun的通信端口。
- `SLURM_STEP_LAUNCHER_PORT`：作业步启动端口。
- `SLURM_STEP_NODELIST`：作业步节点列表，格式类似node\[1-10,11,13-28\]。
- `SLURM_STEP_NUM_NODES`：作业步的节点总数。
- `SLURM_STEP_NUM_TASKS`：作业步的任务总数。
- `SLURM_STEP_TASKS_PER_NODE`：作业步在每个节点上的任务总数，格式类似40(x3),3，顺序对应`SLURM_JOB_NODELIST`节点名顺序。
- `SLURM_STEP_ID`：当前作业的作业步号。
- `SLURM_SUBMIT_DIR`：提交作业的目录，或有可能由-D,–chdir参数指定。
- `SLURM_SUBMIT_HOST`：提交作业的节点名。
- `SLURM_TASK_PID`：任务启动的进程号。
- `SLURM_TASKS_PER_NODE`：每个节点上启动的任务数，以`SLURM_NODELIST`中的节点顺序显示，以,分隔。如果两个或多个连续节点上的任务数相同，数后跟着(x#)，其中#是对应的节点数，如`SLURM_TASKS_PER_NODE`=2(x3),1"表示，前三个节点上的作业数为3，第四个节点上的任务数为1。
- `SLURM_UMASK`：作业提交时的umask掩码。
- `SLURMD_NODENAME`：任务运行的节点名。
- `SRUN_DEBUG`：srun命令的调试详细信息级别，默认为3（info级）。

## 多程序运行配置

Slurm支持一次申请多个节点，在不同节点上同时启动执行不同任务。为实现次功能，需要生成一个配置文件，在配置文件中做相应设置。

配置文件中的注释必需第一列为#，配置文件包含以空格分隔的以下域（字段）：

- 任务范围(Task rank)：一个或多个任务秩，多个值的话可以用逗号,分隔。范围可以用两个用-分隔的整数表示，小数在前，大数在后。如果最后一行为\*，则表示全部其余未在前面声明的秩。如没有指明可执行程序，则会显示错误信息：“No executable program specified for this task”。
- 需要执行的可执行程序(Executable)：也许需要绝对路径指明。
- 可执行程序的参数(Arguments)：“%t”将被替换为任务号；“%o”将被替换为任务号偏移（如配置的秩为“1-5”，则偏移值为“0-4”）。单引号可以防止内部的字符被解释。此域为可选项，任何在命令行中需要添加的程序参数都将加在配置文件中的此部分。

例如，配置文件silly.conf内容为：

```
###################################################################
# srun multiple program configuration file
#
# srun -n8 -l --multi-prog silly.conf
###################################################################
4-6       hostname
1,7       echo  task:%t
0,2-3     echo  offset:%o
```

运行：`srun -n8 -l --multi-prog silly.conf`

输出结果：

```
0: offset:0
1: task:1
2: offset:1
3: offset:2
4: node1
5: node2
6: node4
7: task:7
```

## 常见例子


### 运行多核并行任务

使用8个CPU核 ( `-n8` ) 运行作业，并在标准输出上显示任务号 (`-l`)

```bash
srun -n8 -l hostname
```

输出结果：

```
3: cu021
4: cu021
5: cu021
6: cu021
7: cu021
1: cu021
0: cu021
2: cu021
```

### 分配任务在不同进程上

在脚本中使用 `-r2`  参数使其在第2号（分配的节点号从0开始）开始的两个节点上运行，并采用实时分配模式而不是批处理模式运行。

脚本`test.sh`内容：

```bash title="test.sh"
#!/bin/sh
echo $SLURM_NODELIST
srun -lN2 -r2 hostname
srun -lN2 hostname
```

运行： `salloc -N4 -p cpu test.sh`

输出结果：

```
cu[011-014]
1: cu014
0: cu013
1: cu012
0: cu011
```

可以看出先启动的任务在 `cu[013-014]` 上运行，即后两个节点。

### 在分配的节点上并行运行两个作业步

脚本`test.sh`内容：

```bash title="test.sh"
#!/bin/bash
srun -lN2 -n2 -r 2 sleep 60 &
srun -lN2 -n2 -r 0 sleep 60 &
sleep 1
squeue
squeue -s
wait
```

运行： `salloc -N4 -p cpu test.sh`

输出结果：

```
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
368585       cpu interact ypliucat  R       0:04      4 cu[011-014]
STEPID     NAME PARTITION     USER      TIME NODELIST
368585.0    sleep       cpu ypliucat      0:01 cu[011-012]
368585.1    sleep       cpu ypliucat      0:01 cu[013-014]
368585.extern   extern       cpu ypliucat      0:04 cu[011-014]
```

可以看出我们分别创建了两个作业步 (Step)，分别运行在后两个和前两个节点上。

### 运行 MPI 作业

脚本`test.sh`内容：

```bash title="test.sh"
#!/bin/sh
MACHINEFILE="nodes.$SLURM_JOB_ID"

# 生成 MPI 所需的包含节点名的machinfile文件
module load intel/2023.2
srun -l /bin/hostname | sort -n | awk ’{print $2}’ > $MACHINEFILE

# 运行 MPI 作业
mpirun -np $SLURM_NTASKS -machinefile $MACHINEFILE mpi-app

rm $MACHINEFILE
```

采用2个节点（-N2）共4个CPU核（-n4）运行：`salloc -N2 -n4 test.sh`

### 利用不同节点运行不同作业

利用不同节点号（`SLURM_NODEID`）运行不同作业，节点号从0开始：

脚本`test.sh`内容：

```bash
case $SLURM_NODEID in
     0)
        echo "I am running on "
        hostname
        ;;
     1)
        hostname
        echo "is where I am running"
        ;;
 esac
```

运行： `srun -N2 test.sh`

输出：

```
cu012
is where I am running
I am running on
cu011
```

### 利用多核选项控制任务执行

采用2个节点（`-N2`），每节点2颗CPU，每颗CPU 2颗CPU核（`-B 2-2:2-2`），运行作业：

```bash
srun -N2 -p cpu -B 2-2:2-2 a.out
```

### 运行GPU作业

脚本`gpu.sh`内容：

```bash
#!/bin/bash
srun -n1 -p gpu --gres=gpu:2 prog1
```

`-p gpu` 指定采用GPU队列，`--gres=gpu:2` 指明每个节点使用 2 块 GPU 卡。

!!! tip
    目前嘉庚智算上的 GPU 均为 NVIDIA A100 80G NVLink 全连接计算卡。

### 排它性独占运行作业

脚本`my.sh`内容：

```bash
#!/bin/bash
srun --exclusive -n4 prog1 &
srun --exclusive -n3 prog2 &
srun --exclusive -n1 prog3 &
srun --exclusive -n1 prog4 &
wait
```

!!! warning "注意"
    利用 `--exclusive` 开启排他性独占时，默认计费按照 **每个`srun`** 使用其所在节点全部资源进行，即使申请了 1 个 CPU 核或者 1 张 GPU 卡也会按照整个节点（64 个 CPU 核 / 8 张 GPU 卡）来计算。
