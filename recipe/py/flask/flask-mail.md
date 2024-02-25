+++
title = "flask-mail"
date = Date(2019, 02, 02)
icon = "python"
+++


在特定事件发生时, 如果希望对用户进行提醒, 可以在程序中添加提示信息([flask消息](06-flask-wtf)), 也可以发送电子邮件. Python 提供了 `smtplib 标准库` 可以发送电子邮件, 但是这个库对 flask 不那么友好, 这里使用 <emph style='border-bottom:1px dashed red'>包装了 `smtplib` 的 flask 扩展 `flask-mail`</emph>.
> (virEnv) conda/pip install flask-mail

`flask-mail` 连接到 **简单邮件传输协议(Simple Mail Transfer Protocol, SMTP)** 服务器, 将邮件提交给这个服务器进行发送. `flask-mail` 默认使用 `localhost:25` 端口, 无需验证即可发送邮件. 为了使用 **外部 smtp 服务器** 发送邮件, 需要对 `smtp 服务器` 添加配置参数.
```
配置            默认值       说明
MAIL_SERVER     localhost   服务器主机名/ip地址
MAIL_PORT       25          邮件服务器端口
MAIL_USE_TLS    False       启用传输层安全(Transport Layer Security, TLS)协议
MAIL_USE_SSL    False       启用安全套接层(Secure Sockets Layer, SSL)协议
MAIL_USENAME    None        邮件账户用户名
MAIL_PASSWORD   None        邮件账户密码
```

下面是 <emph style='border:1px dashed red'>配置</emph> google gmail 账户的一个例子.
```
# hello.py
import os

app.config['MAIL_SERVER']   = 'smtp.googlemail.com'
app.config['MAIL_PORT']     = 587
app.config['MAIL_USE_TLS']  = True
app.config['MAIL_USERNAME'] = os.environ.get('MAIL_USERNAME')
app.config['MAIL_PASSWORD'] = os.environ.get('MAIL_PASSWORD')
```
最后两行是从系统环境中导入账户信息, 这是一个必要的习惯: 不能将敏感信息直接写入脚本中.
* Linux/Max OS 中写入账户信息
  >(virEnv) export MAIL_USERNAME = \<Gmail username>

  >(virEnv) export MAIL_PASSWORD = \<Gmail password>
* Win 中写入账户信息
  >(virEnv) set MAIL_USERNAME = \<Gmail username>

  >(virEnv) set MAIL_PASSWORD = \<Gmail password>


下面是 `flask-mail` <emph style='border:1px dashed red'>初始化</emph> 的例子.
```
from flask import Flask
from flask_mail import Mail

app = Flask(__name__)
mail = Mail(app)
```

下面在 `python-Shell` 中<emph style='border:1px dashed red'>测试</emph>邮件发送功能.
```
(virEnv)$ python hello.py shell
>>> from hello import mail
>>> from flask_email import Message
>>> msg = Message('test subject', sender='you@example.com',
                  recipients = ['you@example.com'])
>>> msg.body = 'test body'
>>> msg.html = '<b>HTML</b> body'
>>> with app.app_context():
        mail.send(msg)      # mail.send 用了 current_app, 所以在程序上下文中执行
```

下面在 `flask 项目中` <emph style='border:1px dashed red'>添加</emph> 邮件功能. 特定事件的提醒邮件的格式通常都是固定的, 所以更有条理的方式就是把邮件功能的**通用部分**封装到独立的函数中. 独立封装还有一个好处, 可以使用 `jinja2` 对 `msg` 的正文内容和通用模板进行渲染.

由于系统自动发送的邮件会有固定的模板, 较好的习惯是把这些模板抽象出来, 在`邮件发送函数`中调用特定模板进行渲染. <emph style='border-bottom:1px dashed red'>通常将邮件模板放在 `templates/mail/` 下面. 每个邮件模板要同名双份, 分别是 html 和 txt 格式, 用来渲染 `富文本正文` 和 `纯文本正文`.</emph> 另外, 由于不同邮件模板会对应不同的渲染参数, 在 `邮件发送函数` 中使用 `**kwargs` 作为`通配符参数` 来动态捕捉这些参数, 所以能够正常工作的 `邮件发送函数` 要求模板和传入通配符参数的内容相匹配.

