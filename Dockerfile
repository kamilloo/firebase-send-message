FROM php:8.2-cli

LABEL authors="kamil"

WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    wget \
    gcc \
    make \
    autoconf

# Install Xdebug extension
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Set up Xdebug configuration
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the user to non-root (example: user with UID 1000)
ARG USER_ID=1001
RUN useradd -m -u ${USER_ID} dockeruser

# Change ownership of the working directory to the created user
RUN chown -R dockeruser:dockeruser /app

# Switch to the created user
USER dockeruser

ENTRYPOINT ["top", "-b"]