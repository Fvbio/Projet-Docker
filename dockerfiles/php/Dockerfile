FROM php:8.1-fpm

# Installation des dépendances système
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Création de l'utilisateur www
RUN groupadd -g 1000 www && useradd -u 1000 -ms /bin/bash -g www www

# Définition du répertoire de travail
WORKDIR /var/www/html

# Changement des permissions
RUN chown -R www:www /var/www/html

# Utilisateur par défaut
USER www

# Exposition du port
EXPOSE 9000

# Commande par défaut
CMD ["php-fpm"]