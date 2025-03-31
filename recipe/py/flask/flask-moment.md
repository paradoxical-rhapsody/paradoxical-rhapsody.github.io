+++
title = "flask-moment"
date = Date(2019, 01, 15)
icon = "python"
+++


这个扩展包装了 JavaScript 开发的一个 [`moment.js`](http://momentjs.com/), 可以在浏览器中按照用户电脑的时区和区域对 **世界协调时(Coordinated Universal Time, UTC)** 进行渲染.
>(virEnv) conda/pip install flask-moment

## 初始化
```
from flask-moment import Moment
moment = Moment(app)
```

## 在 templates/base.html 中引入 moment.js 库
注意, 除了 `moment.js` 外, flask-moment 还依赖 `jquery.js`. 要在 html 的某个地方引入这两个库, 可以直接引入, 可以同时选择使用哪个版本, 也能使用扩展提供的辅助函数. flask-bootstrap 已经引入了 `jquery.js`. 在模板中引入 js 库的方式就是将其添加到 `scripts` 块中.

这需要用到 `bootstraps/base.html` 的 `scripts` 块, 在继承这个块时需要用 `super()` 保留原有引入的 js 库.
```
{% block scripts %}
    {{ super() }}
    {{ moment.include_moment() }}
{% endblock %}
```

## 用法
`flask-moment` 对模板开放了 `moment` 类, 因此可以在模板的占位符变量里对这个类进行实例化, 并进行需要的操作. <emph style='border-bottom:1px dashed red'>类的实例化需要提供初始化参数, `moment` 假定初始化参数是纯正的 `datatime` 对象(navie time, 不包含时区的时间戳), 并且使用 UTC 表示.</span> 在视图函数渲染时将时间戳作为参数提供给模板, 模板里通过 `moment` 类进行实例化. 下面是一个例子.
```
# 模板 templates/index.html 使用 moment 类
<p>The local date and time is {{ moment(cur_time).format('LLL') }}.</p>
<p>That was {{ moment(cur_time).fromNow(refresh=True) }}.</p>

# 视图函数渲染时提供初始化参数 cur_time
from datetime import datetime

@app.route('/')
def index():
    return render_template('index.html', cur_time=datetime.utcnow())
```

## 多余一句话
flask-moment 实现了 moment.js 中的 `format(), fromNow(), fromTime(), calendar(), valueOf(), univ()` 方法. 关于时间显示格式的 `format()` 方法, 可以查看 moment.js 的全部格式化选项([阅读](http://momentjs.com/docs/#/displaying/))

另外, `flask-moment` 支持时间戳的显示语言风格的本地化, 在 `scripts` 块中引入 moment.js 时添加这个设定即可, 例如
```html
{{ moment.lang('es') }}
```
