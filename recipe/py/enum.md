+++
title = "enum"
icon = "python"
tags = ["module", ]
toc_sidebar = true
+++

# enum

\link{enum}{https://docs.python.org/3/library/enum.html} 是内置的数据类型模块, 对常量处理非常有用.


## 当方法非常庞大, 而且需要处理大量条件时, `enum` 就很好用

```python
OPEN = 1
IN_PROGRESS = 2
CLOSED = 3

def handle_open_status():
    print('Handling openstatus')
def handle_in_progress_status():
    print('Handling inprogress status')
def handle_closed_status():
    print('Handling closedstatus')

def handle_status_change(status):
    if status == OPEN:
        handle_open_status()
    elif status == IN_PROGRESS:
        handle_in_progress_status()
    elif status == CLOSED:
        handle_closed_status()

handle_status_change(1)  # Handling open status
handle_status_change(2)  # Handling in progress status
handle_status_change(3)  # Handling closed status
```


```python
from enum import IntEnum

class StatusE(IntEnum):
    OPEN = 1
    IN_PROGRESS = 2
    CLOSED = 3

def handle_open_status():
    print('Handling openstatus')
def handle_in_progress_status():
    print('Handling inprogress status')
def handle_closed_status():
    print('Handling closedstatus')

handlers = {
    StatusE.OPEN.value: handle_open_status,
    StatusE.IN_PROGRESS.value: handle_in_progress_status,
    StatusE.CLOSED.value: handle_closed_status
}

def handle_status_change(status):
    if status not inhandlers:
        raiseException(f'No handler found for status: {status}')
    handler =handlers[status]
    handler()

handle_status_change(StatusE.OPEN.value)  # Handling open status
handle_status_change(StatusE.IN_PROGRESS.value)  # Handling in progress status
handle_status_change(StatusE.CLOSED.value)  # Handling closed status
handle_status_change(4)  # Will raise the exception
```


## `enum` 模块提供了一系列处理枚举的工具函数

```python
from enum import Enum, IntEnum, Flag, IntFlag

class MyEnum(Enum):
    FIRST = "first"
    SECOND = "second"
    THIRD = "third"

class MyIntEnum(IntEnum):
    ONE = 1
    TWO = 2
    THREE = 3
# Now we can do things like:
MyEnum.FIRST  #<MyEnum.FIRST: 'first'>
# it has value and name attributes, which are handy:
MyEnum.FIRST.value  #'first'
MyEnum.FIRST.name  #'FIRST'
# additionally we can do things like:
MyEnum('first')  #<MyEnum.FIRST: 'first'>, get enum by value
MyEnum['FIRST']  #<MyEnum.FIRST: 'first'>, get enum by name
```

