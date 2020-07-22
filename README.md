# cnblogs-iOS

这是一个博客园练手项目，主要使用的是 Swift 语言

## 2020.7.22 
以前准备拆分组件化方式来处理的，但是由于以下原因，一直没有实施

+ 项目规模实在很小，没有进行组件化的必要
+ 个人很懒

预备后期完成功能之后，在进行拆分吧



## 功能

+ Home（首页）
+ Compose （闪存）
+ Problem （博问）
+ Mine（我）
+ 其他页面,例如 Login 等 


1. 原则：
 尽可能的使用不同的方案/技术实现对应的模块功能


## Login 

+ Login 采用 PKHUD 的加载组件
+ Login 使用 WKWebView 进行登录页面展示
+ Login 使用自动注入脚本注入账号密码

### 相关的issue

https://stackoverflow.com/questions/58321114/why-i-get-the-console-warning-process-kill-returned-unexpected-error-1-when



