# VASP

!!! info
    VASP 是商业授权软件，需要申请权限后使用。

```bash
#!/bin/bash
#SBATCH --output=testSlurmJob.%j.out    # Stdout (%j expands to jobId)
#SBATCH --error=testSlurmJob.%j.err     # Stderr (%j expands to jobId)
#SBATCH -N 2                            # Maximum number of node
#SBATCH --ntasks-per-node=64            # Maximum number CPUs of each node
#SBATCH --account=[budget]              # Account name
#SBATCH --partition=cpu                 # Partition name
#SBATCH --qos=[qos]                     # QOS name

module load intel/oneapi2021.1
module load  vasp/5.4.4-intel

srun hostname >./hostfile
echo $SLURM_NTASKS
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo $SLURM_NPROCS

mpirun -machinefile hostfile -np $SLURM_NTASKS vasp_std
```
