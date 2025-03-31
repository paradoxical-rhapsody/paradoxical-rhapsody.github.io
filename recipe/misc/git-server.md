+++
title = "✓ Git 推送本地内容到服务器"
icon = "git"
tags = ["server", ]
+++

## 推送本地内容到服务器

*2022-01-19*

在服务器端创建 git 目录, 修改目录的所有权和用户权限, 初始化目录:

```text
sudo mkdir git
sudo chown -R $USER:$USER /home/git
sudo chmod -R 755 /home/git
cd /home/git
git init --bare asy.git
```

关于\link{权限}{https://zhuanlan.zhihu.com/p/111733515}, 三位数字分别表示所有者、同组用户和公共用户的权限.

创建 git 钩子: 在 `vi /home/git/asy.git/hooks/post-receive` 中添加两行内容:

```text
#!/bin/bash
git --work-tree=/home/asy --git-dir=/home/git/asy.git checkout -f
```

保存退出后, 增加执行权限:

```text
chmod +x /home/git/asy.git/hooks/post-receive
```

在本地目录添加服务器的目录:

```text
git remote add origin usename@server_ip:/home/git/asy.git
```

