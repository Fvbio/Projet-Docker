#!/bin/bash

cd /var/www/html

# Install Laravel deps
composer install --no-dev --optimize-autoloader

# Build assets
npm install
npm run build

# Génération de clé et migration
php artisan config:clear

if ! grep -q "^APP_KEY=$" .env; then
  echo "Génération de la clé APP_KEY..."
  php artisan key:generate --force
else
  echo "Clé APP_KEY déjà présente, aucune génération nécessaire."
fi


php artisan migrate:fresh --seed --force

# Démarre php-fpm
exec php-fpm