#!/bin/bash
set -e
cd /var/www/html

echo "[php2] Installing Composer dependencies..."
composer install --no-dev --optimize-autoloader

echo "[php2] Installing & building frontend assets..."
npm install
npm run build

php artisan config:clear

# ➤ Si pas de APP_KEY → on génère uniquement la clé
if grep -q '^APP_KEY=$' .env || ! grep -q '^APP_KEY=base64:' .env; then
  echo "[php2] No APP_KEY found → generating key"
  php artisan key:generate --force
else
  echo "[php2] APP_KEY already exists → skipping keygen"
fi

echo "[php2] Starting PHP-FPM..."
exec php-fpm