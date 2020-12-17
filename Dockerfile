FROM ubuntu:bionic
RUN apt-get update; apt-get install -y apache2 net-tools curl dnsutils rsync vim
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=US/ST=KY/L=Gtown/O=Example Gtown Company/CN=exampleGtown.com" -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -addext subjectAltName=DNS:localhost,DNS:mylamedomain.org,IP:127.0.0.1
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=US/ST=KY/L=Gtown/O=Example Gtown Company/CN=exampleGtown.com" -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt 
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
COPY ssl-params.conf /etc/apache2/conf-available/ssl-params.conf
COPY dev.conf /etc/apache2/sites-available/dev.conf
COPY index.html /var/www/html/index.html
RUN a2enmod ssl
RUN a2enmod headers
RUN a2enconf ssl-params.conf
RUN a2ensite dev.conf
CMD ["apachectl", "-D","FOREGROUND"]
EXPOSE 80
EXPOSE 443
