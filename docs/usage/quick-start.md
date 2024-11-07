# 快速上手

本指南旨在快速帮助新用户在嘉庚智算上启动并运行应用。它涵盖了开户、登录和运行第一个作业的过程。

## 智算用户开户

请参考[开户流程](../introduction/register.md)或联系智算运营和管理人员协助完成开户流程。

在用户的开户请求被批准后，会收到一封来自 ikkemhpc@xmu.edu.cn 的邮件，包含了用户登录的用户名、初始随机密码。
若用户申请了校外访问，还包括 ATrust 零信任终端的安装包、用户名、密码和使用说明。

## 登录到嘉庚智算

要登录到嘉庚智算，您应该使用以下地址：

```sh
ssh [userID]@10.26.14.64
```

登录流程请参考[用户登录与文件传输](login.md)。

### 配置免密登录

要配置免密登录，您需要在本地生成一个 SSH 密钥对，并将公钥复制到远程服务器。以下是详细步骤：

1. **在本地生成 SSH 密钥对**

    打开终端并运行以下命令：

    ```sh
    ssh-keygen -t ed25519 -C "your_email@example.com"
    ```

    按提示操作，您可以选择密钥默认的存放路径（通常是 `~/.ssh/id_ed25519`），并可为此密钥设置一个密语口令（可选）。

2. **将公钥复制到远程服务器**

    使用 `ssh-copy-id` 命令将公钥复制到远程服务器：

    ```sh
    ssh-copy-id [userID]@10.26.14.64
    ```

    输入您的远程服务器密码以完成公钥复制。

3. **测试免密登录**

    现在，您可以尝试使用 SSH 登录到远程服务器而无需输入密码：

    ```sh
    ssh [userID]@10.26.14.64
    ```

    如果一切配置正确，您应该能够直接登录到远程服务器。

!!! tip
    如果您在生成密钥对时选择了非默认路径，请确保在登录时使用 `-i` 选项指定私钥路径。例如：

    ```sh
    ssh -i /path/to/your/private_key [userID]@10.26.14.64
    ```

## 文件系统和数据操作

所有用户在 `/public` 文件系统上都有一个目录。目录位置如下：

- `/public/home/[user ID]`（这也是您的 home 目录）

用户可以在此目录下设立文件夹存放、归档自己的项目，并执行计算。
每个用户拥有 **10TB** 的存储使用限制，可通过如下命令检查当前的存储使用情况以及文件数量：

```sh
lfs quota -uh `whoami` /public/home/`whoami`
```

输出如下：

```plaintext
Disk quotas for usr auser (uid 35005):
     Filesystem    used   quota   limit   grace   files   quota   limit   grace
/public/home/auser
                 683.7G      0k      0k       -  174418       0       0       -
uid 35005 is using default block quota setting
uid 35005 is using default file quota setting
```

!!! warning "嘉庚智算上管理数据的注意事项"
    - 不要在单个目录中生成大量文件（>1000）。
    - 文件传输性能差通常是由于涉及的文件数量过多——通过使用归档工具来减少需要传输的文件数量以提高性能。
    - 在文件系统之间移动目录或大量文件之前，先将它们归档（例如使用 `tar` 或 `zip` 命令）。
    - 在智算上使用 `tar` 或 `rsync` 在文件系统之间传输时，避免使用压缩选项，因为这些选项可能会降低性能（通过传输较小的压缩文件节省的时间通常少于通过 即时压缩文件增加的开销）。

## 使用智算上的软件

在嘉庚智算上，软件主要通过 *module* 访问。这些模块通过 `module` 命令及其子命令加载和卸载所需的应用程序、编译器、工具和库。某些模块在登录时会默认加载，提供一个默认的工作环境；更多的模块可供使用但最初未加载，允许您根据需要设置环境。

您可以随时通过运行以下命令检查已加载的模块：

```sh
module list
```

运行以下命令将显示嘉庚智算上所有可用的环境模块，无论是否已加载：

```sh
module avail
```

可用`module av`简写替代，同时该命令支持模糊搜索，`module av m`会列出所有以 `m` 开头的软件可以通过提供模块名称的前几个字符来缩小此命令的搜索范围。
例如，运行以下命令可以找到所有可用版本和变体的 VASP：

```sh
module av vasp
```

您会看到许多模块有不同的版本。例如，`vasp/5.4.4-intel` 和 `vasp/6.2.0-intel` 是 VASP 的两个可用版本。此外，可指定默认版本，如果用户未指定版本，则使用此版本。

!!! info "重要提示"
    VASP 是商业授权软件，您必须拥有有效的许可证或权限证明才能在嘉庚智算上使用这类软件。
    通常您需要向管理员提供相关软件使用的权限证明并申请开通其使用权限。

`module load` 命令加载一个模块以供使用。按照上述示例，

```sh
module load vasp
```

将加载 VASP 的默认版本，而

```sh
module load vasp/6.2.0-intel
```

将特定加载版本 `6.2.0`。可以通过相同的 `module unload` 命令卸载已加载的模块，例如：

```sh
module unload vasp
```

上述命令将卸载当前环境中已加载的 VASP 版本。您也可以按如下方式切换软件的版本：

```sh
module switch vasp/5.4.4-intel
```

