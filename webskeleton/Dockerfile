FROM php:7.4.4-apache
LABEL maintainer="kontakt@raspberryvision.pl"

RUN apt-get update \
    && apt-get install -y --no-install-recommends vim curl debconf subversion git apt-transport-https apt-utils \
    build-essential locales acl mailutils wget nodejs zip unzip \
    gnupg gnupg1 gnupg2 libxslt-dev zlib1g-dev libpng-dev libjpeg-dev libwebp-dev libjpeg62-turbo-dev libpng-dev \
    libxpm-dev libfreetype6-dev libmagickwand-dev

### INSTALL AND ENABLE DOCKER PHP EXTENSIONS ###
RUN docker-php-ext-install mysqli pdo pdo_mysql gd bcmath intl sockets

### CHANGE ROOT DIRECTORY ###
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

### INSTALL NODE JS ###
RUN	echo "deb https://deb.nodesource.com/node_9.x jessie main" >> /etc/apt/sources.list.d/nodejs.list && \
	wget -nv -O -  https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
	echo "deb-src https://deb.nodesource.com/node_9.x jessie main" >> /etc/apt/sources.list.d/nodejs.list && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list && \
	apt-get update && \
	apt-get install -y --force-yes nodejs yarn && \
	rm -f /etc/apt/sources.list.d/nodejs.list

### INSTALL COMPOSER ###
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
	mv composer.phar /usr/local/bin/composer

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
