From php:7.0-apache
RUN apt-get update & apt-get upgrade -y
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get install vim -y
Copy index.html /var/www/html
expose 80