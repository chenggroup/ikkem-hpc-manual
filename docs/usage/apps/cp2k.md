# CP2K

CP2K 是可用于DFT计算和分子动力学模拟的强大软件包。它支持多种计算方法，包括密度泛函理论（DFT）、半经验方法和经典力场。CP2K 以其高效的并行计算能力和灵活的输入文件格式而闻名，适用于从小分子到大规模材料系统的模拟。用户可以利用 CP2K 进行能量计算、几何优化、分子动力学模拟等多种任务。

## 嘉庚智算上的CP2K

!!! warning
    目前集群上的 CP2K 尚需要测试其可靠性和稳定性。
    <!--前者由于 Core Dump 等原因未能通过 Regtest（但无数值issue），后者由于17个测试任务的数值不匹配亦未能通过。-->

    因此请各位用户在使用时注意自己得到的结果，我们正在积极解决升级后的集群与 CP2K 的兼容性问题。
    如对可靠性有较高要求，推荐使用 [CP2K 官方 Singularity 容器镜像](https://github.com/cp2k/cp2k-containers#apptainer-singularity)。

    注意 CP2K 常常需要超出默认值的内存设置，建议在作业提交脚本中加入 `--mem=251G` 来使用 CPU 计算节点的内存上限。

=== "2022.1"

    ```bash title="/public/slurmscript_demo/cp2k-2022.1.slurm"
    #!/bin/bash
    #SBATCH --nodes=2                   # 节点数量
    #SBATCH --ntasks-per-node=64        # 每个节点核心数量
    #SBATCH --account=[budget]          # Account name
    #SBATCH --partition=cpu             # Partition name
    #SBATCH --qos=[qos]                 # QOS name
    #SBATCH --job-name=hello            # 作业名称
    #SBATCH --output=%j.out             # 正常日志输出 (%j 参数值为 jobId)
    ##SBATCH --error=%j.err             # 错误日志输出 (%j 参数值为 jobId)

    ##############################################
    #          Software Envrironment             #
    ##############################################
    module load gcc/9.3 intel/2020.2
    module load cp2k/2022.1-intel-2020
    ##############################################
    #               Run job                      #
    ##############################################
    export OMP_NUM_THREADS=1
    mpirun  cp2k.psmp -i input.inp >> output
    ```

=== "2024.3"

    !!! failure
        此版本未能通过官方提供的 Regtest，可能会在计算过程中意外退出，但无数值 Issue。

    ```bash title="/public/slurmscript_demo/cp2k-2024.3.slurm"
    #!/bin/bash
    #SBATCH --nodes=1                   # 节点数量
    #SBATCH --ntasks-per-node=64        # 每个节点核心数量
    #SBATCH --job-name=hello            # 作业名称
    #SBATCH --output=%j.out             # 正常日志输出 (%j 参数值为 jobId)
    #SBATCH --error=%j.err              # 错误日志输出 (%j 参数值为 jobId)
    #SBATCH --account=[budget]          # Account name
    #SBATCH --partition=cpu             # Partition name
    #SBATCH --qos=[qos]                 # QOS name
    #SBATCH --mem=251G                  # use full memory of node to avoid OOM

    ##############################################
    #          Software Envrironment             #
    ##############################################
    module load cp2k/2024.3
    ##############################################
    #               Run job                      #
    ##############################################
    mpirun cp2k.psmp cp2k.inp  >> output
    ```

=== "2023.2"

    ```bash title="/public/slurmscript_demo/cp2k-2023.2.slurm"
    #!/bin/bash
    #SBATCH --nodes=2                   # 节点数量
    #SBATCH --ntasks-per-node=64        # 每个节点核心数量
    #SBATCH --account=[budget]          # Account name
    #SBATCH --partition=cpu             # Partition name
    #SBATCH --qos=[qos]                 # QOS name
    #SBATCH --job-name=hello            # 作业名称
    #SBATCH --output=%j.out             # 正常日志输出 (%j 参数值为 jobId)
    ##SBATCH --error=%j.err             # 错误日志输出 (%j 参数值为 jobId)

    ##############################################
    #          Software Envrironment             #
    ##############################################
    module load gcc/12.1 intel/2020.2
    module load app/cp2k/2023.2
    ##############################################
    #               Run job                      #
    ##############################################
    export OMP_NUM_THREADS=1
    mpirun  cp2k.psmp -i  test    >> output
    ```

=== "7.1"

    ```bash title="/public/slurmscript_demo/cp2k-7.1.slurm"
    #/bin/bash
    #SBATCH -o lgps.out
    #SBATCH -J CP2K
    #SBATCH --nodes=2
    #SBATCH --ntasks-per-node=32
    #SBATCH --account=[budget]          # Account name
    #SBATCH --partition=cpu             # Partition name
    #SBATCH --qos=[qos]                 # QOS name
    
    echo $SLURM_NTASKS
    echo "Date              = $(date)"
    echo "Hostname          = $(hostname -s)"
    echo "Working Directory = $(pwd)"
    echo ""
    echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
    echo "Number of Tasks Allocated      = $SLURM_NTASKS"
    echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
    echo $SLURM_NPROCS
    
    module load intel/oneapi2021.1
    module load  cp2k/7.1
    srun hostname >./hostfile
    
    echo $SLURM_NTASKS
    mpirun -np $SLURM_NTASKS cp2k.psmp -i lgps.inp -o lgps.out
    ```

=== "2024.1"

    ```bash title="/public/slurmscript_demo/cp2k-2024.1.slurm"
    #!/bin/bash
    #SBATCH --nodes=2                   # 节点数量
    #SBATCH --ntasks-per-node=64        # 每个节点核心数量
    #SBATCH --account=[budget]          # Account name
    #SBATCH --partition=cpu             # Partition name
    #SBATCH --qos=[qos]                 # QOS name
    #SBATCH --job-name=hello            # 作业名称
    #SBATCH --output=%j.out             # 正常日志输出 (%j 参数值为 jobId)
    ##SBATCH --error=%j.err             # 错误日志输出 (%j 参数值为 jobId)

    ##############################################
    #          Software Envrironment             #
    ##############################################
    module load app/cp2k/2024.1
    ##############################################
    #               Run job                      #
    ##############################################
    export OMPI_MCA_btl_openib_allow_ib=1
    mpirun  cp2k.popt cp2k.inp   >> output
    ```

## 已知问题

### 内存泄漏

一些版本可能存在严重的内存泄漏 Issue，若遇到此问题，建议用户关闭 ELPA 功能，使用 Scalapack 进行对角化。

```
&GLOBAL
    PREFERRED_DIAG_LIBRARY SL
&END GLOBAL
```

若仍然存在问题，建议尝试降低每个节点上的核数，即调整 `--ntasks-per-node` 为更低的值。
