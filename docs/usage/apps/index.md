# 软件使用说明

在快速开始指南的[使用智算上的软件](../quick-start.md#_6)部分中，我们介绍了如何使用 `module` 来加载软件及依赖。
而在[创建作业提交脚本](../quick-start.md#_7)部分中，我们介绍了如何编写一个 Slurm 作业脚本。

## 应用使用说明和作业脚本示例

以下列出一些软件的示例提交脚本，请使用时注意替换成自己真实的配置。

- [Abaqus](abaqus.md)
- [Lammps](lammps.md)
- [GROMACS](gromacs.md)
- [COMSOL](comsol.md)
- [CP2K](cp2k.md)
- [Gaussian](gaussian.md)
- [ORCA](orca.md)
- [Matlab](matlab.md)
- [PyTorch](pytorch.md)
- [VASP](vasp.md)

除了直接安装的软件，用户还可以通过容器来调用一些有特殊环境需求或不易安装的软件。

## Singularity

容器作为轻量级的虚拟机，可在主机之外提供多种系统环境选择，如某些软件可能只在某个linux发行版本上运行；另外，在容器中一次打包好软件及相关依赖环境之后，即可将复杂的软件环境在各种平台上无缝运行，无需重复多次配置，大大减轻相关工作人员的工作量；因为可以利用容器技术在一台物理机器上部署大量不同的系统（一台物理机支持的容器远多于传统虚拟机），提高了资源利用率，因此在近几年变得非常流行。目前主流的容器为docker，其最初被用于软件产品需要快速迭代的互联网行业，极大地简化了系统部署、提高了硬件资源的利用率，近来也在各种特定领域的应用系统中被使用。

### singularity 调用

singularity有许多命令，常用的命令有，pull、run、exec、shell、build

1. `pull`: 从给定的URL下载容器镜像，常用的有URL有Docker Hub(docker://user/image:tag) 和 Singularity Hub(shub://user/image:tag)，如

    ```bash
    singularity pull tensorflow.sif docker://tensorflow/tensorflow:latest
    ```

2. `run`: 执行预定义的命令

3. `exec`: 在容器中执行某个命令
  
    ```bash
    singularity exec docker://tensorflow/tensorflow:latest python example.py
    ```
  
    或
  
    ```bash
    singularity exec tensorflow.sif python example.py
    ```

4. `shell`: 进入容器中的shell

    ```bash
    singularity shell docker://tensorflow/tensorflow:latest
    ```

    或

    ```bash
    singularity shell tensorflow.sif
    ```

    然后可在容器的shell中运行自己的程序

5. `build`: 创建容器镜像
