#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 16/04/2022
# Versão: 0.1
#============================================================================================

# VARIAVEIS GLOBAIS
LOGSCRIPT="/var/log/$(echo $0 | cut -d'/' -f2)"
LOGSCRIPT2="/var/log/SIMPLE-$(echo $0 | cut -d'/' -f2)"
USUARIO=$(id -u)
UBUNTU=$(lsb_release -rs)

# VARIAVEIS SERVER