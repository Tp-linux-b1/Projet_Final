#!/bin/bash
# La ligne ci-dessus demande d'exécuter le script avec bash

# Va dans le dossier du projet ; s'il n'existe pas, affiche une erreur et s'arrête
cd ~/serveur/Projet_Final || { echo "Erreur : dossier ~/serveur/Projet_Final introuvable"; exit 1; }

# Récupère les dernières modifications depuis GitHub ; s'arrête en cas d'échec
git pull || { echo "Erreur : git pull a échoué"; exit 1; }

# Copie la page et le style dans le dossier du serveur web (sudo = droits administrateur)
sudo cp site/index.html site/style.css /var/www/html/ || { echo "Erreur : la copie a échoué"; exit 1; }

# Affiche le message de fin
echo "Déploiement terminé"