+++
title = "函数"
icon = "python"
+++


# 函数

* 包括`常规函数`, `lambda 函数`, `递归函数`.
* 函数使用 `def` 声明, 使用 `return` 得到返回值. 
* 函数可以当作人为定义的 `输入 -> 处理 -> 输出` 的过程, 这个过程能够完成我们特定的目的. 
* 函数定义中, python 要求 `可选参数` 必须放在 `必选参数` 之后(可选参数在定义时, 人为设定了默认值)
* 函数可以定义成 `可变数量的参数`:
    ```
    def f(x, *b):
        # ...
        return result
    ```
* 一个可变参数的例子如下:
    ```
    def fact(n, *b):
        result = 1
        for i in range(1, n+1):
            result *= i
        for item in b:
            result *= item
        return result
    ```
* 除非特别公共使用的函数, 养成使用名称传递的方式调用函数(尽量避免位置传递).
* 函数内部定义和使用的变量是局部变量, 包括函数参数和函数内部定义的. 局部变量即便与全局变量同名, 但仍然是不同的. 函数调用结束后, 局部变量被释放.
* 可以使用 `global` 保留字在函数内部定义全局变量.
* 在函数内部想要使用外部的全局变量, 需要使用 global 修饰和声明.
* 函数内部使用了一个 `组合类型`(列表等)的变量, 并且没有在函数内部创建, 则等同于全局变量. 如果在函数内部被创建了, 那么它就是局部变量.

# lambda 函数:
```
f = lambda x,y : x+y
f(10, 15)
```
建议使用 `def` 定义普通函数, lambda 函数作为其他函数参数.

### 七段数码管绘制
下面这个形状可以表示 `0-9` 和 `A-F`(其中b, c, d 是小写).
```
   6
  -----
 |     |
5|  1  |7
  -----
 |     |
4|     |2
  -----   .
    3      dp
```

* Step1: 绘制单个数字.
* Step2: 绘制一串数字.
* Step3: 获得当前时间, 绘制.

```
import turtle as tt
import time
def draw_gap():
    tt.penup()
    tt.fd(5)
def draw_line(draw):            # 绘制单段数码管
    draw_gap()
    tt.pendown() if draw else tt.penup() # exp1 if cond else exp2 很好用
    tt.fd(40)
    draw_gap()
    tt.right(90)
def draw_digit(digit):          # 绘制数字的七段管
    draw_line(True) if digit in [2, 3, 4, 5, 6, 8, 9] else draw_line(False)
    draw_line(True) if digit in [0, 1, 3, 4, 5, 6, 7, 8, 9] else draw_line(False)
    draw_line(True) if digit in [0, 2, 3, 5, 6, 8, 9] else draw_line(False)
    draw_line(True) if digit in [0, 2, 6, 8] else draw_line(False)
    tt.left(90)
    draw_line(True) if digit in [0, 4, 6, 6, 8, 9] else draw_line(False)
    draw_line(True) if digit in [0, 2, 3, 5, 6, 7, 8, 9] else draw_line(False)
    draw_line(True) if digit in [0, 1, 2, 3, 4, 7, 8, 9] else draw_line(False)
    tt.left(180)
    tt.penup()
    tt.fd(20)
def draw_date(date):   # 设date格式为 %Y-%m=%d+
    tt.pencolor('red')
    for i in date:
        if i == '-':
            tt.write('年', font=('Arial', 18, 'normal'))
            tt.pencolor('green')
            tt.fd(40)
        elif i == '=':
            tt.write('月', font=('Arial', 18, 'normal'))
            tt.pencolor('blue')
            tt.fd(40)
        elif i == '+':
            tt.write('日', font=('Arial', 18, 'normal'))
        else:
            draw_digit(eval(i))  # eval 不要忘了, 这样draw_digit()不用引号
def main():
    tt.setup(800, 350, 200, 200)
    tt.speed(10)
    tt.penup()
    tt.fd(-300)
    tt.pensize(5)
    draw_date(time.strftime('%Y-%m=%d+', time.gmtime()))    
    tt.hideturtle()
    tt.done()  
main()
```

# 递归法反转字符串
```
def rvs(s):
    if s == "":
        return s
    else :
        return rvs(s[1:]) + s[0]
```
# Fibonoci number sequence
```
def fib(n):
    if n in [1, 2]:
        return 1
    else :
        return fib(n-1) + fib(n-2)
```
# 汉诺塔问题
```
count = 0
def hanoi(n, src='A', dst='B', mid='C'):
    'src(source), dst(destination), mid(midnate)'
    'n 代表第 n 个小圆盘(从上向下数)'
    global count
    if n == 1 :
        print('{}: {}->{}'.format(1, src, dst))
        count += 1
    else :
        hanoi(n-1, src, mid, dst)
        print('{}: {}->{}'.format(n, src, dst))
        count += 1
        hanoi(n-1, mid, dst, src)
def main():
    hanoi(5)
    print("移动总次数为{}".format(count))
```

# Koch curve
```
import turtle as tt
def koch(size, n):
    if n == 0:
        tt.fd(size)
    else :
        for angle in [0, 60, -120, 60]:
            tt.left(angle)
            koch(size/3, n-1)

def main1():  # Koch curve 
    tt.setup(800, 400)
    tt.speed(0)
    tt.penup()
    tt.goto(-300, -50)
    tt.pendown()
    tt.pensize(2)
    koch(600, 3)        # 3 阶 koch 曲线
    tt.hideturtle()
def main2():
    tt.setup(600, 600)
    tt.speed(1000)
    tt.penup()
    tt.goto(-200, 100)
    tt.pendown()
    tt.pensize(2)
    level = 4
    koch(400, level)
    tt.right(120)
    koch(400, level)
    tt.right(120)
    koch(400, level)
    tt.hideturtle()
    tt.done()

main2()
```
    