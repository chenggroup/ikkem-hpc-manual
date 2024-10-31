# PyTorch

对于 PyTorch 等机器学习软件，我们推荐用户安装在用户目录或组共享目录下：

```bash
module load anaconda/2022.5
source activate base
conda create -n torch-env python=3.10
source activate torch-env
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
```

在使用时利用如下脚本示例：

```bash title="/public/slurmscript_demo/pytorch.slurm"
#!/bin/bash
#SBATCH --job-name=lp_job_test          # Job name
#SBATCH --output=testSlurmJob.%j.out    # Stdout (%j expands to jobId)
#SBATCH --error=testSlurmJob.%j.err     # Stderr (%j expands to jobId)
#SBATCH --nodes=1                       # Maximum number of nodes to be allocated
#SBATCH --ntasks-per-node=1             # Maximum number of tasks on each node
#SBATCH --account=[budget]              # Account name
#SBATCH --partition=gpu                 # Partition name, use `gpu` for GPU
#SBATCH --qos=[qos]                     # QOS name
#SBATCH --gres=gpu:1                    # Apply for 1 GPU card
#SBATCH --parsable

nvidia-smi
echo "CUDA_VISIBLE_DEVICES = $CUDA_VISIBLE_DEVICES"
source ~/.bashrc
hostname >./hostfile
echo $SLURM_NTASKS
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo $SLURM_NPROCS
echo $SLURM_NPROCS

source activate torch-env
python -V
echo "CUDA_VISIBLE_DEVICES = $CUDA_VISIBLE_DEVICES"
python testgpu.py
#python run_baselines.py
```