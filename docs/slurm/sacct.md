# 查看记账信息：sacct

`sacct`显示激活的或已完成作业或作业步的记账（与机时费对应）信息。

主要参数：

- -b, --brief：显示简要信息，主要包含：作业号jobid、状态status和退出码exitcode。

- -c, --completion：显示作业完成信息而非记账信息。

- -e, --helpformat：显示当采用 --format指定格式化输出的可用格式。

- -E end_time, --endtime=end_time：显示在end_time时间之前（不限作业状态）的作业。有效时间格式：

  - HH:MM\[:SS\] \[AM|PM\]
  - MMDD\[YY\] or MM/DD\[/YY\] or MM.DD\[.YY\]
  - MM/DD\[/YY\]-HH:MM\[:SS\]
  - YYYY-MM-DD\[THH:MM\[:SS\]\]

- -i, --nnodes=N：显示在特定节点数上运行的作业(N = min\[-max)\]。

- -j job(.step), --jobs=job(.step)：限制特定作业号（步）的信息，作业号（步）可以以,分隔。

- -l, --long：显示详细信息。

- -n, --noheader：不显示信息头（显示出的信息的第一行，表示个列含义）。

- -N node_list, --nodelist=node_list：显示运行在特定节点的作业记账信息。

- --name=jobname_list：显示特定作业名的作业记账信息。

- -o, --format：以特定格式显示作业记账信息，格式间采用,分隔，利用-e, --helpformat可以查看可用的格式。各项格式中%NUMBER可以限定格式占用的字符数，比如format=name%30，显示name列最多30个字符，如数字前有-则该列左对齐（默认时右对齐）。

- -r, --partition：显示特定队列的作业记账信息。

- -R reason_list, --reason=reason_list：显示由于reason_list（以,分隔）原因没有被调度的作业记账信息。

- -s state_list, --state=state_list：显示state_list（以,分隔）状态的作业记账信息。

- -S, --starttime：显示特定时间之后开始运行的作业记账信息，有效时间格式参见前面-E参数。