下面是一个基本的 `邮件发送函数` 的定义
```
# hello.py
from flask_mail import Message

app.config['FLASK_MAIL_SUBJECT_PREFIX'] = '[Flasky]'
app.config['FLASK_MAIL_SENDER']         = 'Flasky Admin <flask@example.com>'

def send_mail(to, subject, template, **kwargs):
    msg = Message(app.config['FLASK_MAIL_SUBJECT_PREFIX'] + subject,
    sender=app.config['FLASK_MAIL_SENDER'],
    recipients = [to])
    msg.body = render_template(template + '.txt', **kwargs)
    msg.html = render_template(template + '.html', **kwargs)
    mail.send(msg)
```
`构造函数 Message(...) 的参数是邮件的头部, 包括邮件名, 发件人和收件人`. 这里面的 `msg.body` 和 `msg.html` 里的模板是没有扩展名, 所以建议邮件模板的纯文本和富文本文件有相同的文件名. 下面只需要在视图函数中合适的位置添加`条件判断和配置邮件`即可.
```
# hello.py
app.config['FLASK_ADMIN'] = os.environ.get('FLASK_ADMIN')

# def send_mail(...)

def index():
    from = NameForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.name.data).first()
        if user is None:
            db.session.add(user)
            session['known'] = False
            if app.config['FLASK_ADMIN']:
                # **kwargs 传入俩 user
                sender_mail(app.config['FLASK_ADMIN'], 'New User', 'mail/new_user', user=user)
            else:
                session['known'] = True
        session['name'] = form.name.data
        form.name.data = ''
        return redirect(url_for('index'))
    return render_template('index.html', form=form, name=session.get('name'), known=session.get('known'))
```
这里先判断了是否存在一个接收信息通知的邮箱地址 `FLASKY_ADMIN`, 这个和发件箱不必要相同. 因为可能需要对一般的观光用户发送邮件, 所以将系统的发件箱和收件箱的地址分开, 大概是一个不错的选择. 
>(virEnv) set FLASK_ADMIN = \<email-address>  # win

>(vieEnv) export FLASK_ADMIN = \<email-address> # linux/Mac os

# 提高邮件发送效率: 异步发送邮件(asynchronous)
`邮件发送函数 send_mail(...)` 在发送邮件的时候会停滞几秒, 大概就像浏览器突然无响应了一样. 为了避免这样的 **延迟**, 可以将 `send_mail(...)` 的最后一行 `mail.send(msg)` 移到后台线程中.
```
# hello.py
from threading import Thread

def send_async_email(app, msg):
    with app.app_context():
        mail.send(msg)

def send_mail(to, subject, template, **kwargs):
    msg = Message(app.config['FLASK_MAIL_SUBJECT_PREFIX] + subject, 
    sender=app.config['FLASKY_MAIL_SENDER'],
    recipients = [to])
    msg.body = render_template(template + '.txt', **kwargs)
    msg.html = render_template(template + '.html', **kwargs)

    thr = Thread(target=send_async_email, args([app, msg]))
    thr.start()
    return thr
```
这里定义的 `send_async_email(...)` 将 `mail.send(...)` 包装到了上下文中, 这是<emph style='border-bottom:1px dashed red'>因为很多 flask 扩展都假设已经存在激活的程序上下文和请求上下文, 异步发送邮件开启了新的县城, 所以要在其中引入 `app.app_context`.</emph>

目前异步发送邮件的方式已经流畅多了, 但是项目如果要发送大量邮件时, 使用专门发送邮件的作业会比给每封邮件都新建一个线程要更合适. 比如, 可以把 `send_async_email(...)` 函数发给 [Celery](http://www.celeryprojcct.org/) 任务队列.