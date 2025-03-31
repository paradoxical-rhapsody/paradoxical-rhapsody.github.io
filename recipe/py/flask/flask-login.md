+++
title = "flask-login"
date = Date(2019, 03, 06)
icon = "python"
+++

**用户认证** 的意义在于, 可以根据用户身份，按条件提供针对性的体验. 常见的认证方式要求用户提供一个身份证明(邮件或用户名)和一个密码. 用户认证的过程可以按照流程划分几个步骤:
- [x] 用户注册页面: 填写邮箱, 密码等信息, 给用户发送包含确认链接的邮件.
- [x] 用户验证页面: 验证用户从确认链接来到页面之后, 信息是否匹配 -> 完成注册.
- [x] 用户登陆: 在用户提交请求(浏览网站或提交数据)时, 保持登陆状态.
- [x] 管理账户: 修改密码, 用户名, 邮箱等信息.

这一部分用到的模块(重点在于 `flask-login` 和 `Werkzeug` 和 `itsdangeous` 的使用):
- [x] flask-login: 管理**已登录**用户.
- [x] werkzeug: flask 默认模块, 计算与核对**密码**散列值.
- [x] itsdangerous: flask 默认模块, 生成与核对加密令牌, 用于邮件确认.
- [x] flask-email: 发送邮件[(参考)](06-flask-mail).
- [x] flask-bootstrap: 网页基模板[(参考)](06-flask-bootstrap)
- [x] flask-wtf: 设计 web 表单.


# `flask-login` 提供的特殊内容如下:
- [x] 要求 `User` 模型(类)必须实现四个方法:
  - [x] `is_authenticated()`: 已登录返回 True, 否则返回 False.
  - [x] `is_active()`: 如果允许用户登陆, 返回 True. **禁用账户**则返回 False.
  - [x] `is_anonymous()`: 对普通用户必须返回 False.
  - [x] `get_id()`: 返回用户的唯一标识符, Unicode 编码.
  
  这四个方法可以在定义 `class User(db.Model)` 时直接定义, <emph style='border-bottom:1px dashed red'>但是 `flask-login` 提供了一种简单的替代方案, 它提供了一个 `UserMixin` 类, 其中已经包含了这写方法的默认实现, 可以满足多数需求, 只需要继承这个类即可, 也就是 `class User(UserMixin, db.Model)`</emph>.
- [x] `flask_login.LoginManager` 实例化参数有两个属性, `session_protection` 和 `login_view`, 前者包括 `None, basic, strong` 三种不同的安全等级(`strong` 时 flask-login 会记录客户端 IP 和浏览器的用户代理信息等, 信息应该可以提取出来, **如果发现异动就会登出账户**.), 后者设置登陆界面的端点(要显示指定蓝本).
- [x] **实例**的修饰器 `user_loader`, 用来修饰一个自定义的导入用户的函数(应该是被 flask-login 提供的 `login_user` 调用了)
- [x] `@login_required` 修饰器
- [x] `current_user`: 视图和 html 模板中均可直接使用.
- [x] `login_user`, `logout_user`.
- [x] `request.args.get('next')`.

# `werkzeug` 计算和核对密码散列
有一句话写的很好: 人们往往会高估数据库中用户信息的安全性. 如果服务器被入侵, 数据库就有可能被获取, 用户的信息就处于风险之中. **这个风险比想象的要大很多**, 因为多数用户会在不同网站中使用一些相同的信息(比如密码).

为了确保信息安全, 关键是不要存储密码本身, 而是将用户设定的密码转换成 **散列值** 存储. 计算散列值的函数接收密码作为参数, 使用加密算法返回一个与原密码无关的字符列, 在核对密码的时候, 可以用散列值替代原始密码. <emph style='border-bottom:1px dashed red'>所以这里对加密算法的要求是 **可复现, 不可逆**: 相同的输入可以得到相同的散列值, 不能用散列值还原出原密码. 由于计算散列值算法是一个复杂的任务, 很难正确处理, 通常建议避免自己实现, 而是选用经过社区成员审查且声誉良好的模块</emph>. 生成散列值的过程可以参考 <Salted Password Hashing - Doing it Right!>.

`werkzeug.security` 模块提供了两个函数分别实现散列值的计算与核对:
  * `generate_password_hash(password, method=pbkdf2:sha1, salt_length=8)`: 以字符串格式返回散列值, 后两个参数的默认值就能满足多数需求.
  * `check_password_hash(hash, password)`: 比对散列值和密码, True 表示匹配.

为了将用户的密码散列存入数据库, 下面将这两个散列值函数添加到 `class User(db.Model)` 中:
```
# app/models.py: 在 User 中添加密码散列功能
from werkzeug.security import generate_password_hash, check_password_hash

class User(db.Model):
    #...
    password_hash = db.Column(db.String(48))

    @property
    def password(self):
        raise AttributeError('密码不能直接读取')  # 对用 self.password() 会出错
    
    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)
    
    def verify_password(self, password):
        return check_password_hash(self.password_hash, password)
```

# 创建认证蓝本
对于不同的功能, 使用不同的蓝本能够保持代码整齐有序. 由于用户认证是一个相对独立的功能, 可以将其独立出来, 建立一个蓝本来管理相关的视图和逻辑. 这里用户认证功能都放在一个名为 `/app/auth/` 的模块内, 相关的 `蓝本定义, 视图函数, 表单` 都放在这个模块中. 渲染用到的 `html` 模板可以放在 `templates/auth/` 下面, 由于 flask 会默认在 `templates` 下面搜索模板, 所以在视图函数中使用 `render_templat('auth/*.html, ...)` 的格式指定模板.

```
# app/auth/__init__.py: 创建认证蓝本, 注意最后才导入视图函数
from flask import Blueprint

auth = BLueprint('auth', __name__)

from . import views
```
```
# app/__init__.py: 注册认证蓝本, 注册蓝本时使用了 url_prefix, 会默认在认证蓝本的路由前面自动添加这个前缀, auth.route('/login') 会对应 `/auth/login`.
def create_app(config_name):
    #...
    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint, url_prefix='/auth')

    return app
```
```
# app/auth/views.py: 认证功能的视图函数, 注意渲染模板的位置.
from flask import render_template
from . import auth

@auth.route('/login')
def login():
    return render_templae('auth/login.html')
```

# flask-login 实现认证的流程
1. 设计用于登录的用户模型(`class User`).
2. 保护路由(使用 `@login_required` 确保路由只能被认证用户访问).
3. 设计登陆/注册的表单, 设计相应的 html 模板.
4. 设计 登入/登出 用户的视图函数.
5. 设计 注册 新用户的视图函数.
6. 在用户模型中添加 令牌验证 的方法.
7. 在新用户 注册函数 中添加发送确认邮件的步骤.
8. 设计修改密码/重设密码/修改邮件地址的功能.
