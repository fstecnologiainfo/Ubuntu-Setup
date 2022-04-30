#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 30/04/2022
# Versão: 0.1
#============================================================================================

# IMPORTAÇÃO DOS PARAMETROS e VARIAVEIS GLOBAIS
source parametros.sh
LOG_DETAIL=$LOGSCRIPT
LOG=$LOGSCRIPT2
LOCAL=$(pwd)
VERSAO="1.3"
#============================================================================================
#* APRESENTACAO DO SCRIPT
echo -e " ____  _____ ______     _______ ____ "
echo -e "/ ___|| ____|  _ \ \   / / ____|  _ \ "
echo -e "\___ \|  _| | |_) \ \ / /|  _| | |_) | "
echo -e " ___) | |___|  _ < \ V / | |___|  _ < "
echo -e "|____/|_____|_| \_\ \_/  |_____|_| \_\ "
echo -e "============================================"
echo -e "Versão do Script: $VERSAO"
echo -e ""
#============================================================================================
# VERIFICAÇÕES INICIAIS