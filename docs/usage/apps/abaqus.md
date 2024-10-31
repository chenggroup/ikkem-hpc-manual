# Abaqus

ABAQUS是一种有限元素法软件，用于机械、土木、电子等行业的结构和场分析。

!!! info
    Abaqus 是商业授权软件，需要申请权限后使用。

```bash title="/public/slurmscript_demo/abaqus.slurm"
#!/bin/bash
#SBATCH --nodes=2                 #节点数量
#SBATCH --ntasks-per-node=8       #每个节点使用的核心数量
#SBATCH --error=%j.err
#SBATCH --output=%j.out
#SBATCH --account=[budget]        # Account name
#SBATCH --partition=cpu           # Partition name
#SBATCH --qos=[qos]               # QOS name

CURDIR=`pwd`
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
NODES=`scontrol show hostnames $SLURM_JOB_NODELIST`
for i in $NODES
do
echo "$i:$SLURM_NTASKS_PER_NODE" >> $CURDIR/nodelist.$SLURM_JOB_ID
done
echo $SLURM_NPROCS

echo "process will start at : "
date
echo "++++++++++++++++++++++++++++++++++++++++"

##setting environment for abaqus-2019
export PATH=/public/software/abaqus/abaqus-2019/DassaultSystemes/SIMULIA/Commands/:$PATH

cd $CURDIR
rm -rf *.lck*
rm -rf $CURDIR/nodefile
np=$SLURM_NPROCS
nu=$SLURM_NNODES
cpuspernode=$SLURM_NTASKS_PER_NODE
echo $cpuspernode
echo $nu
echo $np

for i in $NODES
do
echo "$i" >> $CURDIR/nodefile
done

pie="'"
machinelist=$(awk '{if( NR != '$nu' ) printf "['$pie'"$0"'$pie',"'$cpuspernode'"],"}     {if(NR=='$nu') printf "['$pie'"$0"'$pie',    "'$cpuspernode'"]"}' nodefile)
echo "mp_host_list=[$machinelist]"
echo "mp_rsh_command='ssh -n -l %U %H %C'" > abaqus_v6.env
echo "mp_host_list=[$machinelist]" >> abaqus_v6.env

export MPI_IB_STRINGS=mlx5_0:1
export MPIRUN_OPTIONS="-prot"


unset SLURM_GTIDS
inputfile=abaqus_suanli.inp
abaqus job=ABAQUS cpus=$SLURM_NPROCS input=$inputfile interactive ask_delete=off > ./log


echo "++++++++++++++++++++++++++++++++++++++++"
echo "processs will sleep 30s"
sleep 30
echo "process end at : "
date
rm -rf $CURDIR/nodelist.$SLURM_JOB_ID
```