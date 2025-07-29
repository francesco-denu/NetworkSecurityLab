#SWITCH 2

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y openvswitch-switch iproute2 net-tools tcpdump && \
    apt-get clean

COPY setup.sh /root/
RUN chmod +x /root/setup.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]

