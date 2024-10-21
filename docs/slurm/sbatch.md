# 批处理方式提交作业：sbatch

Slurm支持利用`sbatch`命令采用批处理方式运行作业，`sbatch`命令在脚本正确传递给作业调度系统后立即退出，同时获取到一个作业号。作业等所需资源满足后开始运行。

`sbatch`提交一个批处理作业脚本到Slurm。批处理脚本名可以在命令行上通过传递给`sbatch`，如没有指定文件名，则`sbatch`从标准输入中获取脚本内容。

脚本文件基本格式：

- 第一行以#!/bin/sh等指定该脚本的解释程序，/bin/sh可以变为/bin/bash、/bin/csh等。
- 在可执行命令之前的每行“#SBATCH”前缀后跟的参数作为作业调度系统参数。在任何非注释及空白之后的“#SBATCH”将不再作为Slurm参数处理。

默认，标准输出和标准出错都定向到同一个文件`slurm-%j.out`，“%j”将被作业号代替。

脚本`myscript`内容：

```bash
#!/bin/sh
#SBATCH --time=1
#SBATCH -p serial
srun hostname |sort
```

采用4个节点（-N4）运行：`sbatch -p batch -N4 myscript`

在这里，虽然脚本中利用“#SBATCH -p serial”指定了使用serial队列，但命令行中的`-p batch`优先级更高，因此实际提交到batch队列。

提交成功后有类似输出：

```
salloc: Granted job allocation 65537
```

其中65537为分配的作业号。

程序结束后的作业日志文件`slurm-65537.out`显示：

```
node1
node2
node3
node4
```

从标准输入获取脚本内容，可采用以下两种方式之一：

1. 运行`sbatch -N4`，显示等待后输入：

```bash
#!/bin/sh
srun hostname |sort
```

输入以上内容后按CTRL+D终止输入。

1. 运行`sbatch -N4 <<EOF`，

```bash
> #!/bin/sh
> srun hostname | sort
> EOF

  -  第一个EOF表示输入内容的开始标识符

  -  最后的EOF表示输入内容的终止标识符，在两个EOF之间的内容为实际执行的内容。

  -  >实际上是每行输入回车后自动在下一行出现的提示符。
```

以上两种方式输入结束后将显示：

```
sbatch: Submitted batch job 65541
```

常见主要选项参见[提交作业命令共同说明](./submission.md)。

## sbatch主要输入环境变量

一些选项可通过环境变量来设置，命令行的选项优先级高于设置的环境变量，将覆盖掉环境变量的设置。环境变量与对应的参数如下：

- `SBATCH_ACCOUNT`：类似-A、--account。
- `SBATCH_ACCTG_FREQ`：类似--acctg-freq。
- `SBATCH_ARRAY_INX`：类似-a、--array。
- `SBATCH_BATCH`：类似--batch。
- `SBATCH_CLUSTERS 或 SLURM_CLUSTERS`：类似--clusters。
- `SBATCH_CONSTRAINT`：类似-C, --constraint。
- `SBATCH_CORE_SPEC`：类似--core-spec。
- `SBATCH_CPUS_PER_GPU`：类似--cpus-per-gpu。
- `SBATCH_DEBUG`：类似-v、--verbose。
- `SBATCH_DISTRIBUTION`：类似-m、--distribution。
- `SBATCH_EXCLUSIVE`：类似--exclusive。
- `SBATCH_EXPORT`：类似--export。
- `SBATCH_GEOMETRY`：类似-g、--geometry。
- `SBATCH_GET_USER_ENV`：类似--get-user-env。
- `SBATCH_GPUS`：类似 -G, --gpus。
- `SBATCH_GPU_BIND`：类似 --gpu-bind。
- `SBATCH_GPU_FREQ`：类似 --gpu-freq。
- `SBATCH_GPUS_PER_NODE`：类似 --gpus-per-node。
- `SBATCH_GPUS_PER_TASK`：类似 --gpus-per-task。
- `SBATCH_GRES`：类似 --gres。
- `SBATCH_GRES_FLAGS`：类似--gres-flags。
- `SBATCH_HINT 或 SLURM_HINT`：类似--hint。
- `SBATCH_IGNORE_PBS`：类似--ignore-pbs。
- `SBATCH_JOB_NAME`：类似-J、--job-name。
- `SBATCH_MEM_BIND`：类似--mem-bind。
- `SBATCH_MEM_PER_CPU`：类似--mem-per-cpu。
- `SBATCH_MEM_PER_GPU`：类似--mem-per-gpu。
- `SBATCH_MEM_PER_NODE`：类似--mem。
- `SBATCH_NETWORK`：类似--network。
- `SBATCH_NO_KILL`：类似-k, –no-kill。
- `SBATCH_NO_REQUEUE`：类似--no-requeue。
- `SBATCH_OPEN_MODE`：类似--open-mode。
- `SBATCH_OVERCOMMIT`：类似-O、--overcommit。
- `SBATCH_PARTITION`：类似-p、--partition。
- `SBATCH_PROFILE`：类似--profile。
- `SBATCH_QOS`：类似--qos。
- `SBATCH_RAMDISK_IMAGE`：类似--ramdisk-image。
- `SBATCH_RESERVATION`：类似--reservation。
- `SBATCH_REQUEUE`：类似--requeue。
- `SBATCH_SIGNAL`：类似--signal。
- `SBATCH_THREAD_SPEC`：类似--thread-spec。
- `SBATCH_TIMELIMIT`：类似-t、--time。
- `SBATCH_USE_MIN_NODES`：类似--use-min-nodes。
- `SBATCH_WAIT`：类似-W、--wait。
- `SBATCH_WAIT_ALL_NODES`：类似--wait-all-nodes。
- `SBATCH_WAIT4SWITCH`：需要交换的最大时间，参见See--switches。
- `SLURM_EXIT_ERROR`：设定Slurm出错时的退出码。
- `SLURM_STEP_KILLED_MSG_NODE_ID=ID`：如果设置，当作业或作业步被信号终止时，只有指定ID的节点记录。

