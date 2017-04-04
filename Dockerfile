# ssr-with-net-speeder

FROM FROM centos:latest

RUN yum install python python-pip python-m2crypto libnet1-dev libpcap0.8-dev libnet libpcap libnet-devel libpcap-devel git gcc -y
RUN git clone https://github.com/snooda/net-speeder.git net-speeder
RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git ssr
WORKDIR net-speeder
RUN chmod +x build.sh
RUN ./build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

# Start Net Speeder
#CMD ["nohup /usr/local/bin/net_speeder venet0 \"ip\" >/dev/null 2>&1 &"]

#Test 
#CMD ["ping www.baidu.com -c 5"]


# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
