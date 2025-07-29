# DNS server

FROM debian:bullseye

# Install Bind9 and necessary tools
RUN apt-get update && \
    apt-get install -y bind9 dnsutils \
    net-tools iproute2 iputils-ping tcpdump && \
    apt-get clean

# Copy config files (assumes you provide named.conf, zone files, etc.)
COPY named.conf /etc/bind/named.conf
COPY named.conf.options /etc/bind/named.conf.options
COPY named.conf.local /etc/bind/named.conf.local
COPY zones/ /etc/bind/zones/

COPY setup.sh /root/
RUN chmod +x /root/setup.sh

# Open DNS ports
EXPOSE 53/udp
EXPOSE 53/tcp

# Run bind9 in the foreground
CMD ["named", "-g"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
