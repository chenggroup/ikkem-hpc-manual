# 重大更新公告

## 2024-10-31

新用户手册文档 <https://ai4ec.ikkem.com/ikkem-hpc/doc> 现已上线。

同时，为避免登录节点资源被滥用导致集群的正常功能受影响，
我们在登录节点对每位用户可使用的资源进行了限制，
目前该限制为允许每位用户最多可使用 8 核 CPU、 16G 内存。

登录节点的功能是让大家提交作业和执行基本操作，
例如文件编辑、复制、移动等，
对于资源使用量大的作业，
如并行编译大型软件、数据处理、科学计算等任务，
需要提交到相应的计算节点执行。

对于需要长时间运行的作业，建议编写脚本并使用 `sbatch` 作业提交
或使用 `salloc` 申请节点并登录，
简短的任务则可使用 `srun` 执行。

希望以上信息对大家有所帮助，
感谢您的理解和支持。

## 2024-10-12

嘉庚创新实验室智能计算中心系统升级工作已进入最后阶段。
为您后续更好的使用新系统，
我们将现在起至 2024 年 10 月 15 日 24 时设置为过渡期，
完成最后的用户和作业迁移工作，
现将该时期的相关工作公告如下：

1. 即日起，您可以通过如下新的登录节点登录集群提交作业：

    ```sh
    ssh username@10.26.14.64
    ```

    或通过 SCOW 算力管理平台访问

    <http://10.26.14.63:8080>

    SCOW 的使用文档请参考：
    <https://pkuhpc.github.io/OpenSCOW/docs/info>

2. 为方便您进行相应的作业调整和测试，
在过渡期您通过新登录节点提交的作业将不进行计费。
您在原登录节点提交的作业将继续按原有方式计费。

3. 我们将以 15 日 24 时原系统中的账户余额作为您新系统的账户初始额度。
16 日零时起，系统将对进行的任务和新提交的任务正常计费，
计费标准不变。

4. 特别提醒，15 日 24 时，我们将终止您通过旧登录节点提交且还在进行中的作业，请您提前做好安排。

5. 请留意，升级后的集群需要使用分区和 qos 指定作业提交队列，
您可按登录后的提示信息对您的脚本进行修改。

使用过程如遇到问题，请及时向管理员提供反馈。