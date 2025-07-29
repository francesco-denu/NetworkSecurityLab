#HOST 1

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y iproute2 iputils-ping net-tools dnsutils && \
    apt-get clean

COPY setup.sh /root/
RUN chmod +x /root/setup.sh 

ENTRYPOINT ["tail", "-f", "/dev/null"]

