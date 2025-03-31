+++
title = "Overview"
date = Date(2019, 03, 23)
icon = "python"
+++



# 大型程序的结构
### 这是返回来写在前面的话

当项目结构复杂、功能强大的时候, 需要对程序进行分割, 便于更好地理解和维护. 只要能够使得参与者能够快速理解项目结构, 就是好的分割. 

这里通过模块来组织程序功能, 如下:
```
|-xzcSite/
  |-app/
    |-__init__.py            # 工厂函数
    |-templates/             # html/email 模板文件
    |-static/
    |-email.py               # 邮件发送函数
    |-models.py              # 数据库类
    |-main/
      |-__init__.py          # 主页蓝本
      |-forms.py             # 主页的表单类
      |-errors.py            # 错误处理的视图函数
      |-views.py             # 路由+视图函数
    |-login/
      |-__init__.py          # 用户认证蓝本
      |-forms.py
      |-errors.py
      |-views.py
  |-migrations/
  |-tests/
    |-__init__.py
    |-test*.py
  |-venv/
  |-requirements.txt
  |-config.py                # 配置类
  |-manage.py                # 项目的启动脚本与数据库迁移
```
`main` 模块包含主页的相关功能, `login` 包含了用户认证的功能. 如果其他功能复杂到足够独立成模块, 可以在 `app` 下添加新的文件夹. 这里发送邮件的功能没有复杂到需要用模块, 所以只用了一个 `email.py` 文件.


## 配置不同的项目环境
下面是一个相当清晰的 `config.py` 结构, 其中包含了通用配置类, 由此继承出的子类包含多种配置. 为了安全, 某些配置需要从环境变量中导入, 但是系统也添加了默认值, 防止环境中没有定义. <emph style='border-bottom:1px solid red'>通用配置类中定义了 `init_app()` 静态方法, 可以对项目实例进行初始化</emph>. <emph style='border-bottom:1px solid red'>`config.py` 的最后, 用一个字典 `config` 注册了不同的配置环境, 还注册了一个默认环境(开发环境), 其中每个值是各个配置类(class), 不是字符串!!!</emph>
```
# config.py
import os
baseDir = os.path.abspath(os.path.dirname(__file__))

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'hard to guess string'
    SQLALCHEMY_COMMIT_ON_TEARDOWN = True
    FLASK_MAIL_SUBJECT_PREFIX = '[From xzc]'
    FLASK_MAIL_SENDER = 'xu-zc <xzcdyx@uuu.cn>'
    FLASK_ADMIN = os.environ.get('FLASK_ADMIN')

    @staticmethod
    def init_app(app):
        pass

class DevelogmentConfig(Config):
    DEBUG = True
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    SQLALCHEMY_DATABASE_URI = os.environ.get('DEV_DATABASE_URL') or \
        'sqlite:///' + os.path.join(baseDir, 'data-dev.sqlite)

class TestingConfig(Config):
    TESTING = True
    SQLALCHEMY_DATABASE_URI = os.environ.get('TEST_DATABASE_URL') or \
        'sqlite:///' + os.path.join(baseDir, 'data-test.sqlite')

class ProductionConfig(Config):
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
        'sqlite:///' + os.environ.get(baseDir, 'data.sqlite')
    
config = {
    'development': DevelopmentConfig,
    'testing': TestingConfig,
    'production': ProductionConfig,

    'default': DevelopmentConfig
}
```

## Application Factory(工厂函数)
如果不考虑使用结构化程序, 将所有的代码定义在一个文件中, 就要在程序最开始就对项目进行实例化, 然后将实例化的项目进行各种扩展的包装. 这时候由于项目是在全局作用域中被创建, 项目在程序运行时就被创建了, 所以不能再动态修改配置了.

工厂函数给出了一种解决方案: 在 `app` 模块的构造文件 `__init__.py` 中将项目实例化过程定义成可显式调用的函数, 接受一个配置参数. 这种方式可以给按照配置进行实例化, 也能用来创建多个项目实例.

工厂函数先导入用到的 flask-ext, 并创建 **空的扩展对象**. 在定义的项目实例化函数中, 利用 **配置类** 的静态方法来创建相应的项目实例, 然后利用这个项目实例对空的扩展对象进行初始化.
```
# app/__inti__.py
from flask import Flask, render_template
from falsk_bootstrap import Bootstrap
from flask_mail import Mail
from flask_moment import Moment
from flask_sqlalchemy import SQLAlchemy
from config import config

bootstrap = Bootstrap()
mail = Mail()
moment = Moment()
db = SQLAlchemy()

def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    config[config_name].init_app(app)

    boostrap.init_app(app)
    mail.init_app(app)
    moment.init_app(app)
    db.init_app(app)

    # 导入和注册用到的蓝本(路由和错误处理)

    return app
```

## 蓝本(blueprint)
单个文件中的路由和错误处理是直接通过全局作用域的项目实例的修饰器`app.route(...)` 和 `app.errorhandel(...)` 定义的. 当项目实例按照上述方式在调用实例化函数的时候才创建的话, 此时定义路由和错误处理就来不及了. 

