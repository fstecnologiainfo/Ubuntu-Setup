# **Ubuntu-Setup**

![Shell](https://img.shields.io/static/v1?label=Shell%20Script&message=Linux&color=red)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

 Script para realizar instalações e customização do Ubuntu Server e Desktop com versões superior a 20.04, incluído WSL2 da Microsoft.

>**IMPORTANTE**\
>Esses scripts são programados para executar apenas 1 vez, caso haja algum erro verifique os arquivos de log em /var/log/ \
>Caso queira realizar modificação nos programas que serão instalados, altere o arquivo parametros.sh

***

## **COMO USAR?**

1 - Faça o download do arquivo compactado na página do GitHub ou clone o repositório usando o comando

```
git clone https://github.com/fstecnologiainfo/Ubuntu-Setup.git
```

2 - Acesse a pasta /Ubuntu-Setup e altere as permissões dos arquivos *setup-serve.sh*, *setup-workstation.sh* e *parametros.sh* em arquivos executáveis.

3 - Execute a instalação com os privilégios *root*, sendo **/Ubuntu-Setup/setup-serve.sh** para realizar as instalações e customização no Ubuntu Server e **/Ubuntu-Setup/setup-workstation.sh** para a para realizar as instalações e customização no Ubuntu Desktop.

***

## **SERVER**

***Instalação***

Em desenvolvimento

***

## **WORKSTATION**

***Instalação***

Softwares SNAP: *Whatsdesk - Walc - Wrapup - MIcrosoft Teams - PDF Mix Tool*

Softwares .DEB: *htop - vlc - FileZilla - Preload - Curl - qBittorrent - Nano - Nomacs*

Softwares .DEB (Administrador de Redes): *Git - Synaptic - OpenVPN - Gnome-Boxes - Remmina - Net-Tools - DNS Utils - Neofetch - SpeedTest (CLI) - nmap*

***Customização***

- Ajuste de data e hora para dual boot e VM's

- GRUB-Theme (Dual Boot)
***

## **MICROSOFT WSL2**

***Instalação***

Softwares .DEB (Administrador de Redes): *nmap - SpeedTest (CLI) - Neofetch - Net-Tools - CMatrix - Figlet - qBittorrent - OpenSSL*

***Extra***

ACME: Para gerar certificados com Let's Encrypt

OpenSSL: Para gerar certificados auto-assinados e certificados .pfx

***

## **CRÉDITOS**

**Autor**: Fernando da S. Conceição

**Contato**: [GMail](fstecnologia.info@gmail.com)