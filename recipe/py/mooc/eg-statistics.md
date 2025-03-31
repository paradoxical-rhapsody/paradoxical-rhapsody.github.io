+++
title = "Statistics"
date = Date(2018, 7, 3)
icon = "python"
+++

```python
# eg2-statistics.py
'''
充分利用 python 提供的内置函数, 增强表现力!!!
'''

def get_nums():                      # 获取[不定]长度的输入
    nums = []
    inum = input("输入数字(回车退出): ")
    while inum != "":
        nums.append(eval(inum))      # eval() 记得用啊
        inum = input("输入数字(回车退出): ")
    return nums
def mean(nums):                      # 计算平均值
    s = 0.0
    for num in nums:
        s += num
    return s / len(nums)
def var(nums):                       # 方差 
    s = 0.0
    nums_mean = mean(nums)
    for num in nums:
        s += pow(num - nums_mean, 2)
    return s / len(nums)
def med(nums):
    sorted(nums)
    size = len(nums)
    if size % 2 == 0:
        return (nums[size//2-1] + nums[size//2]) / 22
    else:
        return nums[size//2]

def main():
    n = get_nums()
    print("均值, 方差, 中位数分别为: {:.2f}, {:.2f}, {:.2f}".format(mean(n), var(n), med(n)))

main()

```

