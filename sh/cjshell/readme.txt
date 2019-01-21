#####################################################
####hanxiaole 20180731    cjshell hpb console test
#####################################################

sudo apt-get install tcl tk expect

cjshell.20180727.0.tar.gz  放在/go-hpb/build/bin

tar zxvf cjshell.20180727.0.tar.gz

./cjshell/autoacctest.sh

cd testnode/ 
启动脚本说明
1 启动脚本为bootnode
2 启动脚本为prenode 初始有余额
3 启动脚本至10为prenode初始无余额 

说明如下：
开发人员可用./cjshell/autoacctest.sh自动化初始数据
第一个账户为BOOTNODE 第二个账户到七个账户为挖矿账户
第二个账户初始有余额
自动找hnode，写入程序自动编绎
自动生成1至10启动免输入密码，名输入miner.start脚本
20180802自动成生config.json


##运维人员在有ghpb,promfile与cjshell同一目录下执行./cjshell/batautoacc.sh
20180812 新增自动生成110个账户前10个账户为bootnode,共10个
20180812 新增自动生成从第11个账户至42账户为prenode,共32个
20180812 第11个账户初始有余额,其它没有
20180812 自动找10个账户的hnode，写入程序自动编绎
20180812 自动生成1至110节点启动免输入密码，名输入miner.start脚本
20180812 自动成生32个prenode添入config.json
先执行command.txt里的put所有行,ssh所有行,get所有行

20180813##优化批量上传远程服务器内容BUG
20180813##自动生成启动脚本nohup启动 并logs目录生成ghpb进程日志
20180813##自动生成启动脚本tail -f 查看日志
20180813##自动生成启动脚本attach nohup启动节点操作台

20180815##新增自动适应promfile,Please input the initialization hardware random

20180819##修正自动化创建账户shell脚本代码冗余，优化代码提升可读性与处理效率。
20180819##batautoacc.sh脚本原来支持110个账户升级为自动创建210个账户
20180819##autoacctest.sh自动化创建10个账户，net端囗防止重复功能

20180821##新增自动生成启动脚本增加--testmode参数