其他常用的命令包括：

  - `module help <modulename>` 提供模块的简短描述
  - `module show <modulename>` 显示模块文件的内容
  - `module list` 显示当前已经加载的全部模块
  - `module purge` 卸载当前已经加载的全部模块
  - `module switch|swap [modulefile_old] [modulefile_new]` 在不同的模块版本之间切换

!!! warning "注意"
    - 某些模块会与其他模块冲突。一个简单的例子是尝试加载已加载模块的不同版本时产生的冲突。当发生冲突时，加载过程将失败并显示错误消息。检查消息和模块输出（通过 `module show`）应能揭示冲突的原因以及如何解决。
    - 请注意模块加载的顺序。两个不同的模块将同一变量设置为不同的值，最终值将是最后加载的模块设置的值。如果您怀疑两个模块存在相互干扰的可能性，可以使用 `module show` 检查它们的内容。

## 创建作业提交脚本

要在计算节点上运行程序，您需要编写一个作业提交脚本，告诉系统您想要保留多少计算节点以及多长时间。您还需要使用 `srun` 命令来启动并行可执行文件。

使用您熟悉的文本编辑器创建一个名为 `submit.slurm` 的作业提交脚本。例如，使用 `vim`：

```bash
[auser@mu012 ~]$ cd path/to/project
[auser@mu012 project]$ vim submit.slurm
```

!!! tip
    请将上面的 `path/to/project` 替换为您计算任务所在的路径。

将以下文本粘贴到您的作业提交脚本中，并将 `[budget]` 替换为您的账户，例如 `ai4ecccg`，将 `[partition]` 替换为您希望运行的分区（例如 `cpu`），将 `[qos]` 替换为您想要的QOS（例如 `normal`）。

!!! tip
    - 关于分区、QOS和对应的收费标准，请参考[说明文档](partition.md)
    - 关于不同应用对应的提交脚本示例，请参考[应用使用说明](apps/index.md)

=== "VASP 5.4.4 提交脚本示例"
    ```bash
    #!/bin/bash -l
    
    #SBATCH --job-name=test_job
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=64
    #SBATCH --cpus-per-task=1
    #SBATCH --time=00:30:00
    
    # Replace [budget] below with your account code (e.g. ai4ecccg)
    # Replace [partition] below with your partition (e.g. cpu)
    # Replace [qos] below with your QOS (e.g. normal)
    #SBATCH --account=[budget]
    #SBATCH --partition=[partition]
    #SBATCH --qos=[qos]
    
    # Load the vasp module to get access to the vasp program
    module load intel/oneapi2021.1
    module load vasp/5.4.4-intel

    # Recommended environment settings
    # Stop unintentional multi-threading within software libraries
    export OMP_NUM_THREADS=1
    
    # srun launches the parallel program based on the SBATCH options
    mpirun vasp_std
    ```

### 作业的内存限制

集群目前设置了默认内存限制

- CPU节点每个节点 64 核，默认每个核申请 1G 内存，最大可提交内存为 251G
- GPU节点每个节点 64 核，默认每个核申请 16G 内存，最大可提交内存为 1510G

当提交的作业出现内存不足的问题（Out Of Memory）时，需要手动在脚本中设定 `--mem-per-cpu` 或者 `--mem` 参数，以增大内存的使用量。

如若要为每个 CPU 核心分配 2G 内存，提交作业时加上 `--mem-per-cpu=2G` 的选项；若要为每个任务节点分配 16G 内存，提交作业时加上 `--mem=16G` 的选项。

根据您的作业实际需求，灵活地调整这些参数的值，以达到最佳的性能。

## 提交作业到队列

您可以使用 `sbatch` 命令将作业提交到队列：

    [auser@mu012 project]$ sbatch submit.slurm
    Submitted batch job 23996
    
返回的数字是您的作业 ID。

## 监控您的作业

您可以使用 `squeue` 命令查看队列中的作业。要列出队列中自己的所有作业，请使用：

```sh
[auser@mu012 project]$ squeue
```

智算上已经做了配置，`squeue` 仅可以查看自己的作业。

## 检查作业输出

上述作业提交脚本将输出写入名为 `slurm-<jobID>.out` 的文件中（即如果作业 ID 是 23996，文件将是 `slurm-23996.out`），您可以使用 `cat` 命令检查此文件的内容。如果作业成功，您应该会看到类似以下的输出：

[auser@mu012 project]$ cat slurm-23996.out
 running on   64 total cores
 distrk:  each k-point on   64 cores,    1 groups
 distr:  one band on    1 cores,   64 groups
 using from now: INCAR
 vasp.5.4.4.18Apr17-6-g9f103f2a35 (build Oct 17 2022 16:14:22) complex

 POSCAR found :  2 types and     320 ions
 scaLAPACK will be used
    ... output trimmed ...

如果出现问题，您可在文件中找到错误消息。请结合您的专业知识，遵循[异常排查和反馈](../information/troubleshooting.md)的流程进行故障排除或反馈。

## 致谢嘉庚智算

致谢模版如下。欢迎大家将已接收的高质量成果通过[邮件](mailto:ikkemhpc@xmu.edu.cn)分享给我们。

=== "中文"

    本论文的计算结果得到了嘉庚创新实验室智算中心的支持和帮助

=== "英文"

    The calculation results of this paper have been supported and helped by ikkem Intelligent Computing Center
