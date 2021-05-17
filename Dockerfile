FROM alpine
RUN apk add --no-cache mysql-client apache2 php php-mysqli php-ldap php7-mcrypt php-cli php-soap php-json graphviz php-xml php-gd php-zip php-apache2 php7-dom php7-iconv php7-session php7-simplexml php7-mbstring php7-tokenizer
ENV ITOPURL=https://sourceforge.net/projects/itop/files/latest/download
RUN wget -q $ITOPURL -O /tmp/itop.zip && unzip /tmp/itop.zip -d /tmp/itop && mv /tmp/itop/web/* /var/www && rm -f /tmp/itop.zip && rm -fr /tmp/itop && sed -i -E "s/\/var\/www\/localhost\/htdocs/\/var\/www/" /etc/apache2/httpd.conf && chown -R apache:apache /var/www
RUN wget -q https://sourceforge.net/projects/teemip/files/teemip%20-%20an%20iTop%20module/2.7.1/teemip-core-ip-mgmt-2.7.1-802.zip/download  -O /tmp/ipam.zip && unzip /tmp/ipam.zip -d /tmp/ipam && mv /tmp/ipam/* /var/www/extensions/ && chown -R apache:apache /var/www
CMD ["httpd", "-D", "FOREGROUND"]
