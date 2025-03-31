+++
title = "os"
icon = "python"
tags = ["module", ]
+++

# os

`os` 库是标准库, 提供了 `几百个` 通用的与操作系统交互的功能, 在 win, MacOs, linux 系统下通用. 功能包括:
* 路径操作: os.path 子库, 处理文件路径和信息等.
* 进程管理: 启动系统中其他程序.
* 环境参数: 获得系统软硬件等环境参数.
* 其他很多功能...

> import os.path as op

## 路径操作

下面参数都为 `path`, 表示一个 `文件` 或者 `目录`

```python
op.abspath('file.txt')            # 返回绝对路径
op.normpath('file.txt')        # 归一化路径表示, 用 \\ 分隔路径
op.relpath('file.txt')            # 当前程序与文件之间的相对路径

op.dirname('file.txt')            # 文件的目录名
op.basename('file.txt')           # 返回 path 的文件名称
op.join('D:/', 'file.txt')        # 合并参数, 返回路径`字符串`

op.exists('file.txt')             # path的文件或目录是否存在, 返回True/False
op.isfile('file.txt')             # 路径是否为存在的文件, True/False
op.isdir('file.txt')              # 路径是否为存在的目录, True/False

# 可以用time.ctime() 查看下面操作的具体时间
op.getctime('file.txt')           # path 的创建时间
op.getatime('file.txt')           # path 的上一次访问时间
op.getmtime('file.txt')           # path 的最近一次修改时间

op.getsize('file.txt')            # path 的大小, 单位:字节
```

## 环境参数: 获取和改变系统环境信息

```python
import os

os.chdir("D:")                # 更改路径
os.getcwd()                   # 获取当前路径
os.listdir()

os.getlogin()                 # 当前登陆系统的用户名
os.cpu_count()                # cpu 的数量

os.urandom(n)                 # 获得 n 字节长度的随机字符串, 常用于加解密运算
```

## 进程管理

进程管理就是在 `python` 中调用其他程序, 命令为: 
> os.system(command)    # 可以执行程序或cmd命令.

在 `win` 中, 返回值为 cmd 的返回信息(返回 0 表示成功运行).

`os.system(cmd)` 能实现的功能:
* 编写各类语言的代码脚本, 在python中自动运行; 对用时间程序等.
* 自动安装维护很多第三方库. 可以将库名录入文件, 以后只修改这个文件. 假设要安装 20 个第三方库(pip 时全部小写):
```plaintext
numpy, matplotlib, jieba, beautifulsoup4, django, pandas, requests
PIL(pillow)         图像处理
scikit-learn        机器学习和数据挖掘
wheel               第三方库文件见打包工具
pyinstaller         打包为可执行文件
flask               轻量级 Web 开发
WeRoBot             微信机器人开发
SymPy               符号计算
Networkx            复杂网络和图结构的建模和分析
PyQt5               基于Qt的专业级GUI开发
PyOpenGL            多平台OpenGL开发
PyPDF2              pdf 文件内容提取及处理
docopt              python 命令行解析
PyGame              简单小游戏开发
```

```python
import os

# 可以将库名写在文件里, 在程序中读取
libs = {'numpy', 'matplotlib', 'pillow', 'sklearn', 'requests', \
        'jieba', 'beautifulsoup4', 'django', 'pandas', 'wheel', \
        'sklearn', 'pyinstaller', 'flask', 'werobot', \
        'sympy', 'networkx', 'pyqt5', 'pyopengl', 'pypdf2', \
        'docopt', 'pygame'}
try:
    for lib in libs:
        os.system("pip install -i https://pypi.tuna.tsinghua.edu.cn/simple " + lib)
    print("Sucessful")
except:
    print("Failed Somehow")
```
