FROM php:7.4-fpm-alpine

RUN apk update && apk add --no-cache\
    zip \
    unzip \
    wget \
    openjdk11-jre 

RUN apk update && apk add --no-cache $PHPIZE_DEPS\
    && pecl install xdebug-2.9.2 \
    && docker-php-ext-enable xdebug

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

# Download and Install sonar-scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472.zip && \
    unzip sonar-scanner-cli-4.6.2.2472.zip && \
    rm -rf sonar-scanner-cli-4.6.2.2472.zip && \
    mv sonar-scanner-4.6.2.2472 /usr/lib/sonar-scanner && \
    ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner
    
#increase memory limit 
RUN echo 'memory_limit = 1024M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

WORKDIR /var/www