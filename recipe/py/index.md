+++
title = "Py"
icon = "python"
toc_sidebar = true
+++


# Py


## 笔记

\link{MOOC}{mooc} / 
\link{Flask}{flask} / 
\link{request + bs4}{request-bs4}



## Ecosystem / Modules

* \link{calendar}{https://docs.python.org/3/library/calendar.html}: 简洁处理年份、月份、日期、星期等.

* \link{enum}{enum}: 管理常量和多分支都很有用.

* [pdfplumber](): 按页处理 pdf, 获取页面文字, 提取表格等操作.
* [pypdf2](): 纯 Python 库, 可以读取文档信息(标题/作者等)、写入、分割、合并PDF文档. 它还可以对pdf文档进行添加水印、加密解密等.
* [cutecharts](): 绘制*手绘风格*的统计图形.

* [moviepy](): 视频编辑 (剪辑/文本添加/合并/格式转换/基本特效)


## Tips

\list


\item{ [2022-11-28]
* Ubuntu 上安装 anaconda 时, **务必初始化**, 否则重装吧. 
* 可以通过设置 `conda config --set auto_activate_base false` 禁止启动终端时自动进入 `base` 环境. 如果这个设置不生效, 那就是 `.bashrc` 里有 `conda activate base`, 把它删掉.
}

\item{ [2021-05-17] 
    在服务器上用 `anaconda3/miniconda3` 创建虚拟环境后, `conda init bash` 初始化之后, 想要 `conda install -c conda-forge r-base` 的时候抛出如下错误:
    ```plaintext
    Solving environment: failed with initial frozen solve. Retrying with flexible solve
    ```
    一个\link{解决方式}{https://stackoverflow.com/questions/60300787/errors-such-as-solving-environment-failed-with-initial-frozen-solve-retrying}是 `conda config --set channel_priority false` 之后, 重新执行安装命令 (可能需要重启/更换更快的镜像).
}

\item{[2020-09-04] 
    参考 \link{`conda` 管理虚拟环境}{https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#sharing-an-environment}

* `conda` 的虚拟环境如果包含了 `pip` 安装的内容, 使用 `conda env list export > pkgs.yml`. 在其他设备上用 `conda env create -f pkgs.yml` 将会自动区分两种方式的安装内容, 分别安装.
    
* 如果要跨平台, 那需要 `conda env list export --from-history > pkgs.yml` 导出通过 `conda` 安装的包, 相关的依赖不会写入这个文件, 而是在不同的平台下自行编译安装.
}

\item{[2020-08-04]
    python 在本地开启网络服务, 用其他设备接入局域网后, 能访问文件而且速度很快.
    ```plaintext
    python -m http.server 8000
    ```
    其中 `8000` 作为端口号可以自行设置. 可以添加参数如 `--bind 127.0.0.1` 设置 `ip`.

* 命令行用 `ipconfig` 查看电脑的 `ipv4` 地址. 可能会打印多个, 其中包括 `WLAN` 的地址和 `本地连接` 的地址. 在其他设备上使用共同网络的地址.
* 设备都连上学校的 `SJTU` 网络, 按上述启动本地服务器后, 手机刷不出来共享的文件夹(可能 `SJTU` 不是一般的路由器或者不是局域网？). 
* 想了个黑技巧, 在电脑上打开热点让手机连上, 使用 `ipconfig` 输出的 `无线局域网适配器 - 本地连接` 里的 `ipv4` 地址, 顺利连接上. 所以不是网络和文件夹共享权限的设置上有问题.
}


\endlist