解决方案是将路由和错误处理定义到蓝本中. 蓝本中的路由默认是休眠的, 只有将其注册到上面的工厂函数 `create_app(...)` 中, 蓝本上的路由才会和项目产生联系. 从蓝本的功能上看, 可以将其定义在单个文件中, 但是我们用模块来设计蓝本可以把项目组织的更清晰. 

<emph style='border-bottom:1px solid red'>更直观地说, 我们可以把整个项目分割成一些子功能, 每个子功能都对应一些视图函数、页面和一些逻辑函数, 我们可以把子功能写成一个模块, 在模块的构造文件 `__init__.py` 中定义和保存蓝本, 在视图函数中用这个蓝本来定义路由, 然后只需要将这个蓝本注册到工厂函数中, 蓝本对应的子功能就成为了项目的一部分.</emph> 所以完整的蓝本模块就是一个完整的子功能框架.

`main` 模块定义了项目的主页的相关功能, 下面用这个模块来说明蓝本的相关细节.
```
# app/main/__init__.py
from flask import Blueprint

main = Blueprint('main', __name__)

from . import views, errors
```
第二行实例化了 `Blueprint` 类创建了蓝本对象. <emph style='border-bottom:1px solid red'>构造函数必须指定两个参数: 蓝本名字和蓝本所在的模块</emph>. 蓝本的名字按自己的习惯命名即可, **第二个参数使用 python 的 `__name__` 变量即可**.

第三行导入了 `app/main/views.py` 的路由和 `app/main/errors.py` 中的错误处理. <emph style='border:1px dashed red'>这一行是必要的, 导入这两个文件就能把路由和错误处理与蓝本关联起来</emph>. 要注意的是, 这一行要放在 `app/main/__init__.py` 的末尾导入, 这是为了避免循环导入依赖, 在这个文件中定义的 `main` 不依赖 `views.py` 和 `errors.py` 的内容, 这两个文件倒是要依赖 `main` 对象, 所以在次序上需要先定义 `main`, 再引入这两个文件. **导入这两个文件是为了把它们和蓝本关联起来.**

下面是 `把蓝本注册到工厂函数`、`蓝本的视图函数`、`错误处理` 三项内容.
```
# app/__inti__.py
def create_app(config_name):
    #...

    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app
```

```
# app/main/errors.py
from flask import render_template
from . import main
@main.app_errorhandle(404)
def page_not_found(e):
    return render_template('404.html'), 404

@main.app_errorhandle(500)
def inter_server_error(e):
    return render_template('500.html'), 500
```

```
# app/main/views.py
from datetime import datetime
from flask import render_template, session, redirect, url_for

from . import main
from .forms mport NameForm
from .. import db
from ..models import User

@main.route('/', methods=['GET', 'POST'])
def index():
    form = NameForm()
    if form.validate_on_submit():
        #...
        return redirect(url_for('.index'))
    return render_template('index.html',form=from, name=session.get('name'), known=session.get('known', false), current_time=datetime.utcnow())
```
这里有三个细节需要说明:
* `app/main/views.py` 中导入了当前模块对象、当前模块的文件中的对象、上一级模块对象, 注意这样的调用方式.
* 路由的修饰器由蓝本提供, 所以这里是 `main.route(...)`.
* `url_for(...)` 的第一个参数应该是视图函数名称. 在单文件项目中直接写视图函数就行, 在蓝本中不能这样. 项目会给蓝本的路由全部加上命名空间, 这样可以在不同的蓝本中使用相同的视图函数名称, 不会产生冲突. 命名空间就是蓝本的名字. 所以这里返回的就是 `url_for('main.index')`. 这里使用 `url_for('.index')` 是 `url_for()` 提供的简写形式, 当前蓝本中可以省略蓝本名字. <emph style='border-bottom:1px solid red'>注意, 跨蓝本的重定向必须使用带蓝本名称的视图函数名</emph>.

## 启动脚本: `manage.py`
顶级文件夹中的 `manage.py` 用于管理项目启动. 下面这段脚本先创建项目实例, 如果环境变量中定义了项目配置, 则从中读取配置名, 否则使用默认配置. 然后初始化 `flask-script`, `flask-migrate` 和 `python shell` 的上下文.

```
# manage.py
import os
from app import create_app, db
from app.models import User, Role
from flask_script import Manage, Shell
from flask_migrate import Migrate, MigrateCommand

app = create_app(os.getenv('FLASK_CONFIG') or 'default')
manage = Manage(app)
migrte = Migrate(app, db)

def make_shell_context():
    return dict(app=app, db=db, User=User, Role=Role)

manager.add_command('shell', Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)

if __name__ == '__main__':
    manager.run()
```

## requirements.txt
> (virEnv) pip freeze > requirements.txt

> (virEnv) pip install -r -requirements.txt

