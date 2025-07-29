# SERVER 1 - CALCULATOR

FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    iproute2 iputils-ping net-tools \
    apache2=2.4.* \
    php7.4 \
    libapache2-mod-php7.4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod php7.4

COPY setup.sh /root/
RUN chmod +x /root/setup.sh

COPY dir.conf /etc/apache2/mods-enabled/dir.conf
COPY webapp/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
