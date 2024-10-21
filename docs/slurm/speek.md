# 查看作业屏幕输出：speek

查看作业屏幕输出的命令 `speek`（类似LSF的 `bpeek`），基本用法 `speek [-e] [-f] 作业号`。默认显示正常屏幕输出，如加 `-f` 参数，则连续监测输出；如加 `-e` 参数，则监测错误日志。

注：该 `speek` 命令是中科大李会民老师写的，不是slurm官方命令，在其它系统上不一定有。

```bash
#!/bin/bash
#Author: HM Li <hmli@ustc.edu.cn>
if [ $# -lt 1 ] ; then
    echo "Usage: speek [-e] [-f] jobid"
    echo -e " -e: show error log.\n -f: output appended data as the file grows.\n\nYour jobs are:"
    if [ $USER != 'root' ]; then
        squeue -u $USER -t r -o "%.8i %10P %12j %19S %.12M %.7C %.5D %R"
    else
        squeue -t r -o "%.8i %10u %10P %12j %19S %.12M  %.7C %.5D %R"
    fi
    exit
fi
NO=1
STD=StdOut
while getopts 'ef' OPT; do
    case $OPT in
        e)
           STD=StdErr
           ;;
        f)
           T='-f'
           ;;
    esac
done
JOBID=${!#}
F=`scontrol show job $JOBID 2>/dev/null | awk -v STD=$STD -F= '{if($1~'STD') print $2}'`
if [ -f "$F" ]; then
    tail $T $F
else
    echo "Job $JOBID has no $STD file or you have no authority to access."
fi
```
