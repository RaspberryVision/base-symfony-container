#!/bin/sh

# Enable mod_rewrite for Apache2
a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp

# Apache config for localhost
sed -i '/Global configuration/a \
ServerName localhost \
' /etc/apache2/apache2.conf

# INSTALL COMPOSER DEP #
composer install

# RUN MIGRATIONS AND FIXTURES
php bin/console doctrine:database:create --no-interaction --if-not-exists
php bin/console doctrine:migrations:migrate --no-interaction
php bin/console assets:install --symlink --env=prod

# LOAD FIXTURES
php -d memory_limit=-1 bin/console doctrine:fixtures:load --no-interaction

# COMPILE FRONT ASSETS #
yarn install
yarn encore dev

# RUN EVENTS HANDLERS CONSUMER
nohup php bin/console messenger:consume async &

# RUN APACHE #
apache2-foreground
