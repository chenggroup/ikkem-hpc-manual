# 平台资源

含4个管理节点（2*Intel 6338 Xeon CPU，共64 CPU核心, 512 GB内存，2*240GB SSD硬盘）、1个登录节点、1个监视节点、6个8卡GPU计算节点（2*Intel 8358 Xeon CPU，共64 CPU核心，1536 GB内存，8*Tesla A100 GPU）、390个双路CPU计算节点（2*Intel 6338 Xeon CPU ，共64 CPU核心, 256 GB内存，240GB SSD硬盘）2个FAT胖节点（2*Intel_8358_Xeon CPU, 共64 CPU核心，1024 GB内存，2*240GB SSD硬盘，2*2TB SSD硬盘）

## 管理节点（3个）：

用于系统管理

| 节点名 | CPU | 内存 | 硬盘 | 高速网络 | 型号 |
|--------|-----|------|------|----------|------|
| mu001-mu003 | 2*Intel 6338 Xeon CPU，共64 CPU核心 | 512 GB | 2*240GB SSD硬盘 | HDR 100Gbps InfiniBand | 浪潮NF5280M6 |

## 登录节点（1个）：

- 用于用户登录、编译与通过作业调度系统提交管理作业等。
- 禁止在此节点上不通过作业调度系统直接运行作业。

| 节点名 | CPU | 内存 | 硬盘 | 高速网络 | 型号 |
|--------|-----|------|------|----------|------|
| mu003 | 2*Intel 6338 Xeon CPU，共64 CPU核心 | 512 GB | 2*240GB SSD硬盘 | HDR 100Gbps InfiniBand | 浪潮NF5280M6 |

## GPU计算节点（6个）：

适合GPU应用，加速性能：[https://developer.nvidia.com/hpc-application-performance](https://developer.nvidia.com/hpc-application-performance)。

| 节点名 | CPU | 内存 | GPU | 硬盘 | 高速网络 | 型号 |
|--------|-----|------|-----|------|----------|------|
| gpu001-gpu006 | 2*Intel 8358 Xeon CPU | 536 GB | 8*Tesla A100 | 2*2TB SSD硬盘 | HDR 200Gbps InfiniBand | 浪潮NF5688LM6 |

## 双路CPU计算节点（390个）：

| 节点名 | CPU | 内存 | 硬盘 | 高速网络 | 型号 |
|--------|-----|------|------|----------|------|
| cu001-cu390 | 2*Intel 6338 Xeon CPU | 256GB DDR4-3200MHz | 240GB固态硬盘 | HDR 100Gbps InfiniBand | 浪潮NF5160LM6 |

## 双路CPU大内存计算节点（2个）：

适合大共享内存应用。

| 节点名 | CPU | 内存 | 硬盘 | 高速网络 | 型号 |
|--------|-----|------|------|----------|------|
| fat001-fat002 | 2*Intel 6338 Xeon CPU | 2TB DDR4 3200MHz | 2*2TB NVMe | HDR 100Gbps InfiniBand | 浪潮NF8260LM6 |

## 存储系统：

- 容量: 配置裸容量4.57PB，单盘容量 14TB，可用容量 3.15PB，采用 RAID6保护模式，采用 7200RPMNL-SAS 硬盘
- 网络：通过 Infiniband 高速计算网络接入系统，配置4个200Gbps HDR Infiniband接口，单口速率 200Gbps，Infiniband 网络所有端口总速率 800Gbps
- 单流读性能 6GB/s; 单流写性能 5GB/s; 并行文件系统总写性能 40GB/s，并行文件系统总读性能 50GB/s。
- 编译器：Intel、NVIDIA HPC SDK和GNU等C/C++ Fortran、GPU编译器
- 运算处理器: 存储控制器的 CPU 运算处理器为 8 架构，每节点配置2颗运算处理器
- 并行环境：HPC-X、Intel MPI和Open MPI等，支持MPI并行程序；各节点内的CPU共享内存，节点内既支持分布式内存的MPI并行方式，也支持共享内存的OpenMP并行方式；同时支持在节点内部共享内存，节点间分布式内存的混合并行模式。
- 资源管理和作业调度：[Slurm](https://slurm.schedmd.com/)