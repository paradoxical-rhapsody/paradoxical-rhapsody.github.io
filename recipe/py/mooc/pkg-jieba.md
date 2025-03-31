+++
title = "jieba"
icon = "python"
tags = ["module", ]
+++

# jieba

`jieba` 分词依靠中文词库, 确定汉字之间的关联概率, 汉字间概率大的形成词组. 用户可以自定义词组, 用于特定领域. jieba 分词三种模式：
* 精确模式: 文本精确切分开, 不存在冗余单词(最常用).
* 全模式:   将所有可能的词语都扫描出来, 存在冗余.
* 搜索引擎模式: 在精确模式基础上, 对长词再次切分(适用特定场景).

分词函数:
* jieba.lcut(s)                    精确模式, 返回[列表]
* jieba.lcut(s, cut_all=TRUE)      全模式[列表]
* jieba.lcut_for_search(s)         搜索引擎模式[列表]
* jieba.add_word(w)                向分词词典添加新词

## Hamlet

文件 \link{eg-Hamlet.txt}{eg-Hamlet.txt}

```python
import jieba
def get_text():
    txt = open("eg-Hamlet.txt", "r").read()
    txt = txt.lower()
    for ch in '|"#$%()*+,-./:;<=>?@[\\]^_{|}·~‘’':
        txt = txt.replace(ch, ' ')
    return txt
    
hamlet = get_text()
words = hamlet.split()          # 默认空格分隔, 返回列表
counts = {}
for word in words:
    counts[word] = counts.get(word, 0) + 1   # dict.get(k, default) 方法
items = list(counts.items())
items.sort(key=lambda x:x[1], reverse=True)  # 对列表按照键值对的第二个元素由大到小排序
for i in range(10):
    word, count = items[i]
    print("{0:<10}{1:>5}".format(word, count))
```

## 三国演义 V1

文件 \link{eg-Threekingdoms.txt}{eg-Threekingdoms.txt}

```python
import jieba
txt = open('eg-Threekingdoms.txt', 'r', encoding='utf-8').read()
words = jieba.lcut(txt)
counts = {}
for word in words:
    if len(word) == 1:
        continue
    else:
        counts[word] = counts.get(word, 0) + 1
items = list(counts.items())
items.sort(key=lambda x:x[1], reverse=True)
for i in range(15):
    word, count = items[i]
    print('{0:<10}{1:>5}'.format(word, count))
```

## 三国演义 V2

```python
import jieba
txt = open('eg-Threekingdoms.txt', 'r', encoding='utf-8').read()
excludes = {"将军", "却说", "荆州", "二人", "不可", "不能", "如此"}
words = jieba.lcut(txt)
counts = {}
for word in words:
    if len(word) == 1:
        continue
    elif word == "诸葛亮" or word == "孔明曰" :
        reword = "孔明"
    elif word == "关公" or word == "云长" :
        reword = "关羽"
    elif word == "玄德" or word == "玄德曰" :
        reword = "刘备"
    elif word == "孟德" or "丞相" in word :
        reword = "曹操"
    else:
        reword = word  
    counts[reword] = counts.get(reword, 0) + 1
for word in excludes :
    del counts[word]
items = list(counts.items())
items.sort(key=lambda x:x[1], reverse=True)
for i in range(10):
    word, count = items[i]
    print('{0:<10}{1:>5}'.format(word, count))
```


## 天龙八部

文件 \link{eg-TianLongBaBu.txt}{eg-TianLongBaBu.txt}

```python
import jieba
txt = open("eg-TianLongBaBu.txt", "r", encoding='utf-8').read()
words = jieba.lcut(txt)
counts = {}
for word in words:
    if len(word) == 1:
        continue
    else:
        counts[word] = counts.get(word, 0) + 1

excludes = {"说道", "什么", "自己", "一个", "不是", "一声", "武功", "咱们", "师父", "不知", "心中", "知道", "出来", "姑娘", "如何", "便是", "突然"}
for word in excludes:
    try:
        del counts[word]
    except:
        continue

items = list(counts.items())
items.sort(key=lambda x:x[1], reverse=True)
for i in range(10):
    word, count = items[i]
    print("{:<10}{:>5}".format(word, count))
```

## 倚天屠龙记

文件 \link{eg-YiTianTuLongJi.txt}{eg-YiTianTuLongJi.txt}

```python
import jieba
txt = open("eg-YiTianTuLongJi.txt", "r", encoding='utf-8').read()
words = jieba.lcut(txt)
counts = {}
for word in words:
    if len(word) == 1:
        continue
    else:
        counts[word] = counts.get(word, 0) + 1

excludes = {"说道", "自己", "甚么", "一个", "武功", "咱们", "教主", "心中", "一声", "只见", "少林", '弟子', '明教', '便是', '不是', '不知', '如此', '之中', '如何', '出来', '师父', '突然', '他们', '只是', '不能', '我们', '今日', '心想', '知道', '二人', '两人', 'bugj'}
for word in excludes:
    try:
        del counts[word]
    except:
        continue
    
items = list(counts.items())
items.sort(key=lambda x:x[1], reverse=True)
for i in range(40):
    word, count = items[i]
    print("{:<10}{:>5}".format(word, count))
```
