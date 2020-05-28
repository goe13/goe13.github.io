+++
title = "零星碎片"
date = "2019-09-24T07:50:50+08:00"
hide_authorbox = true
disable_comments = true
draft = false
tags = ['linux']
categories = [
    "IT"
]
+++
[TOC]

#### 自动登陆脚本
```bash
#!/usr/bin/expect
set timeout 30
spawn ssh -p [lindex $argv 0] [lindex $argv 1]@[lindex $argv 2]
expect {
        "*(yes/no)?"
        {send "yes\n";exp_continue}
        "*assword:"
        {send "[lindex $argv 3]\n"}
}
interact
```

#### ssh 免密登陆
1. 生成密钥对
```bash
ssh-keygen -t rsa -C m4a1player@126.com
```
2. 服务器添加免密文件
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub root@1.1.1.1
or
cat ~/.ssh/id_rsa.pub >> root@1.1.1.1:~/.ssh/authorized_keys
```
3. 本机配置
```bash
nvim ~/.ssh/config
Host aaaa
    > HostName 1.1.1.1
    > User root
    > Port 22
    > IdentityFile ~/.ssh/id_rsa
```
4. ssh aaaa 登陆
5. 重设ssh私钥密码
```bash
ssh-keygen -f id_rsa -p
```

#### ">" "/dev/null" "0,1,2" 说明
```
/dev/null 空设备文件
> 输出重定向
0 输入
1 输出
2 错误
xxx > /dev/null 2 > &1 
```

#### nginx 负载均衡使用
```nginx
http {
    upstream group1{
        server 192.168.1.1:80 weight=1;
        server 192.168.1.2:80 weight=1;
    }
    server{
        location /a/ {
            proxy_pass http://group1/;
        }
    }
}
```
#### 新版本GIT
```bash
yum install -y epel-release  
~~rpm -ivh https://centos7.iuscommunity.org/ius-release.rpm~~
rpm -ivh https://repo.ius.io/ius-release-el7.rpm
yum list git2u  
yum install -y git2u  
git --version 
```
#### npm源问题
<https://www.jianshu.com/p/010e47ed2bfd?tdsourcetag=s_pcqq_aiomsg>
```
#npm
npm install 包的名字 --registry https://registry.npm.taobao.org
npm config get registry
npm config set registry https://registry.npm.taobao.org
npm install -g nrm
nrm ls
nrm use taobao
nrm test
#yarn
yarn save 包的名字 --registry https://registry.npm.taobao.org/
yarn config get registry
yarn config set registry https://registry.npm.taobao.org/
npm install -g yrm
yrm ls
yrm use taobao
yrm test
#cgr
npm install -g cgr
```
#### jenkins
```bash
docker pull jenkins/jenkins
chown 1000 /home/www/jenkins
docker run -d  -p 8090:8080 -p 50001:50000 -v `pwd`/jenkins:/var/jenkins_home --env JAVA_OPTS="-Duser.timezone=GMT+08" --privileged=true --name myjenkins jenkins/jenkins
docker logs -f myjenkins
"password like this :6******************************e"
docker inspect 4**********d

```
#### rails
```bash
ruby 安装
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm install 2.6.3
gem install solargraph
gem install rails

fix:sqlite3.7
gem install sqlite3 -- --with-sqlite3-lib=/usr/local/sqlite/lib
```
#### oh-my-zsh
```bash
cat /etc/shells
yum install zsh -y
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### Window10 包管理 scoop
* 用户名不含中文字符
* Windows 7 SP1+ / Windows Server 2008+
* PowerShell 3+
* .NET Framework 4.5+
产看版本：
```powershell
$PSVersionTable.PSVersion.Major   #查看Powershell版本
$PSVersionTable.CLRVersion.Major  #查看.NET Framework版本
```
安装scoop
```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```
常用
```powershell
scoop install aria2
scoop search git
```

#### Centos7 其它rpm源
rpmfusion提供了，在Fedora和 centos 源之外的其他yum 源
`Centos 7`
```bash
yum localinstall -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
```
`yum install ffmpeg`

#### homebrew 设置代理
```
alias proxy_ss='export all_proxy=socks5://127.0.0.1:1086'
alias proxy_v2ray='export all_proxy=socks5://127.0.0.1:1081'
alias proxy_clashx='export all_proxy=socks5://127.0.0.1:7891'
alias unproxy='unset all_proxy'
```

批量删除进程
```bash
ps -ef |grep 41230 | grep -v grep | awk '{print $2}'| xargs kill -9
```
- ps ： 报告当前进程的快照
- kill ： 向一个进程发出信号
- killall ： 按名字消灭进程
- pkill ： 根据名字和其它属性查看或者发出进程信号
- skill ： 发送一个信号或者报告进程状态
- xkill ： 按照X资源消灭一个客户程序