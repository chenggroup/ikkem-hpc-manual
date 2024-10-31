# Gaussian

!!! info
    Gaussian 是商业授权软件，需要申请权限后使用。

```bash title="/public/slurmscript_demo/g16.slurm"
#!/bin/bash
#SBATCH --output=testSlurmJob.%j.out    # Stdout (%j expands to jobId)
#SBATCH --error=testSlurmJob.%j.err     # Stderr (%j expands to jobId)
#SBATCH -N 2                            # Maximum number of  node
#SBATCH --ntasks-per-node=1             # Maximum number CPUs  of  each node
#SBATCH --account=[budget]              # Account name
#SBATCH --partition=cpu                 # Partition name
#SBATCH --qos=[qos]                     # QOS name
#############################################################################

# Define variable "InputfileName".

InputfileName=tBu

#############################################################################

#echo ${SLURM_JOB_ID}

# change to the working directory

## create a unique scratch directoy for this calculation

myscratch=/public/home/`whoami`/scratch/$(echo ${SLURM_JOB_ID}); export myscratch

#echo $myscratch
mkdir -p $myscratch

#############################################################################


######################################G16####################################

# Define the location where Gaussian was installed and run

module load gauss/16

# Run the gaussian calculation with my new scratch directory

export GAUSS_SCRDIR=$myscratch

# Run a Gaussian command file, redirecting output
echo "Starting G16 run at" `date`

  g16 $InputfileName

echo "Finished G16 run at" `date`

##################################end########################################

date

## Remove scratch directory
rm -r -f $myscratch


formchk ${InputfileName}
```