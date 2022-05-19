## 用 Shields.io 数据牌 + GitHub 统计卡片美化你的 GitHub profile

### 一、在 GitHub 中发现小彩蛋

首先，在 GitHub 中创建和账号**同名的**一个 repository，就会发现这个小彩蛋。创建时请确保该仓库公开并且有README.md文件

### 二、美化GitHub profile

使用  [Shields.io](https://shields.io/)  可以方便地定制个性化牌子

##### Static数据牌展示

- `label` 写要展示的名字，比如：CSDN。

- `message` 可以写展示数据，比如：全国前 4K 名。

- `color` 选择一个颜色（当然，也可以到[这里](https://link.zhihu.com/?target=https%3A//www.sioe.cn/yingyong/yanse-rgb-16/)找喜欢的颜色，输入对应的十六进制代码）。

  然后点右边的 `Make Badage`，就会看到效果展示了。

然后复制地址栏里的地址，直接使用 Markdown 的插入图片语法：`![](这里粘贴地址栏地址)`，就可以展示出来了。但是需要注意的是，这种方法是静态展示，如果数据改变了，需要自己手动更新，不够自动化。

##### 动态数据牌展示

利用 Substats 配合 Shields.io 定制小牌子 ( •̀ ω •́ )✧

为了更好的配合 Shields.io 服务，我特意将 Substats 的 API 设计成简单拼接 URL 即可进行数据请求。Substats API 的语法非常简单，我们只需要关注并提供如下的两个字段即可进行请求：

- 目标服务名称 `source`：你所想要请求的服务、网站和平台名（比如：`sspai`、`weibo`……）
- 请求数据标签 `queryKey`：在这一服务中查询的关注数据对应的标签或名称（比如我的少数派用户名 `spencerwoo`）



这样，我们就可以用这样的语法来拼接一个 URL（注意第一个字符是 `?`，其他用 `&` 拼接）：

~~~
https://api.spencerwoo.com/substats/?source={目标服务名称}&queryKey={请求数据标签}
~~~

利用这样的语法，我们就可以进行数据请求啦。继续上面图示中的例子，比如我想要制作一个实时显示我自己的少数派关注数量的小牌子，我拼接成的 URL 即为：

~~~
https://api.spencerwoo.com/substats/?source=sspai&queryKey=spencerwoo
~~~

非常方便！这一 URL 会给我们返回类似下面的 JSON 结果：

~~~
{
  "status": 200,
  "data": {
    "totalSubs": 638,
    "subsInEachSource": {
      "sspai": 638
    },
    "failedSources": {}
  }
}
~~~

我们可以这样理解返回的 JSON 数据：

- `status` 是请求是否成功，成功即为 200（表示 HTTP OK）
- `data` 就是请求返回的数据（其中 `totalSubs` 表示总关注数量，`subsInEachSource` 表示每个服务请求到的粉丝数据，最后 `failedSources` 表示请求失败的数据源。）

可以看到我们所需要的字段即为 `$.data.totalSubs`，也就是 638 —— 我的少数派总关注人数。接下来，我们只需要告诉 Shields.io：

1. 我们请求的 URL 地址
2. 返回数据中所要的字段

这两个参数，即可成功制作一个动态小牌子。

##### 用 Shields.io 制作最终动态小牌子

我们继续借助 Shields.io 官网上面提供的「小牌子生成器」，这次我们稍微向下滚动，找到 Dynamic 版本「小牌子生成器」，并按照这样的规则依次操作：

1. 数据类型 `data type` 选择：JSON
2. 标签 `label` 填入：小牌子左侧的标签，比如 `少数派关注`
3. API 地址 `data url` 填入：我们刚刚的 API URL：`https://api.spencerwoo.com/substats/?source=sspai&queryKey=spencerwoo`
4. 请求字段 `query` 填入：我们 Substats API 数据中的这一字段：`$.data.totalSubs`
5. 标签颜色 `color` 填入：一个十六进制的颜色代码，比如少数派强调色：`da282a`
6. ……（余下的两个参数：前缀 `prefix` 和后缀 `suffix`，可以根据自己的需要自行定义）

##### 其他 Substats API 的功能和语法规则

另外，Substats API 还可以串联多个不同的数据源和它们对应的请求参数。比如，我同时请求少数派、知乎、GitHub 三个平台上面的关注，即可这样构造请求（多个 `source` 和 `queryKey` 组合按照顺序进行请求即可，顺序在请求过程中不会丢失）：

~~~
https://api.spencerwoo.com/substats/?source=sspai&queryKey=spencerwoo&source=zhihu&queryKey=spencer-woo-64&source=github&queryKey=spencerwooo
~~~

可以看到，上面的 URL 里，我直接串联了多个 `source` 和 `queryKey` 的请求组合，同时请求。这样我们就可以得到这三个平台上面关注者数量的总和 `totalSubs`，以及每个平台各自的关注者数量 `subsInEachSource`：

~~~
{
  "status": 200,
  "data": {
    "totalSubs": 1312,
    "subsInEachSource": {
      "sspai": 638,
      "zhihu": 361,
      "github": 313
    },
    "failedSources": {}
  }
}
~~~

那么，我们就可以直接用 Shields.io 构造一个如下的 SVG 小牌子：

~~~
https://img.shields.io/badge/dynamic/json?color=0084ff&label=%E5%B0%91%E6%95%B0%E6%B4%BE%7C%E7%9F%A5%E4%B9%8E%7CGitHub&query=%24.data.totalSubs&url=https%3A%2F%2Fapi.spencerwoo.com%2Fsubstats%2F%3Fsource%3Dsspai%26queryKey%3Dspencerwoo%26source%3Dzhihu%26queryKey%3Dspencer-woo-64%26source%3Dgithub%26queryKey%3Dspencerwooo
~~~

这样我们就可以直接得到三个平台总关注数量的一个「小牌子」。



同时，如果你想同时请求多个平台，但是平台中请求的数据标签名称是一样的，比如我们同时请求 Feedly 和 NewsBlur 两个 RSS 订阅服务里我自己的 RSS 链接 `https://blog.spencerwoo.com/posts/index.xml` 的订阅数量，那么我们可以：

- 直接用 `|` 将 `feedly` 和 `newsblur` 直接连接，传递给 `source` 作为参数
- 并将 RSS 链接传递给 `queryKey` 作为参数

从而构造这样的请求：

~~~
https://api.spencerwoo.com/substats/?source=feedly|newsblur&queryKey=https://blog.spencerwoo.com/posts/index.xml
~~~

这样，我们就可以直接得到两个平台同一个 RSS 源的总订阅数量：

~~~
{
  "status": 200,
  "data": {
    "totalSubs": 17,
    "subsInEachSource": {
      "feedly": 14,
      "newsblur": 3
    },
    "failedSources": {}
  }
}
~~~

从而制作表示 RSS 链接总订阅人数的「小牌子」。

### GitHub 统计卡片

当然，还可以再加一个 GitHub 统计卡片。

下面我是在**即刻员工** [Joway](https://link.zhihu.com/?target=https%3A//github.com/joway/joway) 的 profile 里发现的如下语法：

~~~
<img align="right" src="https://github-readme-stats.vercel.app/api?username=joway&show_icons=true&icon_color=CE1D2D&text_color=718096&bg_color=ffffff&hide_title=true" />
~~~

只需要把 username 改成自己的 GitHub 用户名，放在README.md的开头就可以了。