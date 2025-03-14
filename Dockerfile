FROM ubuntu:22.04
RUN mkdir -p /mygameproject3
COPY . /mygameproject3
WORKDIR /mygameproject3
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install gcc g++ make cmake -y
RUN apt-get install protobuf-compiler libprotobuf-dev -y
RUN apt-get install lua5.3 -y
RUN apt-get install liblua5.3-dev -y
RUN apt-get install mysql-server -y
RUN apt-get install libmysqlclient-dev -y
RUN apt-get install libtolua++5.1-dev -y
RUN apt-get install sqlite3 -y
RUN apt-get install libsqlite3-dev -y

WORKDIR /mygameproject3/ Proto
RUN sh gen_cpp.sh

WORKDIR /mygameproject3/Server/Src
RUN sh buildall.sh

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["echo end"]
