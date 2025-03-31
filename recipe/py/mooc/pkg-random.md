+++
title = "random"
icon = "python"
tags = ["module", ]
+++

# random

* 伪随机数采用梅森旋转算法生成. `random` 是标准库, 其中包括两类函数, 产生随机数的函数本质上只有 `random()`, 据说其他的函数都是由此扩展得到的. 常用的有八个:
    * 基本随机数函数: `seed()`, `random()`
    * 扩展随机数函数: `randint()`, `getrandbits()`, `uniform()`, `randrange()`, `choice()`, `shuffle()`

```plaintext
import random
random.seed(2018)
random.random()              # 生成 [0.0, 1.0) 间的随机小数
random.randint(10, 20)       # [10, 20] 之间的整数
random.randrange(10, 10, 3)  # 生成一个 [m, n) 上以 k 为步长的随机整数
random.randbits(k)           # 生成 k 比特长的随机整数
random.uniform(a, b)         # [a, b] 间的随机小数
random.choice([1, 2, 3, 4])  # 给定序列中随机选取一个元素
random.shuffle([1, 2, 3, 4]) # 得到一个随机排列的序列
```

## Monte Carlo to calculate pi

```python
from time import perf_counter
DARTS = pow(10, 6)
hits = 0
start = perf_counter()
for i in range(1, DARTS+1) :
    x, y = random.random(), random.random()
    dist = pow(x**2 + y**2, 0.5)
    if dist <= 1.0 :
        hits += 1
pi = 4 * (hits/DARTS)
print("圆周率的估计值为: {}".format(pi))
print("运行时间为: {:.5f}".format(perf_counter() - start))
```