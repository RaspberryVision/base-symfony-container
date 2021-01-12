FROM php:7.4.4-apache
LABEL maintainer="kontakt@raspberryvision.pl"

RUN apt-get update \
    && apt-get install -y --no-install-recommends vim curl debconf subversion git apt-transport-https apt-utils \
    build-essential locales acl mailutils wget nodejs zip unzip \
    gnupg gnupg1 gnupg2 libxslt-dev zlib1g-dev librabbitmq-dev libpng-dev

### INSTALL AND ENABLE DOCKER PHP EXTENSIONS ###
RUN docker-php-ext-install mysqli pdo pdo_mysql gd bcmath intl sockets xsl

### INSTALL AMQP ###
RUN pecl install -o -f amqp && docker-php-ext-enable amqp

RUN pecl install mongodb && docker-php-ext-enable mongodb

### CHANGE ROOT DIRECTORY ###
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

### INSTALL COMPOSER ###
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
	mv composer.phar /usr/local/bin/composer

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
