+++
title = "Recipe"
icon = "lightbulb-fill"
+++


@@log
* 用恰当的工具完成正确的事情.
* 所有的文档一定要进行拼写检查 !
* 保持内容与格式分离. (`csvsimple-l3 / tabularray` √)
* 简洁清晰记录原始结果. (对 `target=BIC` 或 `target=MSE` 的结果按行合并再 `fwrite`, 对后续 `output` 操作很友好)
----
* 每个 project/idea 都独立成文件夹, 用好 ReadMe 记录想法和进度.
* 三位版本号是有必要的 (v 0.4.0)
* pkg 的 examples 设置为 "large-n-small-p", 计算快且能检验效果.
* 对 performance 的汇总, 建议定义 `predict.*`, 便于维持 `repFun` 结构清晰.
----
* 原型设计要多考虑完善的信息记录.
* 设计初始原型时, 随时埋入主动防御测试 (可以一直保留). 再如, `data.table` 在分析之初, 把用于 `groupby` 的变量转为因子, 明确指出它的 `levels`.
* 避免小而多的文件传输同步!!!!!!!!!!! (讲的就是微信文件夹)
----
* 使用者不是开发者. 除非现有的轮子不可靠或性能不佳, 或者自己清楚其中的原理并有不一样的思路, 否则不要过分相信自己. (e.g., `logLik`)
* 团队效率的关键是规范和沟通, 不是技术.
* 工程自动化构建对于日常提效的助力很大.
@@

~~~
<br>
<iframe allow="autoplay *; encrypted-media *;" frameborder="0" height="150" style="width:100%;max-width:660px;overflow:hidden;background:transparent;" sandbox="allow-forms allow-popups allow-same-origin allow-scripts allow-storage-access-by-user-activation allow-top-navigation-by-user-activation" src="https://embed.music.apple.com/cn/album/heal-the-world/310505551?i=310505565"></iframe>
~~~

# Recipe


<!--
\toc

## Tools

\link{R}{/recipe/r} /
\link{Julia}{/recipe/julia} /
\link{$\TeX$}{/recipe/latex} /
\link{Py}{/recipe/py}


## Misc / Tips
-->


\list

\item{ [2024-09-11] 用 `shntool` 根据 `cue` 文件分割 `wav/flac` 等格式的整张 CD:

1. `cue` 文件是 `utf-8` 编码.
1. `shntool split -f CD.cue -t '%n.%t' -o wav CD.wav`

}

\item{ [2024-02-27] git 推送抛出 `CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none`, 可临时关闭验证 ():
```bash
export GIT_SSL_NO_VERIFY=1
```
}

\item{ [2023-11-30] win11 首次进入系统时默认要连接网络才能进入下一步, 可在该界面 `shift + F10` 激活命令行, 输入 `oobe\BypassNRO.cmd`, 系统会重启且提供跳过网络连接的选项. }

\item{ 

[2024-11-05] Ubuntu 下安装字体: 把 `TTF` 文件拷贝到三个目录之一: `/usr/share/fonts`, `usr/local/share/fonts/` 或 `~/.fonts`, 然后执行 `fc-cache` 刷新字体缓存即可.
另外, 在 TeX 中可以只用字体的名称来定义新字体命令: 通过 `fc-list | grep LXGW` 可以查看安装的落霞孤鹜字体, 显示的 `LWGW WenKai` 就代表相应字体名称.

    
[2023-02-17] Ubuntu 下双击安装字体, \delete{会被安装在 `/home/zengchao/.local/share/fonts/` 下, 但是 $\TeX$ 中用 `\newCJKfontfamily \yozai {Yozai-Regular.ttf}` 引入字体时报错(没有字体). 解决方案:}

1. 将字体复制到全局目录: `sudo cp * /usr/share/fonts/`
2. 生成索引信息: `sudo mkfontscale ; sudo mkfontdir`
3. 更新字体缓存: `sudo fc-cache -r -v`

[240506] \delete{此时 `\yozai` 命令可用. (不复制到全局该怎么用嘞???)} 

[240506] 在 `TeX` 中定义新字体：
* `sudo fc-list -f "%{family}\n" > fonts.txt` (加 `:lang=zh` 可能会漏掉部分中文字体)
* 根据 `xeCJK` 设置新字体的说明: `\newCJKfamilyfont\yozai{Yozai}`, 指定字体名称就行, 似乎不必要定位到 `ttf` 文件.
}


\item{ [2022-12-10] Remove security limitions from PDF documents using `ghostscript`:
```bash
gswin32c -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sFONTPATH=%windir%/fonts;xfonts;. -sPDFPassword= -dPDFSETTINGS=/prepress -dPassThroughJPEGImages=true -sOutputFile=OUTPUT.pdf INPUT.pdf
```
}


\item{ [2022-12-09] Thunderbird 的日历同步依赖插件 `TbSync`, `Exchange ActiveSync`, `CalDAV & CardDAV`. 其他好用的插件有 `Markdown`, `Minimize on Clos`.}

\item{ [2022-03-30] \link{LXGW WenKai}{https://github.com/lxgw/LxgwWenKai} } / \link{Yozai}{https://github.com/lxgw/yozai-font}

\item{ [2022-03-18] **短路求值**

在 `&&` 或 `||` 布尔链中只有最小数量的表达式被计算：

*  `a && b` 的 `b` 仅当 `a` 为 `true` 时才被执行.
*  `a || b` 的 `b` 仅在 `a` 为 `false` 时才被执行. 
}

\item{ **集合**通常是被精心设计的数据类型.
```
# take prohibited permissions
full_permission = {...}
role_permission = {...}

setdiff(full_permission, role_permission)
```
}


\item{ [2021-07-19] 微软账户下启用过的 bitlocker 密钥：\link{https://onedrive.live.com/RecoveryKey}{https://onedrive.live.com/RecoveryKey}.}

\endlist
