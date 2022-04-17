#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 17/04/2022
# Versão: 0.2
#============================================================================================

# VARIAVEIS GLOBAIS
LOGSCRIPT="/var/log/$(echo $0 | cut -d'/' -f2).log"
LOGSCRIPT2="/var/log/SIMPLE-$(echo $0 | cut -d'/' -f2).log"
USUARIO=$(id -u)
UBUNTU=$(lsb_release -rs)

# VARIAVEIS SERVER

#?VARIAVEIS WORKSTATION
# As respostas devem ser SIM ou NAO
SNAP_RESP='SIM'
DEB_RESP='SIM'
DEBADM_RESP='SIM'
CUSTOM_RESP='SIM'

SNAP_INSTALL='whatsdesk walc wrapup teams-for-linux pdfmixtool'
DEB_INSTALL='htop vlc filezilla flatpak git preload curl qbittorrent nano'
DEBADM_INSTALL='nomacs synaptic openvpn gnome-boxes remmina net-tools dnsutils neofetch speedtest-cli nmap'