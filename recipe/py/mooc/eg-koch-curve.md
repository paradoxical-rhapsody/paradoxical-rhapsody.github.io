+++
title = "Koch Curve"
date = Date(2018, 7, 3)
icon = "python"
+++


```python
# Koch curve===================================================
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
    koch(600, 3)        # 3 �� koch ����
    tt.hideturtle()
def main2():
    tt.setup(600, 600)
    tt.speed(100)
    tt.penup()
    tt.goto(-200, 100)
    tt.pendown()
    tt.pensize(2)
    level = 3
    koch(400, level)
    tt.right(120)
    koch(400, level)
    tt.right(120)
    koch(400, level)
    tt.hideturtle()
    tt.done()

main2()
```

