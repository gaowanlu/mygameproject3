cd ServerEngine && make -j4
cd ..
cd CenterServer && make -j4
cd ..
cd GameServer && make -j4
cd ..
cd LogicServer && make -j4
cd ..
cd LoginServer && make -j4
cd ..
cd ProxyServer && make -j4
cd ..
cd AccountServer && make -j4
cd ..
cd DBServer && make -j4
cd ..
cd LogServer && make -j4
cd ..
cp ./CenterServer/CenterServer ./Linux/
cp ./GameServer/GameServer ./Linux/
cp ./LogicServer/LogicServer ./Linux/
cp ./LoginServer/LoginServer ./Linux/
cp ./ProxyServer/ProxyServer ./Linux/
cp ./AccountServer/AccountServer ./Linux/
cp ./DBServer/DBServer ./Linux/
cp ./LogServer/LogServer ./Linux/

 
