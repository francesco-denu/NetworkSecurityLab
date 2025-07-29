#ROUTER1
FROM vyos
#FROM francescodenu/vyos:latest
#FROM vyos:latest

COPY setup.sh /root/
COPY config.sh /home/vyos/

# the following is done from run.sh
#RUN chmod +x /root/setup.sh 
#RUN chmod 777 /home/vyos/config.sh 

# VyOS usually uses /sbin/init to start, so we don't need to override ENTRYPOINT

