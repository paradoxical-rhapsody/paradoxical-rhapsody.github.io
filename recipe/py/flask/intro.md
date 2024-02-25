+++
title = "安装和配置"
date = Date(2020, 02, 28)
icon = "python"
+++


## 写在前面
请使用 git 控制项目的进展, 这可以避免很多抓脑的问题. Git 的一些常用命令如下:
```bash
git init                                # 文件夹初始化
git add fileName  
git commit -m "commit content"
```

## Flask 自身的可导入项
```py
from flask import Flask                 # 引入 flask 类，用于实例化: app =  Flask(__name__)

from flask import request               # 来自客户端的请求上下文
from flask import session

from flask import current_app
from flask import g                     # 钩子函数, 用于调用视图函数前或后程序执行
from flask import request
from flask import session

from flask import make_response
from flask import redirect              # 重定向
from flask import abort                 # 抛出相应错误

from flask import render_template

from flask import flash                 # Flash 消息
```
  
## 简介
FLask 是由 Python 社区中的 pocoo 团队开发和维护的, 这个团队迄今已经开发了好几个优秀的包. Flask 的 [官方文档](http://flask.pocoo.org/) 提供了详细的信息参考信息, 以及 flask-extension 的相关索引.

现代 web 开发不可避免要使用 html, css 和 javaScript. 如果想要开发完整的网站, 且无法向精通客户端技术的开发者求助, 就需要对这些工具有所了解.

Flask 与 Django 的对比, 类似于 R 和 SAS 的关系. Flask 本身提供核心功能, 其余的功能通过 **flask 扩展** 实现, 用户按需要进行选择. Flask 本身有提供两个主要核心功能: **路由** 和 **调试**. 它的 web 服务器网关接口(Web Server Gateway Interface, WSGI) 由 [Werkzeug](http://werkzeug.pocoo.org/) 提供, 模板系统由 [Jinja2](http://jinjw.pocoo.org/) 提供. 两者都是 pocoo 开发维护的. 

Flask 没有提供 web 常用(但非必需)的 **数据库访问**, **表单验证** 和 **用户认证** 等功能, 但这些都能找到很多扩展包, 它们适用于不同的场景, 用户可以自行挑选, 甚至自行开发. 关于 flask 的扩展(如 flask-wtf 和 flask-email 等), 大都是对已有的优秀工具进行了特定的包装, 使得它们在 flask 中更加易用.

## 安装和配置
安装好 anaconda/miniconda(记得添加环境变量), 为了提高速度, 可以添加 [清华大学镜像](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/). 

建议用 `pipenv` 管理项目环境. 在**项目文件夹**下,
* `pipenv install` #自动配置虚拟环境, 并且创建依赖包的滚动记录文件
* `pipenv install pkg` # 在虚拟环境中安装, 并且自动记录
* `pipenv update pkg`  #
* `pipenv shell` # 激活项目所在的 py 环境
* `pipenv run python script.py` #在项目环境中运行脚本(不必要先激活)

开发 python 项目流程的第一步往往被建议创建一个开发环境. 可以通过三方工具 virtualenv 或者 anaconda/miniconda 进行创建. 目前看来, \emph{conda 创建环境的步骤更加简洁好用}. conda 本身也能更方便地管理环境, 完成 pip 的所有操作. 另外, 虽然 pypi 现在已经维护的特别好用了, 但是安装包的时候, 看来仍然不会同时安装依赖的包, 这一点在使用中不方便. 按照经验, conda 可以完成所有需要的配置操作, 而且更稳健. 

```bash
conda create -n flask python=3.6
conda install flask
conda install flask-script
conda list --export > requirements.txt #将已有的环境配置导出到文件
conda create --name xzcSite --file requirements.txt #从配置文件创建环境
conda remove -n xzcSite --all #卸载虚拟环境

# 激活/退出(两者总有一条会生效)
source activate xzcSite
conda activate xzcSite
source deactivate xzcSite
conda deactivate xzcSite
```

