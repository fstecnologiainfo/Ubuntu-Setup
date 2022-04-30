#!/bin/bash
# Desenvolvido: Fernando da S. Conceição
# Data de criação do arquivo: 18/04/2022
# Ultima Modificação: 30/04/2022
# Versão: 0.2
#============================================================================================
#* VARIAVEIS GLOBAIS
HORAINICIAL=$(date +%T)
LOGD="/var/log/$(echo $0 | cut -d'/' -f2)-DETALHADO.log"
LOG="/var/log/$(echo $0 | cut -d'/' -f2)-RESUMIDO.log"
LOCAL=$(pwd)
VERSAO="0.2"
WSL2DEB='nmap speedtest-cli neofetch net-tools cmatrix figlet openssl dnsutils'
#============================================================================================
#* APRESENTACAO DO SCRIPT
echo -e " __  __ _                           __ _    __        ______  _     ____ "
echo -e "|  \/  (_) ___ _ __ ___  ___  ___  / _| |_  \ \      / / ___|| |   |___ \ "
echo -e "| |\/| | |/ __| '__/ _ \/ __|/ _ \| |_| __|  \ \ /\ / /\___ \| |     __) | "
echo -e "| |  | | | (__| | | (_) \__ \ (_) |  _| |_    \ V  V /  ___) | |___ / __/ "
echo -e "|_|  |_|_|\___|_|  \___/|___/\___/|_|  \__|    \_/\_/  |____/|_____|_____| "
echo -e "============================================================================"
echo -e "Versão do Script: $VERSAO"
echo -e ""

#============================================================================================
#* VERIFICAÇÕES INICIAIS
echo -e "Verificando se o usuario e Root..."
if [ "$(id -u)" -ne "0" ]
	then
		echo -e "Usuário $(whoami) não é Root"
		echo -e "Caso você não tenha executado o script com o comando: sudo"
		echo -e "Execute novamente o script para verificar o ambiente."
        exit 1
	else
		echo -e "O usuário é Root, continuando com o script..."
		sleep 5
fi

echo -e "Verificando se o script já foi executado..."
if [ -f $LOG ]
	then
		# populando LOG com informações do script e execução
		echo "Data de Execução: $(date)" >> $LOGD
		echo "Local de execução do script: $LOCAL" >> $LOGD
		echo "Usuario: $(whoami) " >> $LOGD
		echo "Script executado: $(echo $0 | cut -d'/' -f2)" >> $LOGD
		echo "Versão do Script: $VERSAO" >> $LOGD
		echo "======================================================" >> $LOGD

		echo "Data de Execução: $(date)" >> $LOG
		echo "Local de execução do script: $LOCAL" >> $LOG
		echo "Usuario: $(whoami) " >> $LOG
		echo "Script executado: $(echo $0 | cut -d'/' -f2)" >> $LOG
		echo "Versão do Script: $VERSAO" >> $LOG
		echo "======================================================" >> $LOG
		echo -e "Script $0 já foi executado 1 (uma) vez nesse computador..."
		echo -e "É recomendado analisar o arquivo de $LOG e $LOGD para informações de falhas ou erros"
		echo -e "Todos os scripts foram projetados para serem executados apenas 1 (uma) vez."
		echo "Nâo passou pela checagem de execução unica." >> $LOG
		sleep 5
		exit 1
	else
		# populando LOG com informações do script e execução
		echo "Data de Execução: $(date)" >> $LOGD
		echo "Local de Execução: $LOCAL" >> $LOGD
		echo "Usuario: $(whoami) " >> $LOGD
		echo "Script executado: $(echo $0 | cut -d'/' -f2)" >> $LOGD
		echo "Versão do Script: $VERSAO" >> $LOGD
		echo "======================================================" >> $LOGD

		echo "Data de Execução: $(date)" >> $LOG
		echo "Local de Execução: $LOCAL" >> $LOG
		echo "Usuario: $(whoami) " >> $LOG
		echo "Script executado: $(echo $0 | cut -d'/' -f2)" >> $LOG
		echo "Versão do Script: $VERSAO" >> $LOG
		echo "======================================================" >> $LOG
		echo -e "Primeira vez que você está executando esse script, tudo OK, agora só aguardar..."
		echo "Passou pela checagem de execução unica." >> $LOG
		sleep 5
