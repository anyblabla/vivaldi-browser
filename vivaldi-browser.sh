#!/bin/bash
#
# Autheur:
#   Amaury Libert <amaury-libert@hotmail.com> de Blabla Linux <https://blablalinux.be>
#
# Description:
#   Installation automatisée du navigateur Vivaldi à partir du dépôt tiers de ce dernier. Script valable pour Debian 11,x, Ubuntu 22.04.x, Mint 21.x...
#   Automated installation of the Vivaldi browser from its third-party repository. Script valid for Debian 11,x, Ubuntu 22.04.x, Mint 21.x...
#
# Préambule Légal:
# 	Ce script est un logiciel libre.
# 	Vous pouvez le redistribuer et / ou le modifier selon les termes de la licence publique générale GNU telle que publiée par la Free Software Foundation; version 3.
#
# 	Ce script est distribué dans l'espoir qu'il sera utile, mais SANS AUCUNE GARANTIE; sans même la garantie implicite de QUALITÉ MARCHANDE ou d'ADÉQUATION À UN USAGE PARTICULIER.
# 	Voir la licence publique générale GNU pour plus de détails.
#
# 	Licence publique générale GNU : <https://www.gnu.org/licenses/gpl-2.0.txt>
#
echo "Effacement écran..."
clear
#
echo "Installation paquets requis"
apt install apt-transport-https wget
#
echo "Importation clé publique (/usr/share/keyrings/vivaldi-browser.gpg)"
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | dd of=/usr/share/keyrings/vivaldi-browser.gpg
#
echo "Génération sources.list (/etc/apt/sources.list.d/vivaldi-archive.list)"
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=amd64] https://repo.vivaldi.com/archive/deb/ stable main" > /etc/apt/sources.list.d/vivaldi-archive.list
#
echo "Raffraichissement dépôts"
apt update
#
echo "Installation Vivaldi"
apt install vivaldi-stable
#
echo "Source : https://help.vivaldi.com/fr/desktop-fr/install-update-fr/configuration-manuelle-des-depots-vivaldi-linux/"
