# ORCA

```bash title="/public/slurmscript_demo/orca.slurm"
#!/bin/bash
#SBATCH --job-name=orca_11              # Job name
#SBATCH --output=Job.%j.out             # Stdout (%j expands to jobId)
#SBATCH --error=Job.%j.err              # Stderr (%j expands to jobId)
#SBATCH -N 4                            # Maximum number of  node
#SBATCH --ntasks-per-node=64            # Maximum number CPUs  of  each node
#SBATCH --account=[budget]              # Account name
#SBATCH --partition=cpu                 # Partition name
#SBATCH --qos=[qos]                     # QOS name
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
module load mpi/openmpi/4.1.1-gcc
module load  orca/5.0.1
FILENAME=test.inp
orca ${FILENAME} > ${FILENAME//inp/log}
echo "job finished"
```
