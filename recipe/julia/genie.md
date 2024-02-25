+++
title = "Genie"
icon = "lightbulb-fill"
+++


# Genie

\link{Genie}{https://github.com/GenieFramework} 是良好的 MVC 框架, 可与 Julia 无缝搭配. 


## 使用 Genie App 开发

通过 `Genie.newapp("TeachingSystem")` 创建项目, 该命令将创建完整的依赖环境 (`Project.toml` 和 `Manifest.toml`). 

路由文件 `routes.jl` 实现 URLs 到 Julia 函数映射. 路由可通过简单的 `route("/url") do ... end` 定义, 更规范的方式是通过 MVC 模式实现. Genie app 的 MVC 设计模式围绕 `resources` 进行. 每个 `resource` 代表一个实体对象 (teacher / course / student 等), 它对应一系列相关的文件, 这些文件放在 `TeachingSystem/app/resources/` 下独立的文件夹. 以 `teachers` 为例, 其中包括如下内容:

* `Teachers.jl / TeachersValidator.jl`: 分别对应 Model 和 Model Validator.

* `views/*`: 视图模板文件 (View). 视图模板包括 `html` 和 `md` 两种格式, 同时支持使用 `json` 提供数据接口.

* `TeachersController.jl`: 针对客户端请求实现将数据 (`Models`) 通过视图 (`Views`) 进行渲染. 


根据建议, 每个 controler 方法都在 `views/` 下提供一个视图模板, 进一步将其绑定到 `routes.jl` 中的一个路由点.







## 在交互环境中使用


## 