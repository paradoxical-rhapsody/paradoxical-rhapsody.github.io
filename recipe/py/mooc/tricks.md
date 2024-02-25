+++
title = "技巧"
icon = "python"
+++


同一行代码中, 引号避免重复使用, 比如下面的代码就会报错:
> eval('print('abc')')

下面的代码是可以执行的:
> eval("print('abc')")

python 注释使用的 `#` 有很多的英文名字：
* octothorpe(八角帽)
* pound(英镑符)
* hash(电话的 # 键)
* mesh(网)

# 一行语句输出乘法表
```py
print('\n'.join([' '.join(['{}x{}={}'.format(i, j, i\*j) for j in range(1, i+1)])  for i in range(1, 10)]))
```

# 格式化输出的两种方式: 
1. `'%s*%s' % (2, 3)`
2. `'{}*{}'.format(2, 3)` 

比较起来, 使用槽进行格式化输出可以更加利于控制输出格式. 字符串的标准化格式为 `tplt.format(<逗号分隔的参数>)`:
* tplt 是带有槽的字符串模板, 槽使用大括号表示. 例: `"{}: 计算v机{}的CPU占用率为{}%".format("2018-06-29", "C", 10)` 
* 槽中可以添加序号表明使用 `format` 中相应位置的参数. 例: `"{1}: 计算机{0}的CPU占用率为{2}%".format("C", "2018-06-29", 10)`
* 每个槽的序号后可以用分号引导一些格式配置参数
    * `{2:<填充><对齐><宽度><数字千位分隔符,><.精度><类型>}`
        * 2           序号
        * 填充        自己设定
        * 对齐        左对齐,右对齐,居中 分别为 "<" 和 ">" 和 "^"
        * 宽度        自己设定, 为了让不同长度字符串保持整齐输出.
            * `"{0:=^20}".format("PYTHON")`
            * `"{0:>20}".format("PYTHON")`
            * `"{0:20}".format("PYTHON")`   # 默认左对齐, 空格填充.
        * 千位分隔    用逗号分隔(对十进制有用)
        * 精度        小数点和数字
        * 类型        b,c,d,o,x,X; e,E,f,%, 如 `"{0:b}, {0:c}, {0:,d}, {0:x}, {0:e}".format(1234)`
* 使用百分号格式化输出时的一些格式记号
    ```
    %d %i %o %u
    %x %X %e %E
    %f %F %g %G
    %c %r %s %%
    ```
* "{0:=^20,d}".format(102487)

# 命令行执行脚本
如果在 cmd 执行脚本文件, 命令为 `python file.py`. 但是有些情况下, 在执行脚本时需要用户直接设定一些参数(如读取文件或写入文件的名字), 只需要在 `file.py` 的第一行加上
```
from sys import argv
script, arg1, arg2, arg3 = argv
```
其中 `script` 是脚本文件名, `arg1` 到 `arg3` 是一些参数. `argv` 是所谓的参数变量(argument variables), 这是非常标准的编程技术, 在其他程序语言中也有应用. 对 `argv` 进行解包的好处也是显而易见的. 也可以对 `argv` 直接进行一些分析, 得到更多的参数细节(如参数长度). 

* 关于用户输入, 将上述的 `argv` 和 `input()` 结合起来, 能够实现更加灵活的效果.
* 文件处理要非常仔细, 不然容易把有用的文件弄坏或者清空. 有一点非常重要的事情：**处理完文件要 close 掉**.
* 执行过程中, 在每一个用户可能出错的地方加入提示信息，是一个很好的习惯. 这样看起来可能比较繁琐, 但是在文件操作这样需要特别小心的地方, 这些提示是必要的.

# 下面可以作为一个脚本文件在命令行中执行
```
from sys import argv

script, filename = argv
txt = open(filename)

print("Here's your file %r:" % filename)
print(txt.read())

print("I'll also ask you to type it again:")
file_again = input("> ")
txt_again = open(file_again)
print(txt_again.read())
```

在 `open` 文件时, 有一些选项可以设定文件被打开的方式. 文件被 `open` 之后, 得到的文件句柄主要有如下的方法:
* `close`             菜单操作中 `文件 -> 保存` 类似
* `read`              读取全部内容
* `readline`          读取一行的内容
* `truncate`          清空整个文件【慎用】
* `write(stuff)`      将 stuff 写入文件
如果每次写入一行字符串, 可以紧随其后添加一句写入换行符的命令(看需要).

# 复制文件
```
from sys import argv
from os.path import exists

script, from_file, to_file = argv

print("Copying from %s to %s" % (from_file, to_file))

# we could do these two on one line too, how?
input = open(from_file)
indata = input.read()

print("The input file is %d bytes long" % len(indata))
print("Does the output file exist? %r" % exists(to_file))
print("Ready, hit RETURN to continue, CTRL-C to abort.")
input()

output = open(to_file, 'w')
output.write(indata)

print("Alright, all done.")
output.close()
input.close()
```
上面这段复制文件的程序的提示信息看起来非常详细, 但是输出的内容在很多情况下并不需要, 可以适当删减一些.

----
* python 中, 包含 `__init__.py` 文件的文件夹目录目录被视为可导入的包. 导入一个包时, `__init__.py` 会执行并定义这个包暴露给外界的属性.
* 字符串是被过度优化的序列类型, 索引方式跟 `list` 和 `tuple` 等序列类型相同. `list('ABC')` 会拆分出一个列表, 进一步可以 `tuple(list('ABC'))`.
* 使用 `collections.Counter` 对像进行计数
  ```
  from collections import Counter
  c = Counter('Hellow World!')
  c.most_common(2) # the top 2 most characters
  ```
* 打印数字 1 到 100, 其中 3 的倍数打印 "Fizz" 来替换这个数字, 5 的倍数打印 "Buzz", 既是 3 的倍数又是 5 的倍数则打印 "FizzBuzz".
  ```
  for x in range(1, 101):
    print('Fizz'[x%3*len("Fizz")::] + 'Buzz'[x%5*len('Buzz')::] or x)
  ```
* 同时迭代两个列表
  ```
  ls01 = ['Packers', '49ers']
  ls02 = ['Ravens', 'Patriots']
  for t01, t02 in zip(ls01, ls02):
    print(t01 + ' vs ' + t02)
  ```
* 带索引的列表迭代
  ```
  ls = list('EDCBA')
  for idx, ele in enumerate(ls):
    print(idx, ele)
  ```
* 使用 `itertools.combinations` 查找所有组合
  ```
  from itertools import combinations
  ls = ['Packers', '49ers', 'Ravens', 'Patriots']
  for iEle in combinations(ls, 2):
    print(iEle)
  ```
* 将 `json` 数据以更可读的方式打印
  ```
  import json
  print(json.dumps(data))
  print(json.dumps(data, indent=2))
  ```