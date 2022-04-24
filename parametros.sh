#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 24/04/2022
# Versão: 0.4
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

WSNAP='whatsdesk teams-for-linux pdfmixtool'
WDEB='htop vlc filezilla flatpak git preload curl qbittorrent nano grub-customizer nomacs ubuntu-restricted-extras'
WDEBADM='synaptic openvpn gnome-boxes remmina net-tools dnsutils neofetch speedtest-cli nmap openssl'

# VARIAVEIS WSL2
WSL2DEB='nmap speedtest-cli neofetch net-tools cmatrix figlet openssl dnsutils'

#============================================================================================
# BANNERS
bannerDesk(){
echo -e " ____  _____ ____  _  _______ ___  ____ "
echo -e "|  _ \| ____/ ___|| |/ /_   _/ _ \|  _ \ "
echo -e "| | | |  _| \___ \| ' /  | || | | | |_) | "
echo -e "| |_| | |___ ___) | . \  | || |_| |  __/ "
echo -e "|____/|_____|____/|_|\_\ |_| \___/|_| "
echo -e "============================================"
echo -e ""
}

bannerServer(){
echo -e " ____  _____ ______     _______ ____ "
echo -e "/ ___|| ____|  _ \ \   / / ____|  _ \ "
echo -e "\___ \|  _| | |_) \ \ / /|  _| | |_) | "
echo -e " ___) | |___|  _ < \ V / | |___|  _ < "
echo -e "|____/|_____|_| \_\ \_/  |_____|_| \_\ "
echo -e "============================================"
echo -e ""
}

bannerWSL(){
echo -e " __  __ _                           __ _    __        ______  _     ____ "
echo -e "|  \/  (_) ___ _ __ ___  ___  ___  / _| |_  \ \      / / ___|| |   |___ \ "
echo -e "| |\/| | |/ __| '__/ _ \/ __|/ _ \| |_| __|  \ \ /\ / /\___ \| |     __) | "
echo -e "| |  | | | (__| | | (_) \__ \ (_) |  _| |_    \ V  V /  ___) | |___ / __/ "
echo -e "|_|  |_|_|\___|_|  \___/|___/\___/|_|  \__|    \_/\_/  |____/|_____|_____| "
echo -e "============================================================================"
echo -e ""
}