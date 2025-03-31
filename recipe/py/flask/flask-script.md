+++
title = "flask-script"
date = Date(2019, 01, 14)
icon = "python"
+++

flask 对 web 服务器提供了很多 <span style='border-bottom:1px dashed red'>启动设置选项</span>, 但是这些功能默认只能在脚本中作为参数传给 `app.run()`, 这使得这些选项使用起来并不方便. 理想的方式是作为命令行参数, 在 `python xzcSite.py` 的时候直接指定.

flask 扩展 <emph style='border:1px dashed red'>flask-script</emph> 给 flask 程序添加了 <emph style='border-bottom:1px dashed red'>命令行解析器</emph>, 而且提供了一些额外的选项, 还支持自定义命令.

> conda/pip install flask-script

## 将 flask-script 集成到 flask 脚本中
```
from flask_script import Manager    # 导入类
manager = Manager(app)              # 对 app 包装

#... 

if __name__ == '__main__':
    manager.run()
```

就这样对 flask 的默认 app 进行简单包装之后, 就可以解析命令行参数了. 可以在命令行中查看使用方法.

    > python xzcSite.py
    > python xzcSite.py runserver --help
    > python xzcSite.py runserver --host 0.0.0.0