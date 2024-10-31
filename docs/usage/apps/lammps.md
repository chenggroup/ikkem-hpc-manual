# LAMMPS

LAMMPS（Large-scale Atomic/Molecular Massively Parallel Simulator）是经典分子动力学模拟软件。LAMMPS 提供了固体（如金属、半导体）、软物质（如生物分子、高分子）以及 coarse-grained 体系和介观体系的力场。

## 参考链接
- [LAMMPS 文档](https://www.lammps.org/doc.html)
- [LAMMPS Mailing List](https://www.lammps.org/mail.html)

## 嘉庚智算上的LAMMPS

嘉庚智算上提供了基于 Intel OneAPI 构建的 LAMMPS，支持以下软件模块:

```
AMOEBA ASPHERE BOCS BODY BPM BROWNIAN CG-DNA CG-SPICA CLASS2 COLLOID COLVARS
CORESHELL DIELECTRIC DIFFRACTION DIPOLE DPD-BASIC DPD-MESO DPD-REACT
DPD-SMOOTH DRUDE EFF ELECTRODE EXTRA-COMMAND EXTRA-COMPUTE EXTRA-DUMP
EXTRA-FIX EXTRA-MOLECULE EXTRA-PAIR FEP GRANULAR INTERLAYER KSPACE MANYBODY MC
MEAM MESONT MISC ML-IAP ML-POD ML-SNAP ML-UF3 MOFFF MOLECULE OPENMP OPT ORIENT
PERI PHONON PLUGIN PLUMED POEMS QEQ REACTION REAXFF REPLICA RIGID SHOCK SPH
SPIN SRD TALLY UEF YAFF
```

通过集成 `PLUGIN` 模块，用户可用此版本调用 DeePMD-kit 接口等插件。

以下是示例脚本

```bash title="/public/slurmscript_demo/lammps.slurm"
#!/bin/bash -l
#SBATCH --parsable
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=64
#SBATCH --partition cpu
#SBATCH --qos normal
#SBATCH -J test

module load lammps/2024.8.29-intel-2023

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

mpirun -machinefile hostfile -np $SLURM_NTASKS lmp_mpi -in input.inp >& output_$SLURM_JOB_ID
```