+++
title = "Flask 的框架"
date = Date(2019, 01, 14)
icon = "python"
+++


## 原则
##### 富有设计思想或依赖基本原理或遵循基本手段的东西, 可以尝试尽可能深刻地理解背后的几条可能的原则, 在运用的时候不要忽略它们, 就可以比较准确的抓住问题的本质, 能够快速构建输入输出模型, 解决遇到的多数问题.

Flask 的设计十分简洁普遍, 描述了从客户端(浏览器)发出<emph style='border:1px solid red'>请求</emph>到服务器返回<emph style='border:1px solid red'>响应</emph>的过程(请求-响应循环), 包括 <span style="border:1px dashed red">三个对象</span>和<span style="border:1px dashed red">两个关系</span>。三个对象是 <span style="border-bottom:1px dashed red">模板</span> 和 <span style="border-bottom:1px dashed red">数据库</span> 和 <span style="border-bottom:1px dashed red">url</span>. 两个关系指的是 <span style="border-bottom:1px dashed red">视图函数</span> 和 <span style="border-bottom:1px dashed red">路由</span>. 视图函数用来将提取到的数据渲染到模板中, 路由用来将 url 映射到相应的视图函数上.

一个简单的 flask 示例程序如下:
```
# hello.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return '<h1>Welcome</h1>'

@app.route('/user/<name>')
def user(name):
    return '<h1>Welcome, {0}</h1>'.format(name)

if __name__ == '__main__':
    app.run(debug=TRUE)
```

## 请求
**程序和请求上下文** 的全局变量有四个, `current_app, g, request, session`. 

**请求调度** 指从程序的 url 映射中查找请求的 url 对应的视图函数. `app.url_map` 可以查看 url 映射, 其中也包括了 url 的请求方法(HEAD, GET, POST 等).

**请求钩子** 提供了 <emph style='border-bottom:1px dashed red'>处理请求之前或之后</emph> 执行一些功能. 比如在处理请求之前可能要连接数据库或认证用户. 支持四种钩子函数, `before_first_request, before_request, after_request, teardown_request`. 钩子函数和视图函数之间通常需要通过上下文全局变量 `g` 共享一些数据, 比如在 `before_request` 中可以从数据库中加载登陆的用户信息, 将其保存到 `g.user` 中, 随后在视图函数中调用 `g.user` 获取用户信息.

## 响应
视图函数返回给客户端响应信息. HTTP 协议要求响应不是单纯地渲染一个 html 页面, <emph style='border-bottom:1px dashed red'>状态码</emph> 也是 http 响应的重要部分. 视图函数可以将状态码作为第二个返回参数. 默认的状态码为 200, 表示请求被成功处理. 如果是其他状态码, 需要显式地提供给视图函数.

典型的响应类型如下:
* 简单字符串和状态码
  ```
  @app.route('/')
  def index():
    return '<h1>Hello</h1>', 400        # 状态码 400 表示请求无效
  ```
* `response` 对象, 可以调用各种设置之后, 最后响应
  ```
  from flask import make_response

  @app.route('/')
  def index():
    response = make_response('<h1>Hello~</h1>')
    response.set_cookie('answer', '42')
    return response
  ```
* `redirect` 转到其他 url 页面
  ```
  from flask import redirect

  @app.route('/')
  def index():
    return redirect('http://www.baidu.com')
  ```
* `abort` 用于处理错误(错误信息和页面都可以自己编写). 注意 abort 通常是在视图函数的条件语句中, 在出现某些错误时才会调用. 被调用之后, 当前视图函数就运行结束了.
  ```
  from flask import abort

  @app.route('/<int:id>')
  def get_user(id):
    user = load_user(id)
    if not user:
        abort(404)                     # 错误 404 的返回页面可以自己定义
    return '<h1>Hello, {0}</h1>'.format(user.name)
  ```
* `模板 + 数据` <emph style='border:2px dashed red'>是最佳的响应方式</emph>, 能够提供形式简洁且结构良好的响应. 模板提供了页面外观(表现逻辑), 数据提供了要展示的关键信息(业务逻辑).
  ```
  from flask import render_template

  @app.route('/')
  def index():
    return render_template('index.html')

  @app.route('/user/<name>')
  def user(name):
    return render_template('user.html', name=name)
  ```
