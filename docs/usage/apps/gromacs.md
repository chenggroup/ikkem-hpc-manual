# GROMACS

GROMACS是一套分子动力学模拟程序包，主要用来模拟研究蛋白质、脂质、核酸等生物分子的性质。它起初由荷兰格罗宁根大学生物化学系开发，目前由来自世界各地的大学和研究机构维护。

=== "CPU"

    ```bash
    #!/bin/bash
    #SBATCH --job-name=mpi_job_test
    #SBATCH --output=testSlurmJob.%j.out
    #SBATCH --error=testSlurmJob.%j.err
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=64
    #SBATCH --account=[budget]
    #SBATCH --partition=cpu
    #SBATCH --qos=[qos]

    module load gromacs/2020.3
    #before compute
    gmx_mpi grompp -f pme.mdp
    #begin compute
    mpirun gmx_mpi mdrun -dlb yes -v -nsteps 10000 -resethway -noconfout -pin on -ntomp 1 -s topol.tpr
    ```

=== "GPU"

    ```bash
    #!/bin/bash
    #SBATCH --job-name=lp_job_test
    #SBATCH --output=testSlurmJob.%j.out
    #SBATCH --error=testSlurmJob.%j.err
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=8
    #SBATCH --account=[budget]
    #SBATCH --partition=gpu
    #SBATCH --qos=[qos]
    #SBATCH --gres=gpu:1

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
    module load  gromacs/2020.3-gpu
    #get the md expample
    gmx_mpi  grompp -f md.mdp -c init.gro -p fws_plus.top -o md.tpr  -maxwarn 5
    #run md
    gmx_mpi  mdrun  -deffnm md
    #mpirun gmx_mpi mdrun -nsteps 50000 -v -deffnm npt-nopr -pin on -nb gpu -pme cpu -ntomp 8 -gpu_id 0123
    mpirun gmx_mpi mdrun -nsteps 50000 -v -deffnm npt-nopr -pin on -nb gpu -pme cpu -ntomp $SLURM_NPROCS -gpu_id 0
    ```
