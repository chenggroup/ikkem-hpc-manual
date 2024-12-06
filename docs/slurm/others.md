# 其它常用作业管理命令

## 终止作业：`scancel job_id`

如果想终止一个作业，可利用`scancel job_id`来取消，`job_id` 可以为以 `,` 分隔的多个作业ID，如：

```bash
scancel 114514
```

即可取消运行作业编号为 114514 的作业。

## 挂起排队中尚未运行的作业：`scontrol hold job_list`

`scontrol hold job_list`（`job_list` 可以为以 `,` 分隔的作业ID或 `jobname=作业名`）命令可使得排队中尚未运行的作业（设置优先级为0）暂停被分配运行，被挂起的作业将不被执行，这样可以让其余作业优先得到资源运行。

被挂起的作业在用 `squeue` 命令查询显示的时 NODELIST(REASON) 状态标志为 JobHeldUser（被用户自己挂起）或 JobHeldAdmin（被系统管理员挂起），利用 `scontrol release job_list` 可取消挂起。

下面命令将挂起作业号为 1919810 的作业：

```bash
scontrol hold 1919810
```

## 继续排队被挂起的尚未运行作业：`scontrol release job_list`

被挂起的作业可以利用 `scontrol release job_list` 来取消挂起，重新进入等待运行状态，`job_list` 可以为以 `,` 分隔的作业ID或jobname=作业名。

```bash
scontrol release 1919810
```

## 重新运行作业：`scontrol requeue job_list`

利用 `scontrol requeue job_list` 重新使得运行中的、挂起的或停止的作业重新进入排队等待运行，`job_list` 可以为以 `,` 分隔的作业ID。

```bash
scontrol requeue 1919810
```

## 重新挂起作业：`scontrol requeuehold job_list`

利用 `scontrol requeuehold job_list` 重新使得运行中的、挂起的或停止的作业重新进入排队，并被挂起等待运行，`job_list` 可以为以 `,` 分隔的作业ID。之后可利用 `scontrol release job_list` 使其运行。

```bash
scontrol requeuehold 1919810
```

## 最优先等待运行作业：`scontrol top job_id`

利用 `scontrol top job_list` 可以使得尚未开始运行的job_list作业排到用户自己排队作业的最前面，最优先运行，`job_list` 可以为以 `,` 分隔的作业ID。

```bash
scontrol top 1919810
```

## 等待某个作业运行完：`scontrol wait_job job_id`

利用 `scontrol wait_job job_id` 可以等待某个 `job_id` 结束后开始运行，一般用于脚本中。

```bash
scontrol wait 1919810
```

## 更新作业信息：`scontrol update SPECIFICATION`

利用 `scontrol update SPECIFICATION` 可以更新作业、作业步等信息，`SPECIFICATION` 格式与 `scontaol show job` 的输出相一致。

如下面命令将更新作业号为 1919810 的作业名为 `Tadokoro`：

```bash
scontrol update JobId=1919810 JobName=Tadokoro
```
