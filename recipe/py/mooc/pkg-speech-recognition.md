+++
title = "SpeechRecognition"
icon = "python"
tags = ["module", ]
+++


# SpeechRecognition

`SpeechRecognition` 是 IBM 提供的音频转文字的 python 包. 使用前需要注册 IBM Cloud 账号. 

* 注册网址: https://speech-to-text-demo.ng.bluemix.net/

* 注册后验证邮箱的激活链接时, 可能需要科学上网.

* 注册完成后, 添加语音识别的服务, 并查看服务详情, 记下显示的服务凭证(username 和 password). 每月免费100mins, 30天不使用将删除服务. 本次使用的详情如下:
```json
{
    "url": "https://stream.watsonplatform.net/speech-to-text/api",
    "username": "d6f92c28-47a3-4a16-945a-753838d54efc",
    "password": "n4wWRkzF4NCC"
}
```

* 注册完成后, 安装 SpeechRecognition. 这个包被 pypi 收录, 可以在清华镜像安装:
> pip install -i https://pypi.tuna.tsinghua.edu.cn/simple SpeechRecognition

* 语音识别的代码中, 参数 `language` 可以设为不同的语言:
```plaintext
ar-AR        阿根廷语
en-UK        英式英语
en-US        美式
es-ES        西班牙
fr-FR        法语
ja-JP        日语
pt-BR        巴西葡萄牙语
zh-CN        中文
```

```python
import speech_recognition as sr
r = sr.Recognizer()
with sr.WavFile('eg.wav') as source:  # 非wav音频要先转换(格式工厂)
    audio = r.record(source)

IBM_UR = 'd6f92c28-47a3-4a16-945a-753838d54efc'  # username
IBM_PD = 'n4wWRkzF4NCC'                          # password

text = r.recognize_ibm(audio, username=IBM_UR, password=IBM_PD, 
                       language='zh-CN')
print(text)
```