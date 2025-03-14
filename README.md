Game Engine Frame
===============

原项目地址 https://github.com/ylmbtm/GameProject3 , 本仓库是可以在ubuntu22下轻松使用最新版本的库和工具进行编译，运行的代码仓库。

跨平台的多进程游戏服务器框架，网络层分别使用SocketApi, Boost Asio, Libuv三种方式实现， 
框架内使用共享内存，无锁队列，对象池，内存池来提高服务器性能。

还有一个不断完善的Demo客户端，游戏包含大量完整资源，坐骑，宠物，伙伴，装备, 这些均可上阵和穿戴, 并可进入副本战斗，多人玩法也己实现,
Demo客户端地址: https://github.com/ylmbtm/DemoClient

## 使用 play-with-docker.com

https://labs.play-with-docker.com/

```bash
docker run -it ubuntu:22.04
```

## 服务器在 Ubuntu22.04 部署启动说明

[Ubuntu22](./Server/Src/Linux/linux_build.md)

环境准备

```bash
apt install gcc g++ make cmake -y
apt install protobuf-compiler libprotobuf-dev -y
apt install lua5.3 -y
apt install liblua5.3-dev -y
apt install mysql-server -y
apt install libmysqlclient-dev -y
apt install libtolua++5.1-dev -y
dpkg -L libtolua++5.1-dev | grep '\.h$'
apt install sqlite3 -y
apt install libsqlite3-dev -y

cd Proto
sh gen_cpp.sh
cd Server/Src
sh buildall.sh
```

数据库环境

```bash
mysql -u root
CREATE USER 'root'@'127.0.0.1' IDENTIFIED BY '123456';
SELECT User,Host FROM mysql.user WHERE User = 'root';
cd Server
mysql -uroot < db_create.sql
mysql -uroot
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
```

各进程

```bash
root@kTY-HK3-QL-86139:/home/root/game/gameproject3# cd Server/Src/Linux
root@kTY-HK3-QL-86139:/home/root/game/gameproject3/Server/Src/Linux# ll | grep Server
-rwxr-xr-x  1 root root 13054592 Mar 14 04:09 AccountServer*
-rwxr-xr-x  1 root root 11219816 Mar 14 04:09 CenterServer*
-rwxr-xr-x  1 root root 12335648 Mar 14 04:09 DBServer*
-rwxr-xr-x  1 root root 18504512 Mar 14 04:09 GameServer*
-rwxr-xr-x  1 root root 11169072 Mar 14 04:09 LogServer*
-rwxr-xr-x  1 root root 26672704 Mar 14 04:09 LogicServer*
-rwxr-xr-x  1 root root 12183496 Mar 14 04:09 LoginServer*
-rwxr-xr-x  1 root root 11228928 Mar 14 04:09 ProxyServer*
```

各进程日志在

```bash
root@kTY-HK3-QL-86139:/home/root/game/gameproject3/Server/Src/Linux/log# ll -lrt
total 92
drwxr-xr-x 6 root root  4096 Mar 14 06:16 ../
-rw-r--r-- 1 root root   135 Mar 14 06:16 CenterServer-250314-061602.log
-rw-r--r-- 1 root root   392 Mar 14 06:16 LogServer-250314-061602.log
-rw-r--r-- 1 root root   466 Mar 14 06:16 DBServer-250314-061602.log
-rw-r--r-- 1 root root   249 Mar 14 06:16 LogicServer-250314-061602.log
-rw-r--r-- 1 root root   659 Mar 14 06:16 LoginServer-250314-061602.log
-rw-r--r-- 1 root root   638 Mar 14 06:16 AccountServer-250314-061602.log
-rw-r--r-- 1 root root 26306 Mar 14 06:16 GameServer-250314-061602.log
-rw-r--r-- 1 root root   135 Mar 14 06:18 CenterServer-250314-061838.log
drwx------ 2 root root  4096 Mar 14 06:18 ./
-rw-r--r-- 1 root root   392 Mar 14 06:18 LogServer-250314-061838.log
-rw-r--r-- 1 root root   249 Mar 14 06:18 LogicServer-250314-061838.log
-rw-r--r-- 1 root root   466 Mar 14 06:18 DBServer-250314-061838.log
-rw-r--r-- 1 root root   659 Mar 14 06:18 LoginServer-250314-061838.log
-rw-r--r-- 1 root root   638 Mar 14 06:18 AccountServer-250314-061838.log
-rw-r--r-- 1 root root  8191 Mar 14 06:18 GameServer-250314-061838.log
```

进程配置文件

```bash
root@kTY-HK3-QL-86139:/home/root/game/gameproject3/Server/Src/Linux# rm -rf ./*.o
root@kTY-HK3-QL-86139:/home/root/game/gameproject3/Server/Src/Linux# ls
AccountServer  LogServer    ProxyServer 
CenterServer   LogicServer  Skill(技能配置xml)    
Config.db(sqlite数据库文件)     LoginServer  log(日志目录)    servercfg.ini(各进程配置)
DBServer       Lua(Lua脚本)     startserver.sh(启动所有进程)
GameServer     Map(地图配置xml) stopserver.sh(关闭所有进程)
```

## 服务器各进程说明

```bash
1. 登录服务器(LoginServer)  说明 : 接受玩家的登录连接， 处理登录请求消息。
2. 账号服务器(AccountServer)说明 : 处理账号登录的验证，新账号的创建，账号的数据库保存。
3. 中心服务器(CenterServer) 说明 : 用于跨服活动， 跨服战需求。
4. 逻辑服务器(LogicServer)  说明 : 处理玩家角色的逻辑数据，处理玩家角色的一般逻辑功能。
5. 游戏服务器(GameServer)   说明 : 处理玩家移动同步，技能，buff等作战功能。
6. 数据服务器(DBServer)     说明 : 作为逻辑服和mysql数据库之间的代理服务器，负责定期将玩家的数据写入数据库。
7. 网关服务器(ProxyServer)  说明 : 作为客户端和逻辑服，战场服之间的中转服务器，主要负责消息的转发。
8. 日志服务器(LogServer)    说明 : 日志服务器 主要负责逻辑服运营日志的写入mysql数据库。
9. 监视服务器(WatchServer)  说明 : 主要负责接受WEB后台的控制命令， 控制服务器。
```
