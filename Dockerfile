FROM drupal:8.8-apache

RUN apt-get update && apt-get install -y \
  curl \
  git \
  mysql-client \
  unzip \
  vim \
  git \
  wget

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

RUN php -r "copy ('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php composer-setup.php && \
  mv composer.phar /usr/local/bin/composer && \
  php -r "unlink('composer-setup.php');"

RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.4.2/drush.phar && \
  chmod +x drush.phar && \
  mv drush.phar /usr/local/bin/drush

RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'memory_limit = 3G' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

RUN rm -rf /var/www/html/*

COPY apache-drupal.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /app
