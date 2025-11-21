FROM php:8.2-cli

# Installer les extensions PDO et MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Définir le dossier de travail dans le container
WORKDIR /var/www/html

# Copier tout le code du projet dans le container
COPY . /var/www/html

# Exposer le port 80
EXPOSE 80

# Commande par défaut pour démarrer le serveur PHP avec router.php
CMD ["php", "-S", "0.0.0.0:80", "router.php"]
