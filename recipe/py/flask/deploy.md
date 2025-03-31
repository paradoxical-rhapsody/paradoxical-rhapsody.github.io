+++
title = "部署到服务器"
date = Date(2020, 01, 03)
icon = "python"
+++


# 要配置的三项内容
* Aliyun: Ubuntu 16 -- 64 位
* WSGI:  gunicorn
* 进程监控: supervisor
	
按照建议, 新建一个用户, 并搭建虚拟环境来管理 Flask 项目. 这里直接使用了管理员身份，但是建立了虚拟环境(ubuntu 默认只有 python2.7).

## 配置步骤

### 提交 Flask 项目文件

在 flask 自带的开发服务器上测试好项目之后, 将整个文件夹放在 Ubuntu 服务器上的合适位置. 这里假设放在 `/home/blog` 文件夹内. 在项目文件夹内新建日志文件夹:
```text
mkdir /home/blog/logs
```

### 配置 python 虚拟环境

执行命令(使用 conda 也可以完成全部相关配置). **注意, `gunicorn` 是 python 模块, 要在虚拟环境安装.**
```text
pip install virtualenv
virtualenv -p /usr/bin/python3 venv
source /home/venv/bin/activate
pip install flask     # 可以使用依赖文件一次安装好用到的模块.
pip install gunicorn
```

配置: 在 flask 项目文件夹中配置 gunicorn
```text
cd /home/blog
touch gunicorn.conf
vim gunicorn.conf
```

输入如下内容
```text
# 进程数位 3
workers = 3

# 监听开发服务器的端口
bind = '127.0.0.1:5000'   #注意, 这个默认端口可以在 app.run()中修改
```
这个虚拟环境在下面一步的 supervisor 中被配置了。

### 安装和配置 supervisor

```text	
sudo apt-get install supervisor
cd /etc/supervisor/conf.d/
touch blog.conf
vim blog.conf
```

在其中编写配置内容:
```text
# 进程的名字，取一个以后自己一眼知道是什么的名字。
[program:blog]

# 定义命令。注意「hello:app」的run，是你网站应用的文件名。
command=/home//venv/bin/gunicorn hello:app -c /home/blog/gunicorn.conf

# 网站目录
directory=/home/blog

# 进程所属用户。之前为博客建立过一个小号www，你还记得？
user=root   # 如果专门新建了用户, 可以在这里修改
	
# 自动重启设置。
autostart=true
autorestart=true
	
# 日志存放位置。
stdout_logfile=/home/blog/logs/gunicorn_supervisor.log 
	
# 设置环境变量。这里这行的意思是：设置环境变量MODE的值为UAT。请根据自己的需要配置，如没有需要这行可以删除。(配置的时候添上了, 但是不知道有什么用)
environment = MODE="UAT"
```

加载并生效 supervisor:
```text
sudo supervisorctl reread
supervisorctl update
sudo supervisorctl start blog
```

如果没有正常运行, 并且确认配置文件没错, 可以尝试重启:
```text
sudo service supervisor stop
sudo service supervisor start
```

### 安装和配置 nginx

```text
sudo apt-get install nginx
cd /etc/nginx/sites-available/
touch blog
vim blog
```

配置:
```text
server {  
	listen     8585;   # 这个是自己在安全组中打算开启的端口
	server_name www.xxx.com;  # 域名或者 ip
	
	root       /home/www/blog;
	access_log /home/blog/logs/access.log;
	error_log  /home/blog/logs/access.log;

	location / {  
		proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;  
		proxy_set_header Host $http_host;  
		proxy_redirect off;  
		if (!-f $request_filename) {  
			proxy_pass http://127.0.0.1:5000;   # 这里写 app.run() 的开发服务器的地址
			break;  
		}  
	}  
}
```

启动 nginx:
```text
cd ..
cd sites-enabled
ln -s /etc/nginx/sites-available/blog  ./blog        	 # 建立配置文件的链接
ls -l          # 查看 blog 的链接是否成功建立
sudo service nginx restart    # 启动
```

这时候就可以访问 nginx 配置里的域名和端口进行访问.


**Flask内容更新的时候，浏览器的内容不会自动更新，需要重启 supervisor 的服务**
```text
sudo service supervisor stop
sudo service supervisor start
```
