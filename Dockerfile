FROM php:7.3.13-apache
LABEL maintainer="kontakt@raspberryvision.pl"

RUN apt-get update \
    && apt-get install -y --no-install-recommends vim curl debconf subversion git apt-transport-https apt-utils \
    build-essential locales acl mailutils wget nodejs zip unzip \
    gnupg gnupg1 gnupg2 libxslt-dev

### INSTALL AND ENABLE DOCKER PHP EXTENSIONS ###
RUN docker-php-ext-install xsl

### CHANGE ROOT DIRECTORY ###
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

### INSTALL COMPOSER ###
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
	mv composer.phar /usr/local/bin/composer

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
