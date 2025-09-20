FROM php:8.3-fpm-alpine AS builder

# Install system dependencies required for building PHP extensions and running Composer
RUN apk add --no-cache \
    bash \
    git \
    zip unzip \
    icu-dev \
    libzip-dev \
    oniguruma-dev \
    postgresql-dev \
    autoconf \
    dpkg-dev \
    dpkg \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pkgconf \
    re2c

# Install common PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    intl \
    zip \
    mbstring \
    opcache

# Install Composer by copying the binary from the official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory inside the container
WORKDIR /var/www/html

# Copy Symfony project files into the container
COPY ./app/ /var/www/html

# Install PHP dependencies with Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set proper permissions (only if running as non-root later)
RUN chown -R www-data:www-data /var/www/html

FROM php:8.3-fpm-alpine AS runtime

RUN apk add --no-cache $PHPIZE_DEPS linux-headers \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Set working directory
WORKDIR /var/www/html

# Copy files from the builder stage
COPY --from=builder /var/www/html /var/www/html

# Change ownership to the non-root user
# (Symfony needs write access to var/, cache/, logs/)
RUN chown -R www-data:www-data /var/www/html

# Switch to non-root user for security
# Prevent the container from running as root in production
USER www-data

# Expose the FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
