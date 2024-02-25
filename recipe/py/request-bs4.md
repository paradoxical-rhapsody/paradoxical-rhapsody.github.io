+++
title = "Crawler (requests + bs4)"
icon = "python"
tags = ["module", ]
toc_sidebar = true
+++

# request + BeautifulSoup4


## request

```python
import requests
r = requests.get("http://www.baidu.com")
r.status_code
r.encoding = "utf-8"
```

```python
import requests
def getHTMLText(url):
    try:
        r = requests.get(url, timeout=30)
        r.raise_for_status()
        r.encoding = r.apparent_encoding
        return r.text
    except:
        return "产生异常"
if __name__ == "__main__":
    url = "http://www.baidu.com"
    print(getHTMLText(url))
```

## 爬取大学排名

```python
# CrawUnivRankingA.py
import requests
from bs4 import BeautifulSoup
import bs4

def getHTMLText(url):
    try:
        r = requests.get(url, timeout=30)
        r.raise_for_status()
        r.encoding = r.apparent_encoding
        return r.text
    except:
        return ''

def fillUnivList(ulist, html):
    soup = BeautifulSoup(html, 'html.parser')
    for tr in soup.find('tbody').children:
        if isinstance(tr, bs4.element.Tag):
            tds = tr('td')
            ulist.append([tds[0].string, tds[1].string, tds[3].string])

def printUnivList(ulist, num=6):
    tplt = "{:^10}\t{:^6}\t{:^10}"
    print(tplt.format("排名", "学校名称", "总分", chr(12288)))
    for i in range(num):
        u = ulist[i]
        print(tplt.format(u[0], u[1], u[2], chr(12288)))

def main():
    uinfo = []
    url = 'http://www.zuihaodaxue.cn/zuihaodaxuepaiming2016.html'
    html = getHTMLText(url)
    fillUnivList(uinfo, html)
    printUnivList(uinfo)

main()

```


```python
#CrawUnivRankingB.py 
import requests
from bs4 import BeautifulSoup 
import bs4 
def getHTMLText(url):     
    try:         
      r = requests.get(url, timeout=30)         
      r.raise_for_status()         
      r.encoding = r.apparent_encoding         
      return r.text     
    except:         
      return "" 

def fillUnivList(ulist, html):     
    soup = BeautifulSoup(html, "html.parser")     
    for tr in soup.find('tbody').children:         
        if isinstance(tr, bs4.element.Tag):             
            tds = tr('td')             
            ulist.append([tds[0].string, tds[1].string, tds[3].string])

def printUnivList(ulist, num):     
    tplt = "{0:^10}\t{1:{3}^10}\t{2:^10}"     
    print(tplt.format("排名","学校名称","总分",chr(12288)))     
    for i in range(num):         
        u=ulist[i]         
        print(tplt.format(u[0],u[1],u[2],chr(12288)))      

def main():     
    uinfo = []     
    url = 'http://www.zuihaodaxue.cn/zuihaodaxuepaiming2016.html'     
    html = getHTMLText(url)     
    fillUnivList(uinfo, html)     
    printUnivList(uinfo, 20) # 20 univs 

main()
```


## 爬取搜索引擎的结果

```python
import requests
keyword = 'Python' # 变量提前给定，这样才有泛化能力.
try:
  kv = {'wd': keyword}
  r = requests.get('http://www.baidu.com', params=v)
  print(r.request.url)
  r.raise_for_status()
  print(len(r.text))
except:
  print('爬取失败')
```


```python
import requests
url = 'https://www.amazon.cn/gp/product/B01M8L5Z3Y'
try:
    kv = {'user-agent': 'Mozilla/5.0'}
    r = requests.get(url, headers=kv)
    r.raise_for_status()
    r.encoding = r.apparent_encoding
    print(r.text[1000:2000])
except:
     print('Failure')
```


## 下载图片

```python
import requests
import os
url = 'http://image.notionalgeographic.com.cn/2017/0211/20170211061910157.jpg'
root = 'D://pics//'
path = root + url.split('/')[-1] # 使用图片原名作为保存的名字
try:
  if not os.path.exists(root):
    os.mkdir(root)
  if not os.path.exists(path):
    r = requests.get(url)
    with open(path, 'wb') as f:
      f.write(r.content)
      f.close()
      print('文件保存成功')
  else:
    print('文件已存在')
except:
  print('爬取失败')
```


##　BeautifulSoup4

```python
from bs4 import BeautifulSoup
soup = BeautifulSoup(demo, "html.parser") # 把 demo 做成一锅汤
soup.title # 查看网页的标题(显示在浏览器的标签页上)
soup.a.name # 标签 a 的名字
soup.a.parent.name # a 的上一层标签名
soup.a.parent.parent.name # a的上两层标签名

tag = soup.a # soup 中的标签 a(如果有多个 a 标签时，这样只返回第一个)
tag.attrs # 查看标签 a 的属性
tag.attrs['class'] # 查看属性 class 的值
tag.attrs['href'] # 查看链接的值
type(tag.attrs) # 标签的属性封装方式为 dict
type(tatg) # tag 自身的类型是 bs4.element.Tag

soup.a # 查看 a 标签的信息
soup.s.string # a 标签的 string 信息
soup.p
soup.p.string
type(soup.p.string)

newsoup = BeautifulSoup('<b><!--This is a comment--></b><p>This is not a commment</p>', 'html.parser') # <!...> 表示注释 
newsoup.b.string # 打印注释内容，输出是一个字符串
type(newsoup.b.string) # 类型为 bs4.element.Comment
newsoup.p.string # 还是输出一个字符串
type(newsoup.p.string) # 类型为 bs4.element.NavigableString
 # b标签和p标签分别引用 string 时，都得到一个字符串，并没有标明注释有任何差异，在实际分析中，如果需要辨别两种内容，需要调用各自string的 type信息进行判断.
```


## IP 地址查询

```python
import requests
url = 'http://m.ip138.com/ip.asp?ip='
r = requests.get(url + '202.204.80.112')
r.status_code
r.text[-500:] 
```

查看返回文本的最后 500 字节；这是个小技巧：当 `r.text` 的内容很多时，会导致 IDLE 失效(无响应)，可以限制返回的长度来缓解.

