FROM ubuntu:22.04

RUN mkdir -p /mygameproject3
COPY . /mygameproject3
WORKDIR /mygameproject3

RUN apt install gcc g++ make cmake -y
RUN apt install protobuf-compiler libprotobuf-dev -y
RUN apt install lua5.3 -y
RUN apt install liblua5.3-dev -y
RUN apt install mysql-server -y
RUN apt install libmysqlclient-dev -y
RUN apt install libtolua++5.1-dev -y
RUN apt install sqlite3 -y
RUN apt install libsqlite3-dev -y

WORKDIR /mygameproject3
cd Proto
sh gen_cpp.sh

WORKDIR /mygameproject3/Server/Src
sh buildall.sh

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["echo end"]