(target-7)=

## sbatch主要输出环境变量

Slurm将在作业脚本中输出以下变量，作业脚本可以使用这些变量：

- `SBATCH_MEM_BIND`：--mem-bind选项设定。
- `SBATCH_MEM_BIND_VERBOSE`：如--mem-bind选项包含verbose选项时，则由其设定。
- `SBATCH_MEM_BIND_LIST`：内存绑定时设定的bit掩码。
- `SBATCH_MEM_BIND_PREFER`：--mem-bin prefer优先权。
- `SBATCH_MEM_BIND_TYPE`：由--mem-bind选项设定。
- `SLURM_ARRAY_TASK_ID`：作业组ID（索引）号。
- `SLURM_ARRAY_TASK_MAX`：作业组最大ID号。
- `SLURM_ARRAY_TASK_MIN`：作业组最小ID号。
- `SLURM_ARRAY_TASK_STEP`：作业组索引步进间隔。
- `SLURM_ARRAY_JOB_ID`：作业组主作业号。
- `SLURM_CLUSTER_NAME`：集群名。
- `SLURM_CPUS_ON_NODE`：分配的节点上的CPU颗数。
- `SLURM_CPUS_PER_GPU`：每个任务的CPU颗数，只有--cpus-per-gpu选项设定时才有。
- `SLURM_CPUS_PER_TASK`：每个任务的CPU颗数，只有--cpus-per-task选项设定时才有。
- `SLURM_DISTRIBUTION`：类似-m, --distribution。
- `SLURM_EXPORT_ENV`：类似-e, --export。
- `SLURM_GPU_BIND`：指定绑定任务到GPU，仅提交时具有--gpu-bind参数时。
- `SLURM_GPU_FREQ`：需求的GPU频率，仅提交时具有--gpu-freq参数时。
- `SLURM_GPUS` Number of GPUs requested. Only set if the -G, --gpus option is specified.
- `SLURM_GPU_BIND`：需要的任务绑定到GPU，仅提交时有–gpu-bind参数时。
- `SLURM_GPUS_PER_NODE`：需要的每个节点的GPU颗数，仅提交时具有--gpus-per-node参数时。
- `SLURM_GPUS_PER_SOCKET`：需要的每个socket的GPU颗数，仅提交时具有--gpus-per-socket参数时。
- `SLURM_GPUS_PER_TASK`：需要的每个任务的GPU颗数，仅提交时具有--gpus-per-task参数时。
- `SLURM_GTIDS`：在此节点上运行的全局任务号。以0开始，逗号,分隔。
- `SLURM_JOB_ACCOUNT`：作业的记账账户名。
- `SLURM_JOB_ID`：作业号。
- `SLURM_JOB_CPUS_PER_NODE`：每个节点上的CPU颗数，格式类似40(x3),3，顺序对应`SLURM_JOB_NODELIST`节点名顺序。
- `SLURM_JOB_DEPENDENCY`：作业依赖信息，由--dependency选项设置。
- `SLURM_JOB_NAME`：作业名。
- `SLURM_JOB_NODELIST`：分配的节点名列表，格式类似node\[1-10,11,13-28\]。
- `SLURM_JOB_NUM_NODES`：分配的节点总数。
- `SLURM_JOB_PARTITION`：使用的队列名。
- `SLURM_JOB_QOS`：需要的服务质量(QOS)。
- `SLURM_JOB_RESERVATION`：作业预留。
- `SLURM_LOCALID`：节点本地任务号。
- `SLURM_MEM_PER_CPU`：类似--mem-per-cpu，每颗CPU需要的内存。
- `SLURM_MEM_PER_GPU`：类似--mem-per-gpu，每颗GPU需要的内存。
- `SLURM_MEM_PER_NODE`：类似--mem，每个节点的内存。
- `SLURM_NODE_ALIASES`：分配的节点名、通信IP地址和主机名组合，类似 `SLURM_NODE_ALIASES`=ec0:1.2.3.4:foo,ec1:1.2.3.5:bar。
- `SLURM_NODEID`：分配的节点号。
- `SLURM_NTASKS`：类似-n, --ntasks，总任务数，CPU核数。
- `SLURM_NTASKS_PER_CORE`：每个CPU核分配的任务数。
- `SLURM_NTASKS_PER_NODE`：每个节点上的任务数 。
- `SLURM_NTASKS_PER_SOCKET`：每颗CPU上的任务数，仅--ntasks-per-socket选项设定时设定。
- `SLURM_PRIO_PROCESS`：进程的调度优先级（nice值）。
- `SLURM_PROCID`：当前进程的MPI秩。
- `SLURM_PROFILE`：类似--profile。
- `SLURM_RESTART_COUNT`：因为系统失效等导致的重启次数。
- `SLURM_SUBMIT_DIR`：sbatch启动目录，即提交作业时目录，或提交时由-D, --chdir参数指定的。
- `SLURM_SUBMIT_HOST`：sbatch启动的节点名，即提交作业时节点。
- `SLURM_TASKS_PER_NODE`：每节点上的任务数，以`SLURM_NODELIST`中的节点顺序显示，以,分隔。如果两个或多个连续节点上的任务数相同，数后跟着(x#)，其中#是对应的节点数，如“`SLURM_TASKS_PER_NODE`=2(x3),1”表示前三个节点上的作业数为3，第四个节点上的任务数为1。
- `SLURM_TASK_PID`：任务的进程号PID。
- `SLURMD_NODENAME`：执行作业脚本的节点名。

## 串行作业提交

对于串行程序，用户可类似下面两者之一：

1. 直接采用`sbatch -n1 -o job-%j.log -e job-%j.err yourprog`方式运行
2. 编写命名为`serial_job.sh`（此脚本名可以按照用户喜好命名）的串行作业脚本，其内容如下：

```bash
#!/bin/sh
#An example for serial job.
#SBATCH -J job_name
#SBATCH -o job-%j.log
#SBATCH -e job-%j.err

echo Running on hosts
echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST

module load intel/2019.update5

echo This job has allocated 1 cpu core.

./yourprog
```

必要时需在脚本文件中利用`module`命令设置所需的环境，如上面的`module load intel/2019.update5`。

作业脚本编写完成后，可以按照下面命令提交作业：

> `hmli@login01:~/work$ sbatch -n1 -p serail serial_job.sh`

## OpenMP共享内存并行作业提交

对于OpenMP共享内存并行程序，可编写命名为`omp_job.sh`的作业脚本，内容如下：

```bash
#!/bin/sh
#An example for serial job.
#SBATCH -J job_name
#SBATCH -o job-%j.log
#SBATCH -e job-%j.err
#SBATCH -N 1 -n 8

echo Running on hosts
echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST

module load intel/2016.3.210
echo This job has allocated 1 cpu core.
export OMP_NUM_THREADS=8
./yourprog
```

相对于串行作业脚本，主要增加`export OMP_NUM_THREADS=8`和 `#SBATCH -N 1 -n 8`，表示使用一个节点内部的八个核，从而保证是在同一个节点内部，需几个核就设置-n为几。-n后跟的不能超过单节点内CPU核数。

作业脚本编写完成后，可以按照下面命令提交作业：

`hmli@login01:~/work$ sbatch omp_job.sh`

## MPI并行作业提交

与串行作业类似，对于MPI并行作业，则需编写类似下面脚本`mpi_job.sh`：

```bash
#!/bin/sh
#An example for MPI job.
#SBATCH -J job_name
#SBATCH -o job-%j.log
#SBATCH -e job-%j.err
#SBATCH -N 1 -n 8

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.

module load intelmpi/5.1.3.210
#module load mpich/3.2/intel/2016.3.210
#module load openmpi/2.0.0/intel/2016.3.210
MPIRUN=mpirun #Intel mpi and Open MPI
#MPIRUN=mpiexec #MPICH
MPIOPT="-env I_MPI_FABRICS shm:ofa" #Intel MPI 2018
#MPIOPT="-env I_MPI_FABRICS shm:ofi" #Intel MPI 2019
#MPIOPT="--mca plm_rsh_agent ssh --mca btl self,openib,sm" #Open MPI
#MPIOPT="-iface ib0" #MPICH3
#目前新版的MPI可以自己找寻高速网络配置，可以设置MPIOPT为空，如去掉下行的#
MPIOPT=
$MPIRUN $MPIOPT ./yourprog
```

与串行程序的脚本相比，主要不同之处在于需采用mpirun或mpiexec的命令格式提交并行可执行程序。采用不同MPI提交时，需要打开上述对应的选项。

与串行作业类似，可使用下面方式提交：

`hmli@login01:~/work$ sbatch mpi_job.sh`

## GPU作业提交

运行GPU作业，需要提交时利用--gres=gpu等指明需要的GPU资源并用-p指明采用等GPU队列。

脚本`gpu_job.sh`内容：

```bash
#!/bin/sh
#An example for gpu job.
#SBATCH -J job_name
#SBATCH -o job-%j.log
#SBATCH -e job-%j.err
#SBATCH -N 1 -n 8 -p GPU-V100 --gres=gpu:v100:2
./your-gpu-prog
```

上面-p GPU-V100指定采用GPU队列GPU-V100，--gres=gpu:v100:2指明每个节点使用2块NVIDIA V100 GPU卡。

## 作业获取的节点名及对应CPU核数解析

作业调度系统主要负责分配节点及该节点分配的CPU核数等，在Slurm作业脚本中利用环境变量可以获取分配到的节点名(`SLURM_JOB_NODELIST`及对应核数(`SLURM_JOB_CPUS_PER_NODE`)或对应的任务数(`SLURM_TASKS_PER_NODE`)，然后根据自己程序原始的命令在Slurm脚本中进行修改就成。

`SLURM_JOB_NODELIST`及`SLURM_TASKS_PER_NODE`有一定的格式，以下为一个参考解析脚本，可以在自己的Slurm脚本中参考获取自己的节点等信息。

上面只是例子，要加在自己的Slurm脚本中，而不是先提交上面这个脚本获取节点名后放到slurm脚本中，其原因在于除非提交时指定节点名，否则每次提交后获取的节点名等是有可能变的。比如针对star-cmm+软件，原来的方式是：

> `/STATCMM+PATH/bin/starccm+ -rsh ssh -batch -power -on cnode400:40,cnode432:40 FireAndSmokeResampled.sim >residual.log`

则可以改为下面脚本：

```bash
#!/bin/bash
#Auther HM_Li<hmli@ustc.edu.cn>
#SLURM_JOB_NODELIST=cnode[001-003,005,440-441]
BASENAME=${SLURM_JOB_NODELIST%[*}
LIST=${SLURM_JOB_NODELIST#*[}
LIST=${LIST%]}
IDLIST=''
for i in `echo $LIST | tr ',' ' '`
do
   if [[ $i =~ '-' ]]; then
      IDLIST=$IDLIST' '`seq -w `echo $i | tr '-' ' '``
   else
      IDLIST=$IDLIST' '$i
   fi
done
NODELIST=''
for i in $IDLIST
do
    NODELIST=$NODELIST" $BASENAME"$i
done
echo -e "Node list: \n\t"$NODELIST

#SLURM_TASKS_PER_NODE='40(x3),23,20(x2)'
#SLURM_JOB_CPUS_PER_NODE='40(x3),23,20(x2)'
CORELIST=''
for i in `echo $SLURM_JOB_CUPS_PER_NODE| tr ',' ' '`
do
  if [[ $i =~ 'x' ]]; then
     read CORES NODES <<<`echo $i| tr '(x)' ' '`
     for n in `seq 1 $NODES`
     do
         CORELIST=$CORELIST' '$CORES
     done
  else
     CORELIST=$CORELIST' '$i
  fi
done
echo -e "\nCPU Core list: \n\t$CORELIST"

echo -e "\nNode list with corresponding CPU Cores: "
CARR=(${CORELIST})
i=0
for n in $NODELIST
  do
    echo -e "\t"$n: ${CARR[$i]}
    i=$(($i+1))
 done
```
