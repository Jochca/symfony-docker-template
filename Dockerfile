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
