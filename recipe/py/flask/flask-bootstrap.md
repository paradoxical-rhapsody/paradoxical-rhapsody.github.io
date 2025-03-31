+++
title = "flask-bootstrap"
date = Date(2019, 01, 18)
icon = "python"
+++

[Bootstrap](http://getbootstrap.com) 是 Twitter 开发的开源框架, 能创建整洁且富有吸引力的网页, 兼容所有现代浏览器. 扩展 Flask-Bootstrap 将这个框架的几个模板集成到了 Flask, 易于使用. 这个扩展提供了 Bootstrap 所有的 CSS 和 JavaScript 文件. Bootstrap 的官网提供了很多可以直接复制粘贴的示例. <emph style='border-bottom:1px dashed red'>如果要自己使用其他模板, 可能需要对模板进行必要的改动.</emph>

>(virEnv) conda/pip install flask-bootstrap

习惯上, Flask 扩展在创建 Flask 对象时就进行实例化. 
```
from Flask import Flask
from falsk_bootstrap import Bootstrap

app = Flask(__name__)
bootstrap = Bootstrap(app)
```

## 从 bootstrap/base.html 继承自己的<emph style='border-bottom:1px dashed red'>基模板</emph>
```
# templates/base.html --------------------
{% extends "bootstrap/base.html" %}

{% block title %}xu-zc{% endblock %}
{% block navbar %}
    <div class='navbar navbar-inverse' role='navigation'>
        <div class='navbar-header'>
            <button type='button' class='navbar-toggle' data-toggle='collapse' data-target='.navbar-collapse'>
                <span class='sr-only'>Toggle navigation</span>
                <span class='icon-bar'></span>
                <span class='icon-bar'></span>
                <span class='icon-bar'></span>
            </button>
            <a class='navbar-brand' href='/'>Z.C.</a>
        </div>
        <div class='navbar-collapse collapse'>
            <ul class='nav navbar-nav'>
                <li><a href='/'>Home</a></li>
            </ul>
        </div>
    </div>
{% endblock %}

{% block content %}
    <div class='container'>
        {% block page_conteng %} {% endblock %}
    </div>
{% endblock %}
```
这个扩展模板中, `navbar` 块使用 <emph style='border-bottom:1px dashed red'>Bootstrap 的组件</emph> 定义了一个简洁的导航条. 

`bootstrap/base.html` 定义了许多其他的块, 都可以根据需要继承. 要注意的是, 有些块是 flask-bootstrap 自用的, 在继承时需要先使用 Jinja2 提供的 `super()` 继承已有内容(不是所有块都这样), 然后才能添加新内容(如 `scripts` 和 `styles` 块). `bootstrap/base.html` 定义的块如下:
```
doc              整个 html 文档
html_attribs     <html> 属性
html             <html> 内容
head             <head> 内容
title            <title> 内容
metas            一组 meta 标签
styles           层叠样式表定义
body_attribs     <body> 属性
body             <body> 内容
navbar           用户定义的导航条
content          用户定义的内容
scripts          文档底部的 JavaScripts 声明
```
```
{% block scripts %}
    {{ super() }}
    <script type='text/javascript' src='my-script.js> </script>
{% endblock %}
```

## 自定义错误页面
如果使用了上面继承得到的 `base.html` 模板, 有必要用这个模板重定义错误页面. 因为默认的错误页面太简单平庸, 而且和自定义的模板差距太大.

最常见的错误码由 404(请求页面或路由是未知的) 和 500(有未处理的异常), 对它们指定的处理方式如下:
```
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def page_not_found(e):
    return render_template('500.html'), 500
```

为了保持错误处理的页面与常规页面有相同布局, 可以直接从上面的 `templates/base.html` 继承 404 和 500 错误页面. 示例如下:
```
# tempaltes/404.html
{% extends 'base.html' %}

{% block title %}xu-zc - Page Not Found{% endblock %}
{% block page_conteng %}
    <div class='page-header'>
        <h1>Nor Found.</h1>
    </div>
{% endblock %}
```

类似的继承方式可以用于其他使用 `templates/base.html` 格式的页面, 比如
```
# tempaltes/user.html
{% extends 'base.html' %}

{% block title %}xu-zc{% endblock %}
{% block page_conteng %}
    <div class='page-header'>
        <h1>Hello, {{ user }}.</h1>
    </div>
{% endblock %}
```
