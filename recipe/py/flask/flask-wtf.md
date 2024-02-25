+++
title = "flask-wtf"
date = Date(2019, 01, 19)
icon = "python"
+++

客户端发出的 `request` 包含了所有的请求信息, 其中 `request.form` 包含了 `POST` 提交的表单数据. 如果自己直接从 `request.form` 开始编写表单的 html 模板以及处理提交的表单数据, 不是简洁有效的方式, 有些任务很单调或重复. 由于表单是 html 模板的一个广泛功能, 当然有很好的扩展可以提供相应的功能. [WTForms](http://wtforms.simplecodes.com/) 包被包装成了 [flask-wtf](http://pythonhosted.org/Flask-WTF), 可以方便地集成到 flask 中.
>(virEnv) conda/pip install flask-wtf

在安装 `flask-wtf` 时会同时安装 `wtforms`, 前者提供了 <emph style='border-bottom:1px dashed red'>表单类 Form</emph>, 后者提供了表单中的各种<emph style='border-bottom:1px dashed red'>字段类</emph>和<emph style='border-bottom:1px dashed red'>验证函数</emph>.

要使用 flas-wtf 处理表单, 有三个事情要做:
1. 每个表单都要先定义成一个继承自 `表单类 flak_wtf.Form` 的表单类, 其中的<emph style='border-bottom:1px dashed red'>类变量</emph> 是 `wtforms` 库里面的字段类的实例化, 字段类在实例化的时候可以附带若干个需要的验证函数. 
2. 在视图函数中将表单类实例化, 对表单数据将进行逻辑操作.
3. 在 html 模板中给出表单的排版, 在视图函数渲染模板的时候记得把表单添上.

## 定义表单类
```
# webForms.py 
from flask_wtf import Form
from wtforms import StringField, SubmitField
from wtforms.validators import Required

class NameForm(Form):
    name = StringField('What is your name?', validators=[Required()])
    submit = SubmitField('Submit')
```
这个例子包含了 `表单类 Form`, 字段类 `StringField, SubmitField` 和验证函数 `Required`. `wtforms` 支持 17 个字段类, `wtforms.validators` 内建了 11 个验证函数, 分别列在下面.
```
# wtforms 支持的 html 标准字段
StringField             文本
TextAreaField           多行文本
PasswordField           密码文本
HiddenField             隐藏文本
DateField               文本, 值为 datatime.date 格式
DateTimeField           文本, 值为 datetime.datetime 格式
IntegerField            文本, 整数
DecimalField            文本, decimal.Decimal
FloatField              文本, 浮点数

BooleanField            复选框, True/False
RadioField              一组单选框
SelectField             下拉列表
SelectMultipleField     下拉lxbc, 可选多个值

FileField               文件上传
SubmitField             表单提交按钮
FormField               把表单当作字段嵌入另一个表单

FieldList               一组指定类型的字段
```
```
# wtforms.validators 的验证函数
Email                   验证邮件地址
EqualTo                 比较两个字段值(如要求两次输入密码进行确认)
IPAddress               ipv4 地址
Length                  输入字符串长度
NumberRange             限制输入范围
Optional                无输入值时跳过其他验证函数
Required                确保不为空
Regexp                  正则表达式
URL                      
AnyOf                   输入值在可选值列表中
NoneOf                  输入值不在可选值列表中
```

## html 模板中快速渲染表单
表单的字段在 html 模板中是可以用的, 但是在 html 中逐个编写字段的布局格式的工作量是巨大的. 可以尝试使用 flask-bootstrap 提供的辅助函数, 可以按照预先定义的表单样式, 一下子就渲染整个 flask-wtf 表单, 如下
```
# index.html 模板文件
{{% import 'bootstrap/wtf.html' as wtf %}}

{% block page_content %}
<div class='page-header'>
    <h1>Hello, {% if name %}{{ name }} {% else %}{{ Stranger }}{% endif %}~</h1>
</div>
{{ wtf.quick_form(form) }}   # 在需要渲染表格的 block 合适位置上调用
{% endblock %}
```

## 视图函数中定义表单的业务逻辑
要强调的是, 表单是为了给用户提供更加友好的展示方式, 我们的目的仍然是<emph style='border-bottom:1px dashed red'>接收表单中的数据</emph>, 所以在视图函数中, 要做的事情有两项:
1. 渲染表单
2. 表单提交后的数据处理逻辑

下面是一个初等的例子(有缺陷), 注意这个例子有三个地方:
* 修饰器中添加了 `methods` 参数, 没有这个参数的话默认只有 `GET` 方法.
* 视图函数中添加了 `if` 判断, 给出来提交表单后的数据操作
* 渲染 html 模板时, 要添加表单作为参数
```
# hello.py 
from webForms import NameForm

#...

@app.route('/', methods=['GET', 'POST'])   # 注意添加了 methods
def index():
    name = None
    form = NameForm()
    if form.validate_on_submit():
        name = form.name.data
        form.name.data = ''
    return render_template('index.html', form=form, name=name)
```

上面例子的缺陷是<emph style='border-bottom:1px dashed red'>提交表单后, 如果刷新浏览器, 会出现警告</emph>, 这是因为视图函数执行完提交表单的 `if` 操作后, 刷新页面会重新发送之前发送过的最后一个请求, 这个请求中包含表单数据的 `POST` 请求时, 刷新页面会再次提交这个表单. 多数情况下需要规避这样的处理方式. <emph style='border-bottom:1px dashed red'>更好的处理方式是 `重定向`, 只需要在 `if` 的最后添加上 `return redirect(url_for('index'))`, 就能在处理完提交的表单后定向一个不带有 `POST` 表单的视图函数</emph>. 

另一个问题是, 上面例子中 `form.name.data` 在重定向后就丢失了, 但是我们往往在重定向后也需要用到这个数据. <emph style='border-bottom:1px dashed red'>解决方法是使用 `session` 来保存表单中提交的数据</emph>, 这样直到用户和服务器的连接结束之前都能从 `session` 中使用这个数据.
```
# hello.py
from flask import Flask, render_template, session, redirect, url_for
from webForms import NameForm

#...

@app.route('/', methods=['GET', 'POST'])
def index():
    form = NameForm()
    if form.validate_on_submit():
        session['name'] = form.name.data
        return redirect(url_for('index'))
    return render_template('index.html', form=form, name=session.get('name'))
```
这里的 `if` 块里面就比上面有缺陷的例子简单了很多, 只需要保存好 `form.name.data` 数据, 不需要重置表单中的数据, 只要重定向到新的 `index` 视图就好了. 在最后一行的渲染中中, 用 `sesion` 调用数据即可.

# 补充一个 Flask 自带的 <emph style='border:1px dashed red'>核心特性</emph>: `Flask 消息`
这个是 Flask 自带的核心功能, 不是其他扩展的功能. 在某些情况下, 有必要让用户知道状态发生了变化, 可以使用 `消息确认, 警告, 错误提醒` 等. 比如, 用户提交的表单中某些信息不符合要求, 服务器返回的响应重新渲染了表单要用户重新填写, 同时可以在页面上显示一个提示消息, 告诉用户哪里出了问题. 比如, 用户发表了评论或者点赞了, 服务器可以在收到这些操作后, 显示一个提醒消息告诉用户做了这些操作.

具体地, 在<emph style='border-bottom:1px dashed red'>视图函数中, 可以添加</emph>相应地判断语句, 在满足特定条件时, 给出对应的提醒信息. 在 <emph style='border-bottom:1px dashed red'>html 模板中, 将渲染消息的代码放在合适的位置上</emph>.
```
# hello.py
from flask import Flask, rendder_template, session, redirect, url_for, flask

#...

@app.route('/', methods=['GET', 'POST'])
def index():
    form = NameForm()
    if form.validate_on_submit():
        old_name = session.get('name')  # 没有这个值会返回 None
        if old_name is not None and old_name != form.name.data:
            flash('Looks like you have changed your name!')
        session['name'] = form.name.data
        return redirect(url_for('index))
    return render_template('index.html', form=form, name=session.get('name'))
```
```
# flask 对 html 模板开放了 get_flashed_messages() 函数, 获取信息
# templates/base.html
{% block content %}
<div class='container'>
    {% for message in get_flashed_messages() %}
    <div class='alert alert-warning'>
        <button type='button' class='close' data-dismiss='alert'>&times;</button>
        {{ message }}
    </div>
    {% endfor %}

    {% block page_content %} {% endblock %}
</div>
{% endblock %}
```

在模板中使用循环, 是因为之前的 `请求-响应` 循环可能多次调用 `flash()` 生成了消息, 所以可能有多个消息在排队等待显示. `get_flashed_message()` 获取的消息在下次调用时不会返回, 所以每个消息只显示一次就消失了.

## 写在最后
多数时候都希望从 web 表单中获取的数据能够保存下来(如果只是用过即丢的信息就不用保存了), 所以表单往往都配合数据库使用.