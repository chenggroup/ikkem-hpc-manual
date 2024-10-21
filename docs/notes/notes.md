# 注意事项

1. 如用户提交的作业申请的 CPU 核数超过64核，请按照64的整数倍申请 CPU 资源，提高计算节点的使用率。

2. 为什么 `sinfo` 查看对应的分区有空闲节点，但是我的作业却还在排队

    高性能计算平台采用slurm作业调度系统，整个队列中可能有需要占用多节点的高优先级任务正在等待资源，调度器会一定程度上为这些作业保留资源，以确保它们能够运行。

3. error: Job submit/allocate failed: Invalid partition name specified

    错误原因：未指定正确的partition，可通过以下指令获取可用的分区
    ```sh
    sacctmgr show ass user=`whoami` format=part | uniq
    ```

4. error: Job submit/allocate failed: Invalid account or account/partition combination specified
    
    错误原因：通常是因为没有指定正确的账户，可通过以下指令获取可用账户。
    ```sh
    sacctmgr show ass user=`whoami` format=account%15 | uniq
    ```

5. (QOSMaxWallDurationPerJobLimit)
    
    错误原因：指定 `-t`, `--time=` 参数时，时间超过qos允许的时长，通过以下命令可以查看相应qos允许运行的最大时长。
    ```sh
    sacctmgr show qos format=name,MaxWall
    ```

6. batch job submission failed: Requested node configuration is not available
    
    错误原因：申请资源的节点配置不匹配，如partCU的每个节点只有64个核心，但用户申请申请该节点的核心数超过64，就会报错

7. (QOSNotAllowed)
    
    没有指定正确的qos，以下命令可以查看不同分区下可用的qos。
    ```sh
    sacctmgr show ass user=`whoami` format=user,part,qos
    ```

8. QOSGrpSubmitJobsLimit
    
    出现该错误的原因通常为账户没有余额，或者账户封锁了

9. Invalid qos specification
    
    目前服务器暂不支持指定 QoS，请勿添加 `-q` 参数

10. 各软件提交任务脚本
    
    在 `/public/slurmscript_demo` 目录下