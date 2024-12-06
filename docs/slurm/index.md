# 简介

!!! info "信息"
    嘉庚智算使用的 Slurm 版本为 21.08.8。
    
    本部分基于中国科大超算中心用户使用手册——[Slurm作业调度系统](https://scc.ustc.edu.cn/zlsc/user_doc/html/slurm/index.html)修改，如有错漏请参考原出处。在此特别致以感谢。

Slurm(Simple Linux Utility for Resource Management，<http://slurm.schedmd.com/>)是开源的、具有容错性和高度可扩展大型和小型Linux集群资源管理和作业调度系统。超级计算系统可利用Slurm进行资源和作业管理，以避免相互干扰，提高运行效率。所有需运行的作业无论是用于程序调试还是业务计算均必须通过交互式并行`srun`、批处理式`sbatch`或分配式`salloc`等命令提交，提交后可以利用相关命令查询作业状态等。请不要在登录节点直接运行作业（编译除外），以免影响其余用户的正常使用。


## 目录索引

- [基本概念](basic.md)
- [显示队列、节点信息: sinfo](sinfo.md)
    - [详细队列信息: scontrol show partition](partition.md)
    - [详细节点信息: scontrol show node](node.md)
    - [查看详细作业信息: scontrol show job](job.md)
- [查看服务质量](qos.md)
- [作业提交](submission.md)
    - [交互式提交并行作业：srun](./srun.md)
    - [批处理方式提交作业：sbatch](./sbatch.md)
    - [分配式提交作业：salloc](./salloc.md)
- [将文件同步到各节点：sbcast](sbcast.md)
- [吸附到作业步：sattach](sattach.md)
- [查看记账信息：sacct](sacct.md)
- [其他命令: scancel, scontrol等](others.md)

或请参见左侧目录索引。