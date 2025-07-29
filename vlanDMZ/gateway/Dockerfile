#GATEWAY 

FROM debian:bullseye
# FROM nginx:alpine

# Install Nginx and basic networking tools
RUN apt-get update && \
    apt-get install -y nginx iputils-ping net-tools curl iproute2 tcpdump nano dnsutils && \
    apt-get clean


COPY setup.sh /root/
COPY loadbalancer.conf /etc/nginx/sites-available/loadbalancer.conf
RUN chmod +x /root/setup.sh

RUN mkdir -p /etc/nginx/ssl/utils.com
COPY utils.crt /etc/nginx/ssl/utils.com/utils.crt
COPY utils.key /etc/nginx/ssl/utils.com/utils.key

# Remove default Nginx config
#RUN rm /etc/nginx/sites-enabled/default

# Copy custom nginx.conf (place it alongside this Dockerfile)
#COPY nginx.conf /etc/nginx/nginx.conf


# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]



