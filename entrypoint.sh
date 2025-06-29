#!/bin/bash

cd /var/www/html

# Install Laravel deps
composer install --no-dev --optimize-autoloader

# Build assets
npm install
npm run build

# Génération de clé et migration
php artisan config:clear
php artisan key:generate --force
php artisan migrate:fresh --seed --force

# Démarre php-fpm
exec php-fpm