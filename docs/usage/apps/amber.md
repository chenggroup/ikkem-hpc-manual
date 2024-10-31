# amber

```bash title="/public/slurmscript_demo/amber-intel.slurm"
#!/bin/bash -l
#SBATCH --job-name=mpi_job_test         # Job name
#SBATCH --output=testSlurmJob.%j.out    # Stdout (%j expands to jobId)
#SBATCH --error=testSlurmJob.%j.err     # Stderr (%j expands to jobId)
#SBATCH -N 2                            # Maximum number of  node
#SBATCH --ntasks-per-node=16            # Maximum number CPUs  of  each node
#SBATCH --account=[budget]              # Account name
#SBATCH --partition=cpu                 # Partition name
#SBATCH --qos=[qos]                     # QOS name

module  load intel/oneapi2021.1
module load amber/20

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

mpirun -machinefile hostfile -np $SLURM_NTASKS   pmemd.MPI -O -i mdin -o mdout -p prmtop -c inpcrd
```