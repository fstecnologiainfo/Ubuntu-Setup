# **Ubuntu-Setup**

![Shell](https://img.shields.io/static/v1?label=Shell%20Script&logo=Ubuntu&message=Linux&color=orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![GitHub repo size](https://img.shields.io/github/repo-size/fstecnologiainfo/Ubuntu-Setup)

 Script para realizar instalações e customização do Ubuntu Server e Desktop com versões superior a 20.04, incluído WSL2 da Microsoft.

>**IMPORTANTE**\
>Esses scripts são programados para executar apenas 1 vez, caso haja algum erro verifique os arquivos de log em /var/log/ \
>Caso queira realizar modificação nos programas que serão instalados, altere o arquivo parametros.sh

***

## **COMO USAR?**

1 - Faça o download do arquivo compactado na página do GitHub ou clone o repositório usando o comando

Git
```
git clone https://github.com/fstecnologiainfo/Ubuntu-Setup.git
```

PowerShell
```
Invoke-WebRequest -Uri https://codeload.github.com/fstecnologiainfo/Ubuntu-Setup/zip/refs/heads/main -OutFile C:\Temp\Ubuntu-Setup.zip
```

2 - Acesse a pasta /Ubuntu-Setup e altere as permissões dos arquivos *setup-serve.sh*, *setup-workstation.sh* e *parametros.sh* em arquivos executáveis.

3 - Execute a instalação com os privilégios *root*, sendo **/Ubuntu-Setup/setup-serve.sh** para realizar as instalações e customização no Ubuntu Server e **/Ubuntu-Setup/setup-workstation.sh** para a para realizar as instalações e customização no Ubuntu Desktop e **/Ubuntu-Setup/setup-wsl2.sh**.

***

## **SERVER**

***Instalação***

Em desenvolvimento

***

## **WORKSTATION**

***Instalação***

Softwares SNAP: *Whatsdesk - MIcrosoft Teams - PDF Mix Tool*

Softwares .DEB: *htop - VLC - FileZilla - Flatpak - Git - Preload - Curl - qBittorrent - Nano - Grub Customizer - Nomacs*

Softwares .DEB (Administrador de Redes): *Synaptic Open VPN - Gnome Boxes - Remmina - Net-tools - DNS Utils - Neofetch - SpeedTest (cli) - NMap - Open SSL*

***Customização***

- Ajuste de data e hora para dual boot e VM's
- Codecs para execução de arquivos de media

***

## **MICROSOFT WSL2**

***Instalação***

Softwares .DEB (Administrador de Redes): *NMap - SpeedTest (cli) - Neofetch - Net-tools - cMatrix - Figlet - Open SSL - DNS  Utils*

***Extra***

ACME: Para gerar certificados com Let's Encrypt

OpenSSL: Para gerar certificados auto-assinados e certificados .pfx

***

## **CRÉDITOS**

**Autor**: Fernando da S. Conceição

**Contato**: [GMail](fstecnologia.info@gmail.com)