# Anaconda

目前，嘉庚智算上已经预置了 Anaconda 环境，因此用户可以借助该环境，方便地创建自己的 Python 虚拟环境，可以支持安装任意 Python 版本，并可用于安装一些常用的软件和依赖。

!!! tip "提示"
    用户可直接调用此预置环境，无须自行在用户目录下安装 Anaconda 或者 Miniconda。

## 加载基础环境

首先，加载Anaconda模块，可以通过以下命令加载Anaconda基础环境：
```bash
module load anaconda/2022.5
```

## 创建虚拟环境
如果你还没有虚拟环境，可以按照以下步骤创建一个新的虚拟环境：

1. 首先，激活Anaconda的基础环境：
    ```bash
    source activate base
    ```

2. 然后，创建一个新的虚拟环境。这里我们推荐使用 `-p <prefix>` 的方式创建在用户目录下，便于精确管理 Conda 环境的路径。例如：
    ```bash
    conda create -p /public/home/username/conda/envs/playground
    ```

    您也可以在这一步骤指定所需的 Python 环境，例如：

    ```bash
    conda create -p /public/home/username/conda/envs/playground python=3.11
    ```

3. 创建完成后，激活新创建的虚拟环境：
    ```bash
    source activate /public/home/username/conda/envs/playground
    ```

!!! info "注意"
    在集群环境下更推荐使用 `source activate <env>` 而非 `conda activate <env>`。
    尽管官方推荐使用后者，但在集群的复杂环境下，前者是更不容易出错的选择。
    并且使用前者无须确保在 `~/.bashrc` 中写入 `# >>> conda initialize >>>` 字段，可以有效避免潜在的环境冲突问题。

## 在使用时加载虚拟环境

假设你需要在使用到创建的上述虚拟环境：`/public/home/username/conda/envs/playground`，则可以通过以下命令激活它：

```bash
module load anaconda/2022.5
source activate /public/home/username/conda/envs/playground
```

当然，如果你想要加载具有指定名称或者路径前缀的 Conda 环境，请将 `/public/home/username/conda/envs/playground` 替换为你的环境名或路径。

该命令也可以写在 Slurm 提交脚本中，但一般建议先 `module purge` 以避免环境冲突:

```bash
#!/bin/bash
#SBATCH ...

# set environment
set -e
module purge
module load anaconda/2022.5
source activate /public/home/username/conda/envs/playground
set +e

# ...
```

## 注意事项

不建议在 `~/.bashrc` 中引入 `conda init` 创建的初始化指令，因为这可能会导致环境冲突和加载问题。具体原因如下：

- **环境冲突**：自动加载Conda环境可能会与其他软件或环境发生冲突，导致无法正常工作。
- **加载问题**：在某些情况下，自动加载Conda环境可能会导致加载顺序问题，影响其他环境的初始化。

建议在需要使用Anaconda环境时，手动加载和激活相应的环境，以确保环境的独立性和稳定性。

## 其他有用的命令
以下是一些其他有用的 Conda 命令：

### 列出所有虚拟环境

```bash
conda env list
```

### 删除虚拟环境
```bash
conda remove -p <prefix> --all
```

### 安装包到虚拟环境
```bash
conda install <package_name>
```

请根据你的实际需求使用这些命令。
