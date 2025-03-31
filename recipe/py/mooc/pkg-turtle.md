+++
title = "turtle"
icon = "python"
tags = ["module", ]
+++

# turtle

turtle(海龟) 是 turtle 绘图体系(1969年)的 python 实现, 是一个标准库, 作为程序设计的入门库, 也是入门的绘图库. 假设有一只 turtle, 从画布中心开始游走, 爬过的轨迹形成图形, 控制 turtle 的就是改变图形的特征.

> import turtle as tt

## 画布设置

```python
tt.title('这是我的第一个 turtle 例子')     # 设定窗口标题
tt.setup(200, 300, 0, 0)                  # 画布大小和启动位置(px)
tt.done()       # 脚本中, 表明绘图结束并且 [不退出] 绘图窗口
```

## 海龟笔设置

```python
tt.speed(1)                     # 移动速度
tt.pensize(20)                  # 粗细; tt.width(20)
tt.pencolor('purple')           # 颜色
tt.pencolor(0.63, 0.13, 0.94)
tt.pencolor((0.63, 0.13, 0.94))
tt.penup()                      # 将笔从画布上拿起来, 放下之前的移动不会形成轨迹
tt.pendown()                    # 与 penup 成对出现
```

## 颜色(默认使用 RGB-float)

```plaintext
------------------------------------------------
color       RGB-int        RGB-float         description
------------------------------------------------
white       255,255,255    1,1,1
yellow      255,255,0      1,1,0
magenta     255,0,255      1,0,1             洋红
cyan        0,255,255      0,1,1             青
blue        0,0,255        0,0,1
black       0,0,0          0,0,0
seashell    255,245,238    1,0.96,0.93       海贝色
glod        255,215,0      1,0.84,0
pink        255,192,203    1,0.75,0.80       粉红
brown       255,192,203    1,0.75,0.80       棕色
purple      160,32,240     0.63,0.13,0.94    紫
tomato      255,99,71      1,0.39,0.28    

tt.colormode(255)   # RGB-int 模式; tt.colormode(1.0)
------------------------------------------------
```

## 空间定位

* xOy坐标系中, 画布正中心为原点 `(0, 0)`, 向右和向上为 `x` 和 `y` 轴的正方向.
* 初始默认 `tt` 位于原点, 朝向右侧.
* 海龟坐标中, 四个方向为 `forward/fd`, `backward/bk/back`, `left`, `right`.

## 运动控制函数, 产生运动轨迹

```python
tt.goto(x=50, y=70)             # 从当前位置直达 (x, y)
tt.fd(50)                       # tt.fd(-50); tt.forward(50)
tt.bk(50)                       # tt.bk(-50); tt.backward(50);
tt.circle( 50, 120)             # 海龟[左侧] 50 处为圆心, 绘制120度的圆弧
tt.circle(-50, 120)             # 海龟[右侧] 50 处为圆心, 绘制120度的圆弧
```

## 方向控制函数, 不产生运动轨迹

```python
tt.seth(-120)                   # xOy坐标,设定朝向的角度为 -120 度; tt.setheading()
tt.left(60)                     # 海龟坐标,向左旋转 60 度
tt.right(60)                    # 海龟坐标,向右旋转 60 度
```

## Example

```python
import turtle as tt

tt.setup(650, 350, 200, 200)
tt.penup()
tt.fd(-250)
tt.pendown()
tt.pensize(25)
tt.pencolor('purple')
tt.seth(-40)
for i in range(4):
  tt.circle(40, 80)
  tt.circle(-40, 80)
tt.circle(40, 80/2)
tt.fd(40)
tt.circle(16, 180)
tt.fd(40 * 2/3)
tt.done()
```
