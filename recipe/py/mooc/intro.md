+++
title = "介绍"
icon = "python"
+++

# 调试 (debug) 的技巧:
* 不要使用 `debugger`. Debugger 所作的相当于对病人的全身扫描, 不会得到某方面的有用信息, 而且它输出的信息太多, 大部分没有用.
* 最好的调试程序的方法是使用 `print` 在各个想要检查的关键环节将关键变量打印出来，从而检查那里是否有错.
	* 打印输出: 程序特定位置, 输出运行的过程信息
	* 日志文件: 对程序异常及用户使用进行定期记录
	* 帮助信息: 在特定位置, 给用户打印程序使用帮助
* 让程序一部分一部分地运行起来. 不要等一个很长的脚本写完后才去运行它. 写一点，运行一点，再修改一点.
* 如果有人建议使用 vim 或者 emacs 之类的工具, 完全不必理会他们. 选择自己用起来顺手且满足需要的工具即可(VS code 多好用), 不必要追求这些不那么重要的东西. 也要能够接受其他人使用和自己不一样的方式, 即便那些方式是自己已经尝试过并且认为非常不好或者低效的.
* 程序员在开始一个新的大项目时，都会被非理性的恐惧影响到. 为了避免这种恐惧，他们会拖延时间，到最后一事无成. 每个人都可能有这样的经历，避免这种情况的最好的方法是把自己要做的事情列出来，一次完成一件. 先做一个小一点的版本，扩充它让它变大, 把自己要完成的事情一一列出来, 然后逐个完成就可以了.
* 据说字典类型(dict)是 python 中最酷的类型, 在其他语言中被称作 `hash` 类型. 它是一种无序类型, 所以不使用序号进行索引, 可以将 `字符串` 或者 `数字` 作为键名, 而且向字典中添加, 删除, 修改其中的内容都是非常简洁快速的.
* 函数的定义尽量小巧, 函数名建议使用下划线分隔. `class` 名和变量名建议使用驼峰方式命名. 另外, 不要太过于纠结前后的一致性, 尽量保持就好了, 通常这样已经足够维持较好的可读性了, 不要刻板地被一致性束缚.
* 即便有了自己的代码风格, 不要太当作一回事. 回看很多以前的代码, 它们的审美都那么差. 每个人的代码也总会在某一些审美很差, 只是自己还没有意识到而已 ^_^.
* 不要听一些人说 "好的代码" 是不需要注释的, 这种人要么是顾问型的人物, 要么是没有和别人合作过. 注释是好东西, 但是要善于表达, 短小精悍地告诉别人做了什么, 为什么这么做. 注释不适合写的太多, 当代码更改时, 要对注释同步进行更新.

# 进度条
* 如果程序需要大量计算时间, 产生等待 -> 增加进度展示
* 程序存在大量次数循环(确定或不确定) -> 增加进度展示
* 程序有若干步骤, 需要提示用户 -> 增加进度展示和步骤提醒
* 进度条:
```bash
# 进度条 Version 2
import time
print("执行开始".center(50, "-"))
start = time.perf_counter()
for i in range(101):
	a = "|" * round(i//10 * 2)
	print(f"\r[{a:.<20}] {i:3}% time used:{time.perf_counter()-start:.1f}s", end="" if i < 100 else "\n")
	time.sleep(0.1)
```
* 可以设计不同速率的进度条(比如先慢后快), 有不同的用户体验. f(x) 为显示进度与实际进度的关系:
```bash
Linear             Constant       f(x) = x
Late Pause         Speeds down    f(x) = x+(1-sin(2pi*x + pi/2))/-8
Early Pause        Speeds up      f(x) = x+(1-sin(2pi*x + pi/2))/8
Slow wavy          Constant       f(x) = x+sin(5pi*x)/20
Fast wavy          Constant       f(x) = x+sin(20pi*x)/80
Power              Speeds up      f(x) = (x+(1-x)*0.03)**2
Inverse Power      Slows down     f(x) = (1+(1-x)**1.5)*-1
Fast Power         Speeds up      f(x) = (x+(1-x)/2)**8
Inverse Fast Power Slows down     f(x) = 1 + (1-x)**3 * -1
```

# 异常处理(快速跳过未知错误)
写出能够实现功能的代码没有什么神奇的, 厉害而且效率高的是那种不管怎么执行都不会错的代码, 这需要使用 `异常处理` 来规避不可预见的错误. python 异常处理的便捷性只比 go 稍微差了一点点点. R 的异常处理真是难用, 还不如一直用 `if...else` 好用.
* 获得用户输入, 对合规性进行检查 -> 异常处理
* 读写文件, 对结果进行判断(是否成功打开读入写出) -> 异常处理
* 进行输入输出, 对关键结果进行判断(除数是否为零) -> 异常处理

# 解决问题的思路
* IPO: 确定输入(Input) -> 确定处理内容(Process) -> 提供输出(Output)
* 自顶向下: 问题渐分渐细
* 配置化设计(程序 + 数据文件, 比如: 数值模拟中把模拟参数和函数放在不同文件中):
	* 引擎函数 + 配置文件: 程序执行和配置分离, 将可选参数配置化.
	* 将程序开发变成配置文件编写, 扩展功能时只需要修改配置文件而不修改程序.

------------------------------
# `pip` 的用法
```
pip install pkgname
pip install -U pkgname       # update
pip uninstall pkgname
pip download pkgname
pip show pkgname             # 展示包的相关信息
pip search keywords          # 搜索关键词
pip list                     # 已安装的库
```
**注意:** 如果用 pip 安装时报错, 可以尝试下载源文件本地编译安装(这和R很像), [PyPi](https://pypi.org) 和[www.lfd.uci.edu/~gohlke/pythonlibs/](www.lfd.uci.edu/~gohlke/pythonlibs/).

# Tricks 
```
datals = '1.2, 3.4, 1.5, 2.7'
'$'.join(datals.split(','))             # 用$连接列表元素
datals = map(eval, datals.split(','))   # map 可以对列表每个元素统一操作
datals = list(datals)                   # list 转换迭代表达式
print(enumerate(datals))                # enumerate 自动补上序号
print(list(enumerate(datals)))              

1.2 < 2.3 <= 4.3                        # 比较符连写
a = 1 if 3 else a = 2                   # ifelse简洁表达式

dt = {"A":1, "B":2, "C":2.3}
dt['C'] = dt.get('C', 0) + 1
dt['D'] = dt.get('D', 0) + 1            # dict.get(k, default) 很好用

map(lambda x:x*2, range(10))
filter(lambda x:x%2==0, range(10))
#reduce(lambda x,y:x+y, range(10))

dir()                                   # 空间内所有对象和导入模块

[pow(x, 2) for x in range(10)]          #列表表达式
[pow(x, 2) for x in range(10) if x%3 == 0]

eval('3 == 2')                          # 执行【表达式(不包括赋值)】, 结果可以赋值, 
exec('x = 3')                           # 执行【代码】, 结果不可赋值
```

# Python 的 33 个保留字(关键字), `True`, `False`, `None` 的首字母大写.
```
and         elif        import  raise   global
as          else        in      return  nonlocal
assert      except      is      try     True
break       finally     lambda  while   False
class       for         not     with    None
continue    from        or      yield
def         if          pass    del
```

# 逻辑
* 逻辑运算 `and`, `or`, `not`, `>`, `>=`, `<`, `<=`, `==`, `!=`
* 可以使用 `60 <= grad < 70` 这样的连等式进行逻辑计算
* True and False
* True or False
* not True
* <emph style='border-bottom:1px dashed red'>多个 and 连续表达式: 如果全非零, 返回最后一个非零值; 否则为零</emph>, `2 and 3 and 4`.
* <emph style='border-bottom:1px dashed red'>多个 or 连续表达式: 如果存在非零值, 返回第一个非零值； 否则返回零</emph>, `0 or 0 or 3 or 4`.

# 字符串的 index 与 slice
* 单值索引 str[-1] 和范围索引 str[2:-1]
* 字符串有两大类共四种表示法:
	* 一对单引号或一对双引号: 单行字符串
	* 一对三单引或一对三双引: 多行字符串(python本质上没有多行注释, 只是不赋值的多行字符串)
* 如果字符串中包含单引号, 那么需要用双引号表示字符串.
* 如果字符串中同时包含单引号和双引号, 需要使用三引号表示字符串.(可以使用转义符, 但是自己不要用啊~)
* 字符串切片操作为 str[M:N:K] 根据步长进行:
	* `str[:3]`  缺失 M, 从头开始
	* `str[3:]`  缺失 N, 到尾结束
	* `str[1:8:2]` 步长为 2
	* `str[::-1]`  对字符串逆序排列
* 不可打印的转义符:
	* `\b`   光标回退一格
	* `\n`   下一行首
	* `\r`   当前行首
* 操作符:
	* `str1 + str2`            连接两个字符串
	* `n*str` 或 `str*n`       复制 n 次
	* `x in str`               如果 x 是 str 的子串, 返回 True
* 六个有用的函数:
	* `len(x)`                 长度(中文, 英文, 数字, 标点符号的长度都是 1)
	* `str(x)`                 任意类型的 x 的两侧增加一个字符串引号
	* `hex(x)/oct(x)/bin(x)`   整数 x 的十六进制或八进制或二进制[小写字符串]
	* `chr(x)`                 unicode 编码 x 对应的字符串
	* `ord(x)`                 字符 x 的 unicode 编码(x只能是一个字符)
* Unicode 的编码范围为 0 到 111411(0x10FFFF).
* python 使用 unicode 编码, 通用几乎所有语言.

### Example: Unicode
* `"1+1=2 " + chr(10004)`            # 10004 是一个对号
* `"Unicode 9801 为 " + chr(9801)` 
* `"Unicode 9801 为 " + chr(9801)`   # 金牛的 unicode(十二星座的第二位)
* `"Unicode 9801 为 " + chr(128046)` # 一只牛

字符串的方法(点标记调用, 与函数区别):
* `str.lower()/str.upper()`         返回变换后的[副本]
* `str.split(sep=None)`             返回分割结果的[列表]
* `str.count(sub)`                  子串sub出现的次数
* `str.replace(old, new)`           返回替换后的[副本]
* `str.center(width[, fillchar])`   根据设定的宽度居中, 填充内容可选. 在打印中有用.
* `str.strip(chars)`                去掉str的左侧和右侧中的 chars里面包含的字符
* `str.join(s)`                     在 `s` 的内部每个位置添加 `str`, 如 `",".join("123")`
* `map(eval, '1, 3, 6, 1.2'.split(','))`  将 eval 作用于第二个参数的每个元素
* `map` 返回迭代类型, 可以使用 `list()` 转为列表
* 字符串的标准化格式为 `tplt.format(<逗号分隔的参数>)`:
	* `tplt` 是带有槽的字符串模板, 槽使用大括号表示, 例: `"{}:计算机{}的CPU占用率为{}%".format("2018-06-29", "C", 10)`
	* 槽中可以添加序号表明使用 `format` 中相应位置的参数, 例: `"{1}: 计算机{0}的CPU占用率为{2}%".format("C", "2018-06-29", 10)`
	* 每个槽的序号后可以用分号引导一些格式配置参数: `{2:<填充><对齐><宽度><数字千位分隔符,><.精度><类型>}`
		* 2:           序号
		* 填充:        自己设定
		* 对齐:        左对齐,右对齐,居中 分别为 "<" 和 ">" 和 "^"
		* 宽度:        自己设定, 为了让不同长度字符串保持整齐输出
			* "{0:=^20}".format("PYTHON")
			* "{0:>20}".format("PYTHON")
			* "{0:20}".format("PYTHON")   # 默认左对齐, 空格填充.
		* 千位分隔:    用逗号分隔(对十进制有用)
		* 精度:        小数点和数字
		* 类型:        b,c,d,o,x,X; e,E,f,%, 例: `"{0:b}, {0:c}, {0:,d}, {0:x}, {0:e}".format(1234)`

# 数值类型与操作
三种类型: `int`, `float`, `complex`
* `int` 有四种进制表示: 十进制, 二进制(`0b`, `0B` 开头), 八进制(`0o`, `0O`), 十六进制(`0x`, `0X`)
* `float` 的范围 `[-10^308, 10^308]`, 精度为 `10^-16`, 默认输出小数点后 16 位.
* 使用 `e` 或 `E` 作为科学记数法的记号, `4.3e-3`, `9.6E7`
* `float` 的运算结果存在<emph style='border:bottom:1px dashed red'>不确定尾数, 这不是 bug</emph>, 如 `0.1 + 0.2` 不等于 0.3, 这是由于计算中的二进制和十进制的转换造成的. <emph style='border-bottom:1px dashed red'>一般发生在小数点后16位</emph>. 所以浮点数不能直接比较大小.
* `complex` 的复数记号为 `j`.
```
print(0.1+0.2==0.3, round(0.1+0.2, 1)==0.3) # False, True
z = 1.23E-4 + 5.6E89j
```

运算:
* `x + y`, `x - y`, `x * y`
* `x / y`:                   浮点商
* `x // y`:                  商的整数部分
* `x % y`:                   余数
* `x ** y`:                  与 pow(x, y) 等价; y<1 就是开方.

二元增强操作符:
* `x += y`, `x -= y`, `x *= y`, `x /= y`,
* `x //=y`, `x %= y`, `x **= y`

几个内置数值函数:
```
---------------------------------------------------
Fun                   Description            Example
---------------------------------------------------
abs(x)
divmod(x, y)         (x//y, x%y), 商和余数
pow(x, y [,z])       (x**y)%z, 快速取余       pow(3, pow(3, 99), 10000)
round(x, [,d])       d 默认为 0
max/min(x1, ...,xn)

int(x)               int(12.43), int("123")
float(x)             float(12),  float("1.23")
complex(x)           complex(4)
---------------------------------------------------
```
内置函数的效率非常高(有可能用了 lazy evaluation), 例如, <emph style='border-bottom:1px solid red'>`3 ** (3**99) % 10000` 是算不动的, `pow(3, pow(3, 99), 10000)` 却能很快得出结果</emph>. 尽量优先使用内置函数~

```
1.01 ** 365                     #= 37.78
1.019 ** 365                    #= 962.89
```

# `intput(.)`, `print(.)`
```
print('zengchao')
print('zengchao is {:.2f} year old'.format(6))
print()
```

# `eval(...)`
把字符串最外侧的引号去掉, 将剩余部分作为 python 命令执行
* `eval("2+3")`
* `eval('"2+3"')`
* `eval(' 12.3')`    # 可以自动处理数字前后的空格
* `eval("print('zengchao is so smart')")`
* `eval(input("输入年龄: "))`   # 输入结果转成数值类型
* `a, b = eval(input("输入两个数字[逗号隔开]: "))`
* `a, b = eval(input("输入两个数字[空格隔开]: ").replace(' ', ','))`
* `map(eval, '1, 3, 6, 1.2'.split(','))`    # 将 eval 作用于第二个参数的每个元素
* `eval('print('zengchao is so smart')')`   # 会报错(引号嵌套要使用不同的引号)

# 条件结构
* `exp1 if cond else exp2`, 二分枝的简洁形式, 对应 R 中的 `ifelse(cond, exp1, exp2)`
* 多分枝条件表达式中, 要注意条件的包含和覆盖关系, 下面的例子在程序上没错, 但逻辑有问题.
	```
	grad = 80
	if grad >= 60 :
		print("D")
	elif grad >= 70 :
		print("C")
	elif grad >= 80 :
		print("B")
	else :
		print("A")
	```

# 异常处理(快速跳过未知错误)
* 基本用法: `try: exp1 except: exp2`. 逻辑上, 如果 `exp1` 有错, 则执行 `exp2`. 这个用法足够应对大多数场景了.
	```
	try :
		num = eval(input("input a integer"))
		print(num**2)
	except :
		print("input is not an integer!")
	```
* 可以指定异常类型, 对特定的异常进行特定的处理. 异常类型是 python 中预定义的(谁记得住这些东西...)
	```
	try :
		num = eval(input("input a integer: "))
		print(num**2)
	except NameError:
		print("input is not an integer!")
	```
* 异常处理的高级用法:
	```
	try :
		exp1
	except :
		exp2
	else :
		exp3
	finally :
		exp4
	```
* 有异常时执行 `exp2`,  无异常时执行 `exp3`.
* `finally` 中的 `exp4` <emph style='border-bottom:1px dashed red'>一定执行</emph>.

# 循环
* 遍历循环 `for i in set: expr` 和无限循环 `while cond: expr`
* `for` 循环的遍历集合可以使用 `range(K)`, `range(M, N, K)`, 字符串, 列表等.
* `for` 循环可以对文件的每一行进行遍历, `set` 是文件标识符, `i` 是文件中的每一行 `line`.
* `range(M, N, K)` 会自动识别 `[M, N)` 中满足条件的数字, 不需要自己来计算终止的位置.
* `for...in...` 可以处理所有可遍历的结构.

* 循环控制的保留字 `break` 和 `continue`. `continue` 会终止此次循环(当前循环后面未执行的 `expr` 不再执行了), 进入下次循环. `break` 直接跳出循环.
* `for` 和 `while` 都可以和 `else` 搭配, 当循环没有被 `break` 退出时, 执行 `else` 部分, 可以把 `else` 部分当作正常完成循环的一个奖励, 这和 `try...catch...else` 中的 `else` 部分类似.
```
s = "PYTHON"
while s != "" :
	for c in s :
		if c == "T" :
			break
		print(c, end="")
	else :
		print("正常退出")
	s = s[:-1]
```

### Eg:身体质量指数 BMI 的计算
```
定义为 BMI = 体重 / 身高**2
-----------------------------------
分类      国际BMI   国内BMI
-----------------------------------
偏瘦      <18.5     <18.5
正常      18.5~25   18.5~24
偏胖      25~30     24~28
肥胖      >=30       >=28
-----------------------------------
国际BMI和国内BMI的重叠部分较多, 可以用较少的条件进行罗列.
```
```
height, weight = eval(input("输入身高(m)和体重(kg)[逗号分隔]: "))
bmi = weight / pow(height, 2)
print("BMI 数值为: {:.2f}".format(bmi))
who, nat = "", ""
if bmi < 18.5 :
	who, nat = "偏瘦", "偏瘦"
elif 18.5 <= bmi < 24 :
	who, nat = "正常", "正常"
elif 24 <= bmi < 25 :
	who, nat = "正常", "肥胖"
elif 25 < bmi < 28 :
	who, nat = "偏胖", "偏胖"
elif 28 <= bmi < 30 :
	who, nat = "偏胖", "肥胖"
else :
	who, nat = "肥胖"
print("国际BMI分类为: {}\n国内BMI分类为 {}".format(who, nat))
```