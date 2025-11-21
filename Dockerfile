FROM php:8.2-cli

# Installer extensions PDO + MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Dossier de travail
WORKDIR /var/www/html/flightPHP

# Exposer le port
EXPOSE 80

# Lancer le serveur PHP
CMD ["php", "-S", "0.0.0.0:80", "router.php"]
