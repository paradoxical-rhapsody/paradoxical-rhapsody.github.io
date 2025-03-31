+++
title = "worldcloud"
icon = "python"
tags = ["module", ]
+++

# wordcloud

`wordcloud` 库把词云当作一个 `WordCloud 对象`, `wordcloud.WordCloud()` 代表一个文本对应的词云. 词云根据词语的出现频率进行绘制, 词云的字体,形状, 尺寸, 颜色都可以设定. 制作一个词云需要三步: `配置对象参数 -> 加载词云文本 -> 输出词云文件`.

```python
w = wordcloud.WordCloud() 
w.generate(txt)           
w.to_file(fname)          
```

```python
import wordcloud 
w = wordcloud.WordCloud()         # 生成词云对象, 可对 w 配置参数, 加载文本, 输出文件等
w.generate('wordcloud by python') # 向 w 中加载文本数据
w.to_file("pywordcloud.png")      # 将 w 输出为图像文件, png/jpg/pdf, 默认 400pi * 200pi
```

* 默认用空格 `分隔` 单词.
* `统计` 单词出现频率并过滤掉过短的词.
* 根据统计结果配置 `字体` 字号等.
* `布局` 颜色环境尺寸等.

`w = wordcloud.WordCloud()` 参数:
* `width`             默认 400 像素
* `height`            默认 200 像素
* `min_font_size`     词云中最小字号, 默认4号
* `max_font_size`     最大字号, 根据高度自动调节
* `font_step`         字号的步进间隔, 默认为1
* `font_path`         指定字体路径, 默认 None, 如微软雅黑 'msyth.ttc'
* `max_words`         最大单词数量, 默认 200
* `stop_words`        词云的排除单词列表, 可用集合类型.
* `mask`              指定词云形状, 默认长方形. 需要引用 imread() 函数
  * `from scipy.mis import imread`
  * `mk = imread('pic.png')`
  * `w = wordcloud.WordCloud(mask=mk)`
* `background_color`  词云背景颜色, 默认黑色.

* wordcloud 默认使用空格分词, 中文内容可以先利用 jieba 进行分词, 再利用空格对分词结果进行拼接, 再进入 wordcloud 制作词云.

* 例: 对中国政府工作报告进行词云分析. 词云对这种长篇的报道可以给出一些直观的表达.
```python
# 词云政府工作报告
import jieba, wordcloud

# 可以读入一张白色背景图片, 设置 WordCloud() 中的 mask 参数
f = open("关于实施乡村振兴战略的意见.txt", 'r', encoding='utf-8')
t = f.read()
f.close()
ls = jieba.lcut(t)
txt = " ".join(ls)
w = wordcloud.WordCloud(font_path='msyh.ttc', width=1000, height=700,\
                        background_color='white', max_words=15)
w.generate(txt)
w.to_file('新时代.pdf')
```
