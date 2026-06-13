# ============================================
# Stage 1: Build frontend assets
# ============================================
FROM node:20-alpine AS frontend

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit

COPY resources/css ./resources/css
COPY resources/js ./resources/js
COPY vite.config.js jsconfig.json ./
RUN npm run build

# ============================================
# Stage 2: PHP application
# ============================================
FROM php:8.4-fpm-alpine AS app

# Install system dependencies
RUN apk add --no-cache \
    bash \
    git \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    icu-dev \
    linux-headers \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        xml \
        intl \
        opcache \
    && pecl install redis \
    && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install npm (needed for some Laravel packages)
RUN apk add --no-cache nodejs npm

# Create non-root user
RUN addgroup -g 1000 -S www && adduser -u 1000 -S www -G www

# Set working directory
WORKDIR /var/www/html

# Copy only what's needed for Composer install
COPY composer.json composer.lock ./

# Install PHP dependencies (dev for build stage, will be reinstalled without dev later)
RUN composer install --no-scripts --no-autoloader --prefer-dist

# Copy application code
COPY . .

# Install remaining Composer deps and optimize
RUN composer dump-autoload --optimize --no-dev \
    && composer install --no-dev --optimize-autoloader --no-scripts

# Copy frontend build assets from stage 1
COPY --from=frontend /app/public/build ./public/build

# Set permissions
RUN chown -R www:www /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# PHP configuration for production
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# OPcache configuration
RUN echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.memory_consumption=256" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.interned_strings_buffer=16" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.max_accelerated_files=20000" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.validate_timestamps=0" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.save_comments=1" >> /usr/local/etc/php/conf.d/opcache.ini

USER www

EXPOSE 9000

CMD ["php-fpm"]
