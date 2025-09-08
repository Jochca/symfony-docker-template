FROM php:8.3-fpm-alpine AS builder

# Install system dependencies required for building PHP extensions and running Composer
RUN apk add --no-cache \
    bash \                     # Shell for development tools and scripts \
    git \                      # Required for Composer to fetch VCS packages \
    zip unzip \                # Required for zipping/unzipping during Composer install \
    icu-dev \                  # Required for the intl extension (internationalization) \
    libzip-dev \               # Required for the zip extension \
    oniguruma-dev \            # Required for mbstring (multi-byte string support) \
    postgresql-dev \           # Required for pdo_pgsql extension (PostgreSQL support) \
    $PHPIZE_DEPS               # PHP build tools: autoconf, gcc, make, etc.

# Install common PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \       # PostgreSQL driver \
    intl \            # Internationalization support \
    zip \             # Support for .zip archive functions \
    mbstring \        # MultiCzyli -byte string functions (required by many libs) \
    opcache           # Opcode caching (improves performance in production)

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

# Set working directory inside the container
WORKDIR /var/www/html

# Copy the built app (code + vendor) from the builder stage
COPY --from=builder /var/www/html /var/www/html

# Expose port (for documentation only; Compose handles real mapping)
EXPOSE 9000

# Start PHP-FPM by default
CMD ["php-fpm"]
