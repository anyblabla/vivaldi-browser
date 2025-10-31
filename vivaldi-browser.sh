#!/bin/bash

# ==============================================================================
# TITRE: Installation du navigateur Vivaldi
# AUTEUR: Amaury Libert (Base) | Amélioré par l'IA
# LICENCE: GPLv3
# DESCRIPTION:
#   Installation automatisée du navigateur Vivaldi à partir de son dépôt officiel.
#   Compatible Debian/Ubuntu/Mint (11.x, 22.04.x, 21.x...).
# ==============================================================================

# --- Configuration et Préparation ---

# Mode strict: Quitte en cas d'erreur (-e), variable non définie (-u), ou échec
# dans un pipe (-o pipefail).
set -euo pipefail

# Couleurs pour une sortie utilisateur claire
VERT='\033[0;32m'
ROUGE='\033[0;31m'
JAUNE='\033[0;33m'
CYAN='\033[0;36m'
FIN='\033[0m'

CLE_KEYRING="/usr/share/keyrings/vivaldi-browser-archive-keyring.gpg"
FICHIER_SOURCES="/etc/apt/sources.list.d/vivaldi-archive.list"
LOGICIEL="vivaldi-stable"

# Vérification des droits root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${ROUGE}ERREUR : Ce script doit être exécuté avec 'sudo' ou en tant que root.${FIN}"
    exit 1
fi

echo -e "${CYAN}*** Début de l'installation de Vivaldi ***${FIN}"
clear # Effacer l'écran après le message d'introduction

# --- Étape 1: Installation des Dépendances Nécessaires ---

echo -e "${JAUNE}1. Mise à jour des dépôts et installation des prérequis...${FIN}"
apt update
# Ajout de 'gnupg' (ou 'gpg') et de 'curl' pour la méthode moderne d'importation.
apt install -y wget apt-transport-https gnupg curl

# --- Étape 2: Importation de la Clé GPG (Méthode Moderne et Sécurisée) ---

echo -e "${JAUNE}2. Importation de la clé publique de Vivaldi vers ${CLE_KEYRING}...${FIN}"

# Utilisation de 'curl' (ou 'wget -qO-') pour récupérer la clé et de 'gpg --dearmor'
# avec redirection simple (>) pour l'enregistrer.
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor > "${CLE_KEYRING}"

if [ ! -f "${CLE_KEYRING}" ]; then
    echo -e "${ROUGE}ERREUR : Échec de l'importation de la clé GPG. Abandon.${FIN}"
    exit 1
fi
echo -e "${VERT}Clé GPG importée avec succès.${FIN}"

# --- Étape 3: Ajout du Dépôt Vivaldi ---

echo -e "${JAUNE}3. Ajout du dépôt 'stable' de Vivaldi dans ${FICHIER_SOURCES}...${FIN}"

# Utilisation de la syntaxe 'signed-by' pour Debian 11+ / Ubuntu 20.04+ (sécurité).
echo "deb [arch=amd64 signed-by=${CLE_KEYRING}] https://repo.vivaldi.com/archive/deb/ stable main" > "${FICHIER_SOURCES}"

if [ ! -f "${FICHIER_SOURCES}" ]; then
    echo -e "${ROUGE}ERREUR : Échec de la création du fichier sources.list. Abandon.${FIN}"
    exit 1
fi
echo -e "${VERT}Dépôt Vivaldi ajouté avec succès.${FIN}"

# --- Étape 4: Installation du Navigateur ---

echo -e "${JAUNE}4. Raffraîchissement des dépôts et installation de ${LOGICIEL}...${FIN}"
apt update
apt install -y "${LOGICIEL}"

# --- Étape 5: Finalisation ---

echo -e "${VERT}*** Installation de Vivaldi (Stable) terminée ! ***${FIN}"