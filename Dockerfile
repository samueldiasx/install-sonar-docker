FROM php:8.0.5-fpm-alpine

WORKDIR /var/www/html

RUN apk update && apk add --no-cache\
    git \
    curl \
    zip \
    unzip \
    wget \
    openjdk11-jre \
    libpng-dev

RUN docker-php-ext-install\
    pdo_mysql \
    gd

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

# installing xdebug
RUN apk update && apk add --no-cache $PHPIZE_DEPS\
    && pecl install xdebug-3.1.5 \
    && docker-php-ext-enable xdebug

RUN echo "xdebug.mode=develop,debug,coverage" >> "${PHP_INI_DIR}/conf.d/xdebug.ini";

# Download and Install sonar-scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747.zip && \
    unzip sonar-scanner-cli-4.7.0.2747.zip && \
    rm -rf sonar-scanner-cli-4.7.0.2747.zip && \
    mv sonar-scanner-4.7.0.2747 /usr/lib/sonar-scanner && \
    ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

#increase memory limit
# RUN echo 'memory_limit = 1024M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

# Install redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

