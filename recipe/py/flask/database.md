+++
title = "数据库"
date = Date(2020, 07, 09)
icon = "python"
+++


不同类型的数据库有各自的优势和缺陷, 对中小型程序来说, 它们的性能区别不大. 这里以 [flask-sqlalchemy](http://pythonhosted.org/Flask-SQLAlchemy/) 扩展为例, 它对数据库**框架** [SQLAlchemy](http://www.sqlalchemy.org/) 进行包装, **支持多种数据库后台**, 比如 MySQL, Postgres, SQLite. 这些数据库**引擎**的 URL 格式是不同的.
>(virEnv) conda/pip install flask-sqlalchemy

```
MySQL               mysql://username:password@hostname/database
Postgres            postgresql://username:password@hostname/database
SQLite(Univ)        sqlite:///absolute/path/to/database
SQLite(Windows)     sqlite:///c:/absolute/path/to/database
```
这些 URL 中, MySQL 和 Postgres 里面的 `hostname` 是数据库所在的主机名(可以是本地主机 `localhost` 或远程服务器). 由于主机上可以**托管多个数据库**, 所以 `database` 是要用的数据库名字. `username` 和 `password` 是数据库的用户名和密码.

<emph style='border-bottom:1px dashed red'>`SQLite` 是 python 自带的一个小型开源数据库引擎, 不需要使用服务器, 所以不需要指定 `hostname` 和 `password`, URL 里面的 `database` 是硬盘上的数据库文件名.</emph>

程序使用的数据库的 URL **必须**保存到 flask 的配置对象的 `SQLALCHEMY_DATABASE_URI` 键中(最后是 `URI` 不是 `URL`). 另外, 还有一个配置选项 `SQLALCHEMY_COMMIT_ON_TEARDOWN`, 将其设为 `True` 时, 每次请求结束后都回自动提交数据库中大的变量. 其他配置选项可参考 `flask-sqlalchemy` 的文档.

`flask-sqlalchemy` 的实例化和配置如下
```
# hello.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

baseDir = os.path.abspath(os.path.dirname(__name__))

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = \
    `sqllite:///` + os.path.join(basiDir, 'data.sqlite')
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True

db = SQLAlchemy(app)
```
实例化对象 `db` 表示程序使用的数据库, <emph style='border-bottom:1px dashed red'>它有 flask-sqlalchemy 提供的所有功能</emph>.

## flask-sqlalchemy 的用法
数据库的每个表都对应一个继承自 `db.Model` 的 python 类. 表与表之间的联结关系也定义在表类中(既可通过外键联结, 也可通过反向引用添加更好用的功能).

在 shell 中创建数据库表之后, 对数据库的操作通常是定义在视图函数中(添加, 修改, 删除, 查询), 在 html 模板中可以通过更友好的方式跟用户进行交互.

数据表的更新是不方便的, 需要用 `flask-migrate` 实现迁移功能.

## 定义表格类
假设有两个数据表 `roles` 和 `users`, 各自有自己的 `id` 和 `roleName/userName`, 每个 `user` 都有一个 `role` 属性.
```
# hello.py
class Role(db.Model):
    __tablename__ = 'roles'
    id = db.Column(db.Integer, primary_key=True)
    roleName = db.Column(db.String(64), unique=True)

    def __repr__(self):
        return '<Role {0}>'.format(self.name)

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    userName = db.Column(db.String(64), unique=True, index=True)
```
* `__tablename__` 是表名, 如果没有指定, 程序会自动生成一个名字(但是没有复数).
* 由于每个表都要定义一个**主键**, 通常命名为 `id`. 在利用表类进行实例化的时候, 新建对象的 `id` 不需要显式指定, 因为主键是由 flask-sqlalchemy 自动管理的.
* `db.Column` 类的构造函数的第一个参数是这一类的数据属性类型, 这些类型比 python 的类型更加细致. 下面是数据库的属性类型与 python 数据类型的对应关系. 
  ```
  Integer       int                 整数(32位)
  SmallInteger  int                 整数(16位)
  BigInteger    int/long            整数(不限精度)
  Float         float               浮点数
  Numeric       decimal.Decimal     定点数
  String        str                 变长字符串
  Text          str                 变长字符串(优化了长字符串)
  Unicode       unicode             变长unicode字符串
  UnicodeText   unicode             变长unicode字符串(优化了长串)
  Boolean       bool                布尔
  Date          datetime.date       日期
  Time          datetime.time       时间
  DateTime      datetime.datetime   日期和时间
  Interval      datetime.timedelta  时间间隔
  Enum          str                 一组字符串
  PickleType    任意 py 对象        自动使用 pickle 序列化
  LargeBinary   str                 二进制文件
  ```
* `db.Column` 有一些配置选项, 如下
  ```
  primary_key   主键列设为True
  unique        不允许重复值要设为True
  index         创建索引可以提升查询效率(True)
  nullable      允许使用空值(True)
  default       定义默认值
  ```
* `__repr__()` 方法定义了 `print` 数据时的显示内容.

## 关系
表单类的联结关系也是在表单类里面定义的.
```
# hello.py
class Role(db.Model):
    #...
    users = db.relationship('User', backref='role')

class User(db.Model):
    #...
    roleId = db.Column(db.Integer, db.ForeignKey('role.id'))
```
* `roleId` 被定义为外键, 参数 `role.id` 表明这一列的取值是 `roles` 表格中的 `id` 的值, 不是具体的 `roleName`.
* `db.relationship` 对每个 `Role` 对象都添加了一个**属性变量**, 它可以返回与这个 `Role` 对象相关联的所有用户组成的**列表**. <emph style='border-bottom:1px dashed red'>第一个参数表示联结的是哪个模型</emph>. 参数 `backref` 会在联结的模型 `User` 中额外添加一个 `role` 属性(添加到 `User` 中), 可以代替 `roleId` 访问 `Role` 模型, 对应的是整个 `Role` 对象, `roleId` 只对应外键的值.
* `db.relationship` 可以自行找到关系中的外键, 但是如果 `User` 中用了 `Role` 的两列分别定义了外键, 就需要认位设置想要作为关系的外键. `db.relationship` 有一些常用的配置选项如下.
  ```
  backref       在关系的另一个模型中添加反向引用
  primaryjoin   明确指明联结条件(模棱两可的关系中使用)
  lazy          如何加载相关的记录(select/immediate/joined/subquery/noload/dynamic)
  uselist       设为False不使用列表, 使用标量值
  order_by      指定排序方式
  secondary     多对多关系中的关系表的名字
  secondaryjoin 多对多关系的二级联结条件
  ```
  上面的例子是`一对多`关系. 在`一对一`关系中, 要将 `uselist` 设为 `False`. `多对一`只需要将外键和`db.relationship`都放在`多`这一侧就可以了. `多对多`中要用到第三张表(`关系表`).

## 数据库操作
数据库表类的操作对象是表的每一行(对应一条记录), 包括创建数据表, 对行进行**添加/修改/删除/查询**. <emph style='border-bottom:1px dashed red'>在创建数据表之后, 对记录的 `添加/修改/删除` 都与 git 版本控制的操作类似, `添加/修改` 都需要先 `add` 再 `commit`, `删除` 需要 `commit`.</emph>
* 创建表
```bash
(virEnv)$ python hello.py shell
>>> from hello import db
>>> db.create_all()    # 创建数据库表
>>> db.drop_all()      # 删除数据库表
```

创建数据表之后, 会在前面设置的 URL 路径下生成一个 sqlite 文件, 文件名就是在配置中指定的. 如果数据表已经在数据库中存在了, 那么 `db.create_all()` 不会重新创建或者更新这个表. 

* 添加记录
```bash
>>> from hello import Role, User
>>> adminRole = Role(roleName='Admin')   # role 1
>>> modRole = Role(roleName='Moderator')  # role 2
>>> userRole = Role(roleName='User')     # role 3
>>> userJohn = User(userName='john', role=adminRole)  # user 1
>>> userSusan = Usser(userName='susan', role=userRole)  # user 2
>>> userDavid = User(username='david', role=userRole)  # user 3
```

但是此时只是在 python shell 中创建了对象, 还没有将其写入数据库中, 所以 `print` 它们的时候是没有显示的.
```bash
>>> print(adminRole.id)   # None
```

上面创建的记录需要通过数据库 `会话` 添加到数据库中, flask-sqlalchemy 的会话通过 `db.session` 控制. 改动操作如下
```bash
>>> db.session.add(adminRole)
>>> db.session.add(modRole)
>>> db.session.add(userRole)
>>> db.session.add(userJohn)
>>> db.session.add(userSusan)
>>> db.session.add(userDavid)
```

可以将这些添加对象的操作一次性完成, 如下. 此时如果发生了错误, 整个添加操作都会失效, 不会发生只改动了一部分的情况, 这可以避免数据库更新的不一致性.
  > `>>> db.session.add_all([adminRole, modRole, userRole, userJohn, userSusan, userDavid])`

  然后将添加的对象 `提交` 到会话
  > `>>> db.session.commit()`

  此时就可以 `print` 记录的 `id` 属性了
  > `>>> print(adminRole.id)`   # 1

  另外, 数据库也可以 `回滚`
  > `>>> db.session.rollback()`

* 修改记录
  对记录进行修改之后, 也需要重新 `add` 和 `commit`.
  > `>>> adminRole.roleName = Administrator`

  > `>>> db.session.add(adminRole)`

  > `>>> db.session.commit()`

* 删除记录
  对某个记录删除之后, 也要 `commit`.
  > `>>> db.session.delete(modRole)`

  > `>>> db.session.commit()`

* 查询记录
  这是数据库最常用的操作. `查询` 操作是直接<emph style='border-bottom:1px dashed red'>用表单类调用 `query` 函数完成的</emph>.
  > `>>> Role.query.all()`   # 用 Role 类

  > `>>> User.query.all()`

  使用 `过滤器` 可以精确查找满足某些条件的记录.
  > `>>> User.query.filter_by(role=userRole).all()`

  <emph style='border:1px dashed red'>补充一句: 这样的 `query` 语句可以导出成原生的 SQL 查询语句</emph>
  > `>>> str(User.query.filter_by(role=userRole))`

  另外, `User.query.filter_by().all()` 里面, 对 `filter_by()` 和 `all()` 详细说明如下. 
  * `User.query` 和 `User.query.filte_by()` 都是得到一个 `查询`, 它不包括查询得到的记录.
  * `all()` 才会 `执行查询`,将 `查询记录` 用列表格式返回, 这才得到了想要的结果.
  `过滤器` 和 `执行查询` 的相关方法如下
  ```
  # 过滤器
  filter()          原查询上添加过滤器, 返回新查询
  filter_by()       原查询上添加等值过滤器, 返回新查询
  limit()           限制原查询的返回结果数量, 返回新查询
  offset()          偏移原查询的结果, 返回新查询
  order_by()        根据指定条件对原查询排序, 返回新查询
  group_by()        根据指定条件对原查询分组, 返回新查询
  ```
  由于添加过滤器之后仍然返回查询, 所以这些过滤器应该是可以链式使用的.
  ```
  # 执行查询
  all()             返回所有查询结果, 【列表】格式
  first()           返回查询第一个结果. 没有结果则返回 None
  first_or_404()    返回查询第一个结果. 没有结果则返回 404 
  get()             返回主键对应的行. 没有则返回 None
  get_or_404()      返回主键对应的行. 没有则返回 404
  count()           返回查询结果的数量
  paginate()        返回 paginate 对象, 包含指定范围的结果
  ```

  上面利用 `role` 作为过滤器的结果, 跟通过 `关系` 的到的结果是一样的, 而且使用 `关系` 的操作更加简洁.
  > `>>> users = userRole.users`
  
  > `>>> users`   # 打印所有 role=userRole 的 user

  这里的一个问题是, 使用 `关系` 的时候不能使用过滤器, 因为 `userRole.users` 会隐含地调用 `all()` 返回一个用户列表, `query` 对象是隐藏的, 所以无法指定精确的查询过滤器. 以上面这个为例, 更友好的方式是将用户列表按照字母顺序排列. 为了使用过滤器 `order_by`, 我们可以在表单类 `Role` 中的关系添加一个参数 `lazy='dynamic'`, 这会禁止自动执行查询.
  ```
  class Role(db.Model):
    #...
    users = db.relationship('User', backref='role', lazy='dynamic')
    #...
  ```
  这样配置了 `关系` 之后, `userRole.users` 会返回**未执行的查询**, 所以可以对用过滤器.
  > `>>> userRole.users.order_by(User.userName).all()`
  > `>>> userRole.users.count()`

## 在视图函数和 html 模板中操作数据库
视图函数和 html 模板的操作是共同进行的, 视图函数执行相关的数据计算, 将得到的结果渲染到 html 模板中进行展示. 另外, 视图函数也可以接收用户用户在 html 中提交的数据, 在视图中处理后存储到数据库中. 下面是一个例子.
```
# 视图函数 hello.py
@app.route('/', methods=['GET', 'POST'])
def index():
    form = NameForm()
    if form.validate_on_submit():
        user = User.query.filter_by(userName=form.name.data).first()
        if user is None:
            user = User(userName=form.name.data)
            db.session.add(user)
            session['known'] = False
        else:
            session['known'] = True

        session['name'] = form.name.data
        form.name.data = ''
        return redirect(url_for('index'))

    return render_template('index.html', form=form, name=session.get('name'), known=session.get('known'))

# 模板 templates/index.html
{% extends 'base.html' %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}xu-zc{% endblock %}

{% block page_content %}
<div class='pate-header'>
    <h1>Hello, {% if name %}{{ name }}{% else %}Stranger{% endif %}!</h1>
    {% if not known %}
        <p>Pleased to meet you!</p>
    {% else %}
        <p>Happy to see you again!</p>
    {% endif %}
</div>
{{ wtf.quick_form(form) %}}
{% endblock %}
```
<emph style='border-bottom:1px dashed red'>注意, 想要运行上面的视图函数, 需要现在 python shell 中创建数据表!</emph>

## 在 python shell 中自动导入数据库实例
上面的视图函数在运行前需要先导入数据库实例和模型, 这无疑增加了操作步骤, 而且这个步骤每次都是完全相同的, 所以考虑在 flask-script 的 shell 命令自动导入特定的对象. 这只需要为 shell 命令注册一个 `回调函数` 即可. <emph style='border-bottom:1px dashed red'>更直白地, 就是在上面的视图函数 `hello.py` 里面增加一个命令, 使得每次运行这个视图函数的时候都会自动引入表单类等内容.</emph>
```
# 在 hello.py 中给 shell 添加一个上下文
from flask_script import shell

def make_shell_context():
    return dict(app=app, db=db, User=User, Role=Role)
manager.add_command('shell', Shell(make_context=make_shel_context)
```
此时如果重新执行 `python hello.py shell`, `程序, 数据库实例, 模型` 都直接导入到了 shell 中, 可以直接进行操作, 下面的几个对象都会直接显示.
> `python hello.py shell`

> `>>> app`

> `>>> db`

> `>>> User`

关于上述添加 `make_shell_context()` 所起到的作用, 理解如下:<emph style='border-bottom:1px dashed red'>对 `manager` 添加了这个执行函数为启动参数, 并将其取名为 `shell`, 这样在启动时用上这个参数就会自动执行这个函数, 导入与数据库相关的对象.</emph>

## 数据库迁移
如果需要对数据库表单类进行修改, 然后再对数据库应用更新, 这些功能数据库本身是不提供的. 较好的解决方案是使用 `数据库迁移框架`. <emph style='border-bottom:1px dashed red'>数据库迁移框架能跟踪数据库模式的变化, 然后 <emph style='border:1px dashed red'>增量式</emph>地把变化应用到数据库上.</emph>

`SQLAlchemy` 地开发人员编写了一个名为 [Alembic](https://alembic.readthedocs.org/en/latest/index.html) 地迁移框架. 在 flask 中可以直接使用 (flask-migrate][http://flask-migrate.readthedocs.org/en/latest], 它对 Alembic 做了轻量包装, 并<emph style='border-bottom:1px dashed red'>集成到了 flask-script 中, 所有迁移操作都通过 flask-script 命令完成, 也就是需要将迁移地命令导出到 flask-script 的命令.</emph>
>(virEnv) conda/pip install flask-migrate

将 flask-migrate 配置到 flask-script 的操作如下.
```
# hello.py 配置 flask-migrate
from flask_migrate import Migrate, MigrateCommand
#...
migrate = Migrate(app, db)
manager.add_command('db', MigrateCommand)
```
## 创建迁移仓库
在维护数据库迁移之前, 要使用 `init` 命令创建迁移仓库
>(virEnv) python hello.py db init

这回创建 `migrations` 文件夹, 所有的迁移脚本都放在其中. 另外, 迁移仓库的文件要和其他程序文件一起纳入版本控制.

## 创建迁移脚本
还不太懂这个东西。。。

## 更新数据库
>(virEnv) python hello.py db upgrade