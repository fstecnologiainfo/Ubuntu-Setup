#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 18/04/2022
# Versão: 0.3
#============================================================================================

# VARIAVEIS GLOBAIS
# Utilizados para todos os scripts
LOGSCRIPT="/var/log/$(echo $0 | cut -d'/' -f2).log"
LOGSCRIPT2="/var/log/SIMPLE-$(echo $0 | cut -d'/' -f2).log"
USUARIO=$(id -u)
UBUNTU=$(lsb_release -rs)

# VARIAVEIS SERVER

# VARIAVEIS WORKSTATION

# Utilizados como flags para exucutar ou não a instalações dos recursos
# As respostas devem ser SIM ou NAO
SNAP_RESP='SIM'
DEB_RESP='SIM'
DEBADM_RESP='SIM'
CUSTOM_RESP='SIM'

WSNAP='whatsdesk walc wrapup teams-for-linux pdfmixtool'
WDEB='htop vlc filezilla flatpak git preload curl qbittorrent nano'
WDEBADM='nomacs synaptic openvpn gnome-boxes remmina net-tools dnsutils neofetch speedtest-cli nmap'

# VARIAVEIS WSL2
WSL2DEB='nmap speedtest neofetch net-tools matrix figlet qbittorrent openssl'
