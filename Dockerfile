FROM ubuntu:xenial
RUN apt-get update  -y
RUN apt-get upgrade  -y
RUN apt-get install software-properties-common python autotools-dev autoconf automake apt-utils -y
RUN apt-get install build-essential libssl-dev libdb-dev libdb++-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev  -y
RUN apt-get install git libssl-dev libtool supervisor -y
RUN apt-get install libdb-dev libdb++-dev libminiupnpc-dev libevent-dev libcrypto++-dev libgmp3-dev  -y
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

#RUN apt-get install ufw  -y
#RUN ufw allow 80/tcp
#RUN ufw allow 22/tcp
#RUN ufw allow 15150/tcp
#RUN ufw allow 15151/tcp
#RUN ufw --force enable

#RUN dd if=/dev/zero of=/swapfile bs=1M count=512
#RUN mkswap /swapfile
#RUN swapon /swapfile
#RUN echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

RUN cd ~
#RUN git clone https://github.com/taoblockchain/tao-core
#RUN cd ~/tao-core/src/leveldb
#RUN chmod 755 build_detect_platform
#RUN make libleveldb.a libmemenv.a

#cd ../secp256k1
#./autogen.sh
#./configure
#make
#make clean
#
####Clone TAO Github - Build taod####
RUN cd tao-core/src && make -f makefile.unix && strip taod && mv taod /usr/bin/
#
####Create tao.conf####
COPY conf.d /etc/supervisor/conf.d 
#RUN mkdir /root/.Tao
RUN config="/root/.Tao/tao.conf" &&  touch $config && echo "txindex=1" > $config && echo "listen=1" >> $config && echo "server=1" >> $config && echo "daemon=1" >> $config && echo "port=15150" >> $config && echo "rpcport=15151" >> $config && echo "maxconnections=256" >> $config && randUser=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30` && randPass=`< /dev/urandom tr -dc A-Za-z0-9 | head -c30` && echo "rpcuser=$randUser" >> $config && echo "rpcpassword=$randPass" >> $config && echo "RPC User: $randUser" && echo "RPC Password: $randPass"

#RUN touch tempcron
#RUN echo "@reboot taod" >> tempcron
#RUN crontab tempcron
#RUN rm tempcron

