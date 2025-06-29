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

# Migration uniquement si la table "migrations" n'existe pas
if [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "Exécution des migrations sur php_app1"
  if ! php artisan migrate:status | grep -q 'Yes'; then
    php artisan migrate:fresh --seed --force
  else
    echo "Migrations déjà présentes"
  fi
else
  echo "Pas de migration sur ce container"
fi

# Démarre php-fpm
exec php-fpm