+++
title = "重置 Win11 密码"
date = Date(2024, 07, 10)
icon = "lightbulb-fill"
tags = ["virtualbox", "win", ]
+++

来源: [https://blog.csdn.net/twilight_shaw/article/details/137920907](https://blog.csdn.net/twilight_shaw/article/details/137920907)


# VirtualBox 中重置 Win11 密码


1. 登录页面, 按住 `shift` 并重启.

2. `疑难解答 > 高级选项 > 命令提示符`

3. 此时盘符在 `X:`, 需要进入 `C:` 并将屏幕键盘 (`osk.exe`) 替换为命令提示符, 进而可在安全模式的命令行修改密码:
```bash
C:
cd Windows\System32

copy osk.exe osk1.exe
copy cmd.exe osk.exe

wpeutil reboot
```

4. **正常进入系统**, 打开屏幕键盘将弹出命令行
```bash
net user # 查看用户
net user [用户名] [密码] # 修改密码
```

5. 重新执行步骤 1-4, 切换到 `C:` 并恢复 `osk.exe`:
```bash
copy osk1.exe osk.exe
wpeutil reboot
```

