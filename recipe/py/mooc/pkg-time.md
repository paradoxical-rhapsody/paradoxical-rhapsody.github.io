+++
title = "time"
icon = "python"
tags = ["module", ]
+++

# time

`time` 是处理时间的标准库, 功能包括：
* 计算机时间的表示
* 获取系统时间, 格式化输出
* 系统级精确计时功能

三类基本函数：
* 时间获取        `time()`, `ctime()`, `gmtime()`
* 时间格式化      `strftime()`, `strptime()`, 需要一个显示模板
* 程序计时        `sleep()`, `perf_counter()`

还有其他函数可以实现一些功能.
> import time

* `time.time()`             # 获取时间戳(浮点值)
* `time.ctime()`            # 完整时间值(字符串), 人类可读
* `time.gmtime()`           # `struct_time`, 计算机易处理(其他语言也可利用)

* `time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())`          # 获取时间, 格式化显示

* `time.strptime("2018-06-29 20:38:00", "%Y-%m-%d %H:%M:%S")`  # 给定时间, 转换为计算机形式
```plaintext
%Y    年份           0000-9999
%m    月份           01-12
%B    月份名称       January-December
%b    月份缩写       Jan-Dec
%d    日期           01-31
%A    星期           Monday-Sunday
%a    星期缩写       Mon-Sun
%H    小时(24制)     00-23
%h    小时(12制)     00-12
%p    上午/下午      AM/PM
%M    分钟           00-59
%S    秒             00-59
```

* `perf_counter()` 得到一个 CPU 级别的精确 `时间点` 值, 单位为秒, 精度为 `纳秒`. 由于这个时间点计数值起点不确定, 连续调用计算差值才有意义.

```python
start = time.perf_counter()
time.sleep(2.0)
end   = time.perf_counter()
end - start
```