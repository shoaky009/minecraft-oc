##如何使用
>推荐fork仓库之后修改完配置文件提交到远程仓库,
>然后通过脚本拉取增加效率
```shell script
#在os中运行下载以下脚本
wget https://gitee.com/sh0aky/minecraft-oc/transporter/raw/master/script
#运行默认拉取的仓库是https://gitee.com/sh0aky/minecraft-oc/transporter 
#github经过测试经常有些文件下载失败 如果服务器在国外可以考虑
#如果fork了想要拉取自己的仓库在script后面添加自己的仓库前缀
#e.g. 自定义仓库 script https://gitee.com/xxxxx/minecraft-oc/transporter/raw
#e.g. 自定义仓库和分支 script https://gitee.com/xxxxx/minecraft-oc/transporter/raw xxxx
#e.g. github script https://raw.githubusercontent.com/shoaky009/minecraft-oc/transporter xxxx
script
```

> 该程序用于不同物品传输一次只传输特定数量或传输最大能被整除的数量,否则不传输
> 并且定时检查输入, 如果有不符合的数量将会提取掉
