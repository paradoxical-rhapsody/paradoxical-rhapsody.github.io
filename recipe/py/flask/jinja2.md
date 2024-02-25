+++
title = "Jinja2 模板引擎"
date = Date(2019, 03, 23)
icon = "python"
+++


## 模板的作用
在 `模板+数据` 的响应模式中, 模板提供了页面外观布局(表现逻辑), 数据提供了要展示的关键信息(业务逻辑指针对数据的后台操作, 包括提取, 处理, 计算等), 通过渲染可以将两者结合在一起, 在视图函数中作为响应返回. **渲染的意思是, 将需要展示的数据嵌入到预先设定的模板中, 将结果返回给用户**.

本质上, 模板是提供了“占位符变量”的 html 页面文件, 用于渲染时填充数据. 

Flask 的一个核心功能是提供了 Jinja2 模板引擎 (注意不是模板), 对模板渲染提供了强大支持.

---

## Jinja2 之 **渲染方式**
Flask 默认在程序的 `templates` 子文件夹下搜索 html 模板. 假设有模板 `index.html 和 user.html`, 只有一个用户名变量, 模板渲染用法如下:
```python
from flask import render_template

# ...

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/user/<name>')
def user(name):
    return render_template('user.html', name=name)
```


## Jinja2 之 **变量**

jinja2 的占位符变量, 可以识别*所有的变量类型*并进行调用, 举例如下:
```html
<p>A value from a dictionary: {{ mydict['key'] }}.</p>
<p>A value from a list: {{ mylist[2] }}.</p>
<p>A value from a list, with a variable index: {{ mylist[a] }}.</p>
<p>A value from an object's method: {{ myObj.fun() }}.</p>
```


## Jinja2 之 **过滤器**

jinja2 提供了`过滤器`, 可以对变量进行一些特定的加工处理(比如大小写自动转换等), 这对数据显示的严谨性是很有必要的. Jinja2 提供完整的[过滤器列表](http://jinjw.pocoo.org/docs/templates/#builtin-filters). 过滤器的用法是“在占位符变量名后添加过滤器名, 中间用数线分隔”, 举例如下:
```python
Hello, {{ name|safe }}          # 渲染时不转义
Hello, {{ name|striptags }}     # 渲染前把 name 里的 html 标签删掉.
Hello, {{ name|capitalize }}    # 首字母大写
Hello, {{ name|lower }}         # 全部字母小写
Hello, {{ name|upper }}         # 全部字母大写
Hello, {{ name|trim }}          # 把 name 的首尾空格去掉
```

要特别强调 `safe 过滤器`的使用. 出于安全考虑, Jinja2 默认转义所有变量. 比如 `<h1>Hello</h1>` 会被渲染成 h1 元素. 如果需要在响应中显示这个变量的完整 html 代码, 可以用 `safe` 过滤器. 但是, 切记不要再不可信的值上使用 safe 过滤器, 比如用户在表单中填写的文本(鬼知道输入的是什么文本).


## Jinja2 之 **控制结构**

将数据渲染到模板可以认为是一个过程, 所以在模板中添加特定的*控制结构*可以改变渲染流程, 满足某些特定地渲染顺序. 条件控制(if-else)可以控制是否渲染某些内容, 循环控制(for)可以按照相同地方式渲染一组元素. 占位符变量用 **双大括号** 标记, *控制结构*和其他*执行语句*用 `{% ... %}` 标记. 举例如下:
```html
{% if user %}
    Hello, {{ user }}
{% else %}
    Hello, stranger.
{% endif %}
```

```html
<ul>
    {% for comment in comments %}
        <li>{{ comment }}</li>
    {% endfor %}
</ul>
```

* `模板宏`(macro) 类似于定义了一个函数, 导入后可重复调用(执行相同的渲染操作). 可以在模板中定义或单独存为文件通过导入进行调用.
```python
# 用法 1 -------------------------
{% macro  f(x) %}
    <li>{{ x }}</li>
{% endmacro %}

<ul>
{% for comment in comments %}
    {{ f(comment) }}
{% endfor %}
</ul>

# 用法 2 ---------------------
{% import 'macros.html' as macros %}

<ul>
{% for comment in comments %}
    {{ macros.f(comment) }}
{% endfor %}
</ul>
```

* **重复使用的模板片段**

如果在模板中有一些地方使用了完全相同的内容, 可以把这部分内容单独建立一个文件, 模板中需要这些内容的位置插入(include). 
```html
{% include 'common.html' %}
```

* **基模板**

如果有些模板使用了相同的布局结构, 可能只有局部细节不同, 可以把它们的基础结构单独写入文件, 这样其他模板都可以<emph style='border-bottom:1px dashed red'>继承</emph>这个基模板, 只需对局部细节进行修改即可.
```html
# base.html -------------------
<html>
<head>
    {% block head %}
        <title>{% block title %} {% endblock %} - My App</title>
    {% endblock %}
</head>

<body>
    {% block body %} {% endblock %}
</body>
</html>
```

```html
{% extends 'base.html' %}

{% block title %}Index{% endblock %}
{% block head %}
    {{ super() }}               # 继承原先的内容
    <style> </style>
{% endblock %}
{% block body %}
    <h1>Hello, World!</h1>
{% endblock %}
```

如果要在继承后的模板中重新定义基模板的 block, 需要在新定义的 block 中使用 `{{ super() }}` 保留原有内容, 然后才能添加自己需要的内容. `体会上面这个例子的 super()`.

## 关于模板的作用, 再多说一点

* **页面布局**: 可以按需要自己设计基模板, 但是具有观赏性的模板离不开 css 和 js. 可以直接继承一些发布出来的优秀模板框架, 如 [flask-bootstrap](06-flask-bootstrap.md).

* **网页表单**: 表单能用整洁的方式让用户输入内容, 自己当然再 html 模板中设计表单细节, 但是非常单调重复. 由于表单是一项广泛的功能, 有一些扩展能够用来高效地建立表单模板. [flask-wtf](06-flask-wtf.md).
