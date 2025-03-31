+++
title = "视图函数和路由"
date = Date(2019, 03, 23)
icon = "python"
+++


客户端向服务器发出的 `request` 对象中, 可以通过 `request.form` 获取用户 `POST` 的表单内容, 但这种方式据说特别难受. flask-wtf 能方便地处理用户提交表单内容. `wtf` 支持跨站请求伪造保护, 提供了非常丰富地表单类型. 在使用 flask-wtf 时, 有一些固定的使用流程可供借鉴.
