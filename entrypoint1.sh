set -e
cd /var/www/html

echo "[php1] Installing Composer dependencies..."
composer install --no-dev --optimize-autoloader

echo "[php1] Installing & building frontend assets..."
npm install
npm run build

php artisan config:clear

if grep -q '^APP_KEY=$' .env || ! grep -q '^APP_KEY=base64:' .env; then
  echo "[php1] No APP_KEY found → generating key and resetting DB"
  php artisan key:generate --force
  php artisan migrate:fresh --seed --force
else
  echo "[php1] APP_KEY already exists → skipping keygen and migrations"
fi

echo "[php1] Starting PHP-FPM..."
exec php-fpm