# 吸附到作业步：sattach

`sattach`可以吸附到一个运行中的Slurm作业步，通过吸附，可以获取所有任务的IO流等，有时也可用于并行调试器。

基本语法：

```bash
sattach [options] <jobid.stepid>
```

## sattach主要参数

- -h, --help：显示帮助信息。
- --input-filter\[=\]\<task number>、 --output-filter\[=\]\<task number>、--error-filter\[=\]\<task number>：仅传递标准输入到一个单独任务或打印一个单个任务中的标准输出或标准错误输出。
- -l, --label：在每行前显示其对应的任务号。
- --layout：联系slurmctld获得任务层信息，打印层信息后退出吸附作业步。
- --pty：在伪终端上执行0号任务。与--input-filter、--output-filter或--error-filter不兼容。
- -Q, --quiet：安静模式。不显示一般的sattach信息，但错误信息仍旧显示。
- -u, --usage：显示简要帮助信息。
- -V, --version：显示版本信息。
- -v, --verbose：显示冗余信息。

## sattach主要输入环境变量

- SLURM_CONF：Slurm配置文件。
- SLURM_EXIT_ERROR：Slurm退出错误代码。

## sattach例子

- `sattach 15.0`
- `sattach --output-filter 5 65386.15`
