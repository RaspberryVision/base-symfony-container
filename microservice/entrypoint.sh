#!/bin/sh

# Enable mod_rewrite for Apache2
a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp

# Apache config for localhost
sed -i '/Global configuration/a \
ServerName localhost \
' /etc/apache2/apache2.conf

# INSTALL COMPOSER DEP #
composer install

# RUN APACHE #
apache2-foreground
