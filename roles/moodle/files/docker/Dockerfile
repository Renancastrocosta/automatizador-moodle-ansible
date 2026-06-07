FROM php:8.3-fpm

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpq-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install \
    pdo_pgsql \
    pgsql \
    zip \
    intl \
    xml \
    gd

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev

#RUN docker-php-ext-install pdo pdo_pgsql zip

WORKDIR /var/www/html

RUN git clone --depth 1 --branch MOODLE_405_STABLE \
    https://github.com/moodle/moodle.git .

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
