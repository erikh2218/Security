#!/bin/bash
set -e

if [ -d "/var/www/security/storage" ]; then
    chmod -R 775 /var/www/security/storage
    chown -R www-data:www-data /var/www/security/storage
fi

if [ -d "/var/www/security/bootstrap/cache" ]; then
    chmod -R 775 /var/www/security/bootstrap/cache
    chown -R www-data:www-data /var/www/security/bootstrap/cache
fi

if [ ! -d "vendor" ]; then
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

if [ -f "artisan" ]; then
    php artisan optimize:clear
fi

exec "$@"