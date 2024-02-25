+++
title = "URL 和静态文件"
date = Date(2019, 01, 14)
icon = "python"
+++

## 使用修饰器定义 <emph style='border-bottom:1px dashed red'>外部路由</emph>
url 是通过 <emph style='border-bottom:1px dashed red'>`app.route` 修饰器</emph> 映射到视图函数的, 如下:
```
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return '<h1>Welcome</h1>'
```

很多时候 url 中包含 <span style='border-bottom:1px dashed red'>可变部分</span>, 就是需要将 url 的某部分当作参数进行处理. Flask 支持在修饰器中直接定义可变部分, 并将其传入视图函数, 如下：
```
@app.route('/user/<name>')
def user(name):
    return '<h1>Welcome, {0}'.format(name)</h1>
```
在调用视图函数的时候, flask 会将 `<name>` 作为参数传入. 动态参数默认类型为 <emph style='border-bottom:1px dashed red'>字符串</emph>, 也可以直接定义类型, 比如 `/user/<int:id>`, 这时这个函数只会响应整数动态. Flask 支持使用 `int, float, path` 类型, 其中 `path` 类型也是字符串, 但是将斜线视为动态片段的一部分, 不当作分隔符.

## 使用 `url_for(...)` 跳转到内部或外部链接, 文件路径 
页面内的跳转链接, 非常建议 <emph style='border-bottom:1px dashed red'>不要使用硬编码</emph> (不要直接使用链接的 url), 直接编写 url 会产生一些不必要的依赖关系, 不稳定, 也不利于后期更改. Flask提供了利用视图函数进行链接的方法, 利用 url_for('index') 即可定位到视图函数的路由, 避免了硬编码. 此外, url_for 函数可以接收一些可变参数作为路由中动态部分的参数, 也可以设置 url_for('index', _external=True) 得到浏览器外可以使用的绝对链接. 此外, url_for 也能将任何参数添加到生成的路由字符串中, 这个功能就十分灵活, 可以按需设置.
```
url_for('user', name='john', _external=True)   # http://localhost:5000/user/john
url_for('index', page=2)                       # /?page=2
```

url_for('static', file='css/styles.css', _external=False/True) 是路由软链接的另一个好处, 可以提供静态文件的位置, 这在使用图片, js, css 等文件的时候是很简洁有效的. 下面的例子可以使 `templates/base.html` 在浏览器的地址栏显示一个小图标.
```
{% block head %}
    {{ supper() }}       # 注意使用 super() 保留基模板的原始内容
    <link rel='shortcut icon' href='{{ url_for('static', filename='favicon.ico') }}' type='image/x-icon'>
    <link rel='icon'          href='{{ url_for('static', filename='favicon.ico') }}' type='image/x-icon'>
{% endblock %}
```