fi
clear

echo -e "Verificando compatibilidade com o sistema operacional..."
if [ "$(lsb_release -rs)" == "21.10" ] || [ "$(lsb_release -rs)" == "22.04" ]
	then
		echo -e "A versão do sistema operacional é superior a 21.10, continuando com o script..."
		echo "Passou pela checagem de versão do sistema operacional." >> $LOG
		sleep 5
	else
		echo -e "O sistema operacional não é compativel com o script."
		echo "Não passou pela checagem do sistema operacional." >> $LOG
		exit 1
fi

echo -e "Verificando conexão com internet..."
if [ "$(nc -zw1 google.com 443 &> /dev/null ; echo $?)" == "0" ]
	then
		echo -e "Você tem acesso a Internet, continuando com o script..." >> $LOG
		sleep 5
	else
		echo -e "Você NÃO tem acesso a Internet, verifique suas configurações de rede IPV4 e conexões e execute novamente este script." >> $LOG
		sleep 5
		exit 1
fi

echo "Passou pelas verificações iniciais!" &>> $LOGD
sleep 5

#============================================================================================
#* ATUALIZAÇÃO DO SISTEMA
HORA_UP=$(date +%T)
echo -e "Atualizando repositórios..."
echo "Atualizando repositórios..." >> $LOG
echo "Atualizando repositórios..." >> $LOGD
if ! sudo apt-get update &>> $LOGD
then
    echo -e "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list" >> $LOG
    exit 1
fi
echo -e "Atualização do repositório feita com sucesso!!"

echo -e "Atualizando pacotes e sistema..."
echo "Atualizando pacotes e sistema..." >> $LOG
echo "Atualizando pacotes e sistema..." >> $LOGD
if ! sudo apt-get upgrade --autoremove -y &>> $LOGD
then
    echo -e "Não foi possível atualizar pacotes."
    echo "Não foi possível atualizar pacotes." >> $LOG
    exit 1
fi
echo -e "Atualização de pacotes feita com sucesso!!"
HORA_UPFIM=$(date +%T)

#============================================================================================
#* INSTALAÇÂO DE SOFTWARES .DEB ADMINISTRATIVOS
HORA_DEB=$(date +%T)
if ! sudo apt-get install $WSL2DEB -y &>> $LOGD
then
	echo -e "Não foi possivel instalar todos os pacotes DEB." >> $LOG
	echo -e "Verifique o LOG em $LOGD para maiores detalhes.."
	echo "Não foi possivel instalar todos os pacotes DEB." >> $LOGD
	exit 1
fi
echo -e "Instalação dos pacotes DEB finalizados com sucesso!!"
# Instalação do acme para gerar crertificados
echo -e "Download e instalação do ACME..."
sudo wget -O - https://get.acme.sh | sh &>> $LOGD
HORA_DEBFIM=$(date +%T)

HORAFINAL=$(date +%T)

#============================================================================================
#* CALCULOS DOS TEMPO DE EXECUÇÃO
HORAUP01=$(date -u -d "$HORA_UP" +"%s")
HORAUP02=$(date -u -d "$HORA_UPFIM" +"%s")
TEMPO_UP=$(date -u -d "0 $HORAUP01 sec - $HORAUP02 sec" +"%H:%M:%S")
echo -e "Tempo gasto para atualização do sistema: $TEMPO_UP" >> $LOG
echo "Tempo gasto para atualização do sistema: $TEMPO_UP" &>> $LOGD

HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
echo -e "Tempo gasto para execução do script $0: $TEMPO" >> $LOG
echo "Tempo gasto para execução do script $0: $TEMPO" &>> $LOGD