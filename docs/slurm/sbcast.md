# 将文件同步到各节点：sbcast

`sbcast`命令可以将文件同步到各计算节点对应目录。

当前，用户主目录是共享的，一般不需要此命令，如果用户需要将某些文件传递到分配给作业的各节点`/tmp`等非共享目录，那么可以考虑此命令。

`sbcast` 命令的基本语法为：

```bash
sbcast [-CfFjpstvV] SOURCE DEST
```

此命令仅对批处理作业或在Slurm资源分配后生成的shell中起作用。SOURCE是当前节点上文件名，DEST为分配给此作业的对应节点将要复制到文件全路径。

## sbcast主要参数

- -C \[library\],
  --compress\[=library\]：设定采用压缩传递，及其使用的压缩库，\[library\]可以为lz4（默认）、zlib。
- -f, --force：强制模式，如果目标文件存在，那么将直接覆盖。
- -F number,
  --fanout=number：设定用于文件传递时的消息扇出，当前最大值为8。
- -j jobID\[.stepID\], --jobid=jobID\[.stepID\]：指定使用的作业号。
- -p, --preserve：保留源文件的修改时间、访问时间和模式等。
- -s size,
  --size=size：设定广播时使用的块大小。size可以具有k或m后缀，默认单位为比特。默认大小为文件大小或8MB。
- -t seconds, fB--timeout=seconds：设定消息的超时时间。
- -v, --verbose：显示冗余信息。
- -V, --version：显示版本信息。

## sbcast主要环境变量

- SBCAST_COMPRESS：类似-C, --compress。
- SBCAST_FANOUT：类似-F number, fB--fanout=number。
- SBCAST_FORCE：类似-f, --force。
- SBCAST_PRESERVE：类似-p, --preserve。
- SBCAST_SIZE：类似-s size, --size=size。
- SBCAST_TIMEOUT：类似-t seconds, fB--timeout=seconds。

## sbcast例子

将`my.prog`传到`/tmp/my.proc`，且执行：

- 生成脚本`my.job`：

```bash
#!/bin/bash
sbcast my.prog /tmp/my.prog
srun /tmp/my.prog
```

- 提交：

  `sbatch --nodes=8 my.job`
