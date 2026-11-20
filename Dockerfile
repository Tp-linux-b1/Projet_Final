# Image officielle : Apache + PHP 8.4 (sert aussi du HTML seul)
FROM php:8.4-apache

# Copie uniquement le dossier site/ dans le dossier publié par Apache
COPY site/ /var/www/html/

# Documente le port d'écoute d'Apache dans le conteneur
EXPOSE 80
