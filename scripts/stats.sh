#!/bin/bash
# La ligne ci-dessus demande d'exécuter le script avec bash

# Nom du conteneur : le premier argument, ou "site" par défaut
conteneur="${1:-site}"

# Vérifie que le conteneur existe (affichage masqué), sinon message et arrêt
docker container inspect "$conteneur" > /dev/null 2>&1 || { echo "Erreur : le conteneur $conteneur n'existe pas"; exit 1; }

# Lit le journal et garde seulement les lignes de requêtes HTTP
journal=$(docker logs "$conteneur" 2>/dev/null | grep 'HTTP/')

# Si le journal est vide, il n'y a eu aucune visite : message et arrêt
[ -z "$journal" ] && { echo "Aucune visite sur le conteneur $conteneur"; exit 1; }

# Compte les lignes, donc le nombre de requêtes
requetes=$(echo "$journal" | grep -c 'HTTP/')

# Prend le code de réponse (champ 9) et compte ceux qui valent 404
erreurs=$(echo "$journal" | cut -d' ' -f9 | grep -c '^404$')

# Prend les IP (champ 1), les compte, garde la plus fréquente et enlève le compteur
ip=$(echo "$journal" | cut -d' ' -f1 | sort | uniq -c | sort -rn | head -n 1 | tr -s ' ' | cut -d' ' -f3)

# Même méthode avec la page demandée (champ 7)
page=$(echo "$journal" | cut -d' ' -f7 | sort | uniq -c | sort -rn | head -n 1 | tr -s ' ' | cut -d' ' -f3)

# Affiche le nombre de requêtes
echo "Requêtes : $requetes"
# Affiche le nombre d'erreurs 404
echo "Erreurs 404 : $erreurs"
# Affiche l'IP la plus active
echo "IP la plus active : $ip"
# Affiche la page la plus demandée
echo "Page la plus demandée : $page"