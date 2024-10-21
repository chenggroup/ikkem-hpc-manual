# 分配式提交作业：salloc

`salloc`将获取作业的分配后执行命令，当命令结束后释放分配的资源。其基本语法为：

`salloc [options] [<command> [command args]]`

command可以是任何是用户想要用的程序，典型的为xterm或包含`srun`命令的shell。如果后面没有跟命令，那么将执行Slurm系统slurm.conf配置文件中通过SallocDefaultCommand设定的命令。如果SallocDefaultCommand没有设定，那么将执行用户的默认shell。

注意：`salloc`逻辑上包括支持保存和存储终端行设置，并且设计为采用前台方式执行。如果需要后台执行`salloc`，可以设定标准输入为某个文件，如：`salloc -n16 a.out </dev/null &`。

## salloc主要选项

常见主要选项参见[10.1](#slurmoption)。


## salloc主要输入环境变量

- `SALLOC_ACCOUNT`：类似-A, --account
- `SALLOC_ACCTG_FREQ`：类似--acctg-freq
- `SALLOC_BELL`：类似--bell
- `SALLOC_CLUSTERS`、`SLURM_CLUSTERS`：类似--clusters。
- `SALLOC_CONSTRAINT`：类似-C, --constraint。
- `SALLOC_CORE_SPEC`：类似 --core-spec。
- `SALLOC_CPUS_PER_GPU`：类似 --cpus-per-gpu。
- `SALLOC_DEBUG`：类似-v, --verbose。
- `SALLOC_EXCLUSIVE`：类似--exclusive。
- `SALLOC_GEOMETRY`：类似-g, --geometry。
- `SALLOC_GPUS`：类似 -G, --gpus。
- `SALLOC_GPU_BIND`：类似 --gpu-bind。
- `SALLOC_GPU_FREQ`：类似 --gpu-freq。
- `SALLOC_GPUS_PER_NODE`：类似 --gpus-per-node。
- `SALLOC_GPUS_PER_TASK`：类似 --gpus-per-task。
- `SALLOC_GRES`：类似 --gres。
- `SALLOC_GRES_FLAGS`：类似--gres-flags。
- `SALLOC_HINT`、`SLURM_HINT`：类似--hint。
- `SALLOC_IMMEDIATE`：类似-I, --immediate。
- `SALLOC_KILL_CMD`：类似-K, --kill-command。
- `SALLOC_MEM_BIND`：类似--mem-bind。
- `SALLOC_MEM_PER_CPU`：类似 --mem-per-cpu。
- `SALLOC_MEM_PER_GPU`：类似 --mem-per-gpu
- `SALLOC_MEM_PER_NODE`：类似 --mem。
- `SALLOC_NETWORK`：类似--network。
- `SALLOC_NO_BELL`：类似--no-bell。
- `SALLOC_OVERCOMMIT`：类似-O, --overcommit。
- `SALLOC_PARTITION`：类似-p, --partition。
- `SALLOC_PROFILE`：类似--profile。
- `SALLOC_QOS`：类似--qos。
- `SALLOC_RESERVATION`：类似--reservation。
- `SALLOC_SIGNAL`：类似--signal。
- `SALLOC_SPREAD_JOB`：类似--spread-job。
- `SALLOC_THREAD_SPEC`：类似--thread-spec。
- `SALLOC_TIMELIMIT`：类似-t, --time。
- `SALLOC_USE_MIN_NODES`：类似--use-min-nodes。
- `SALLOC_WAIT_ALL_NODES`：类似--wait-all-nodes。
- `SLURM_EXIT_ERROR`：错误退出代码。
- `SLURM_EXIT_IMMEDIATE`：当--immediate选项时指定的立即退出代码。

## salloc主要输出环境变量

- `SLURM_CLUSTER_NAME`：集群名。
- `SLURM_CPUS_PER_GPU`：每颗GPU分配的CPU数。
- `SLURM_CPUS_PER_TASK`：每个任务分配的CPU数。
- `SLURM_DISTRIBUTION`：类似-m, --distribution。
- `SLURM_GPUS`：需要的GPU颗数，仅提交时有-G, --gpus时。
- `SLURM_GPU_BIND`：指定绑定任务到GPU，仅提交时具有--gpu-bind参数时。
- `SLURM_GPU_FREQ`：需求的GPU频率，仅提交时具有--gpu-freq参数时。
- `SLURM_GPUS_PER_NODE`：需要的每个节点的GPU颗数，仅提交时具有--gpus-per-node参数时。
- `SLURM_GPUS_PER_SOCKET`：需要的每个socket的GPU颗数，仅提交时具有--gpus-per-socket参数时。
- `SLURM_GPUS_PER_TASK`：需要的每个任务的GPU颗数，仅提交时具有--gpus-per-task参数时。
- `SLURM_JOB_ACCOUNT`：账户名。
- `SLURM_JOB_ID`（`SLURM_JOBID`为向后兼容）：作业号。
- `SLURM_JOB_CPUS_PER_NODE`：分配的每个节点CPU数。
- `SLURM_JOB_NODELIST`（`SLURM_NODELIST`为向后兼容）：分配的节点名列表。
- `SLURM_JOB_NUM_NODES`（`SLURM_NNODES`为向后兼容）：作业分配的节点数。
- `SLURM_JOB_PARTITION`：作业使用的队列名。
- `SLURM_JOB_QOS`：作业的QOS。
- `SLURM_JOB_RESERVATION`：预留的作业资源。
- `SLURM_MEM_BIND`：--mem-bind选项设定。
- `SLURM_MEM_BIND_VERBOSE`：如--mem-bind选项包含verbose选项时，则由其设定。
- `SLURM_MEM_BIND_LIST`：内存绑定时设定的bit掩码。
- `SLURM_MEM_BIND_PREFER`：--mem-bin prefer优先权。
- `SLURM_MEM_BIND_TYPE`：由--mem-bind选项设定。
- `SLURM_MEM_PER_CPU`：类似--mem。
- `SLURM_MEM_PER_GPU`：每颗GPU需要的内存，仅提交时有--mem-per-gpu参数时。
- `SLURM_MEM_PER_NODE`：类似--mem。
- `SLURM_SUBMIT_DIR`：运行`salloc`时的目录，或提交时由-D, --chdir参数指定。
- `SLURM_SUBMIT_HOST`：运行salloc时的节点名。
- `SLURM_NODE_ALIASES`：分配的节点名、通信地址和主机名，格式类似 `SLURM_NODE_ALIASES`=ec0:1.2.3.4:foo,ec1:1.2.3.5:bar。
- `SLURM_NTASKS`：类似-n, --ntasks。
- `SLURM_NTASKS_PER_CORE`：--ntasks-per-core选项设定的值。
- `SLURM_NTASKS_PER_NODE`：--ntasks-per-node选项设定的值。
- `SLURM_NTASKS_PER_SOCKET`：--ntasks-per-socket选项设定的值。
- `SLURM_PROFILE`：类似--profile。
- `SLURM_TASKS_PER_NODE`：每个节点的任务数。值以,分隔，并与`SLURM_NODELIST` 顺序一致。如果连续的节点有相同的任务数，那么数后面跟有“(x#)”，其中“#”是重复次数。如： `SLURM_TASKS_PER_NODE =2(x3),1` 。

## 例子

- 获取分配，并打开csh，以便srun可以交互式输入：

  `salloc -N16 csh`

  将输出：

```
salloc: Granted job allocation 65537
（在此，将等待用户输入，csh退出后结束） salloc: Relinquishing job
allocation 65537
```

- 获取分配并并行运行应用：

  `salloc -N5 srun -n10 myprogram`

- 生成三个不同组件的异构作业，每个都是独立节点：

  `salloc -w node[2-3] : -w node4 : -w node[5-7] bash`

  将输出：

```
salloc: job 32294 queued and waiting for resources salloc: job 32294
has been allocated resources salloc: Granted job allocation 32294
```
