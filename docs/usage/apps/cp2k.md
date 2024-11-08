# CP2K

CP2K 是可用于DFT计算和分子动力学模拟的强大软件包。它支持多种计算方法，包括密度泛函理论（DFT）、半经验方法和经典力场。CP2K 以其高效的并行计算能力和灵活的输入文件格式而闻名，适用于从小分子到大规模材料系统的模拟。用户可以利用 CP2K 进行能量计算、几何优化、分子动力学模拟等多种任务。

## 嘉庚智算上的CP2K

!!! failure
    目前集群上的 CP2K 尚需要测试其可靠性和稳定性。
    <!--前者由于 Core Dump 等原因未能通过 Regtest（但无数值issue），后者由于17个测试任务的数值不匹配亦未能通过。-->

    因此请各位用户在使用时注意自己得到的结果，我们正在积极解决升级后的集群与 CP2K 的兼容性问题。
    如对可靠性有较高要求，推荐使用 [CP2K 官方 Singularity 容器镜像](https://github.com/cp2k/cp2k-containers#apptainer-singularity)。

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