#!/bin/bash
# Desenvolvido: Fernando da S. Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 30/04/2022
# Versão: 1.3
#TODO Testar a não interação do usuário
#TODO Testar o uso da variavel de instalação
#TODO Implementar os FLAGS para instalação
#============================================================================================
#* VARIAVEIS GLOBAIS
LOGD="/var/log/$(echo $0 | cut -d'/' -f2)-DETALHADO.log"
LOG="/var/log/$(echo $0 | cut -d'/' -f2)-RESUMIDO.log"
LOCAL=$(pwd)
VERSAO="1.3"
WSNAP='whatsdesk teams-for-linux pdfmixtool'
WDEB='htop vlc filezilla flatpak git preload curl qbittorrent nano grub-customizer nomacs ubuntu-restricted-extras'
WDEBADM='synaptic openvpn gnome-boxes remmina net-tools dnsutils neofetch speedtest-cli nmap openssl'
#============================================================================================
#* APRESENTACAO DO SCRIPT
clear
echo -e " ____  _____ ____  _  _______ ___  ____ "
echo -e "|  _ \| ____/ ___|| |/ /_   _/ _ \|  _ \ "
echo -e "| | | |  _| \___ \| ' /  | || | | | |_) | "
echo -e "| |_| | |___ ___) | . \  | || |_| |  __/ "
echo -e "|____/|_____|____/|_|\_\ |_| \___/|_| "
echo -e "============================================"
echo -e "Versão do Script: $VERSAO"
echo -e ""

#============================================================================================
#* VERIFICAÇÕES INICIARIS
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
		echo "Script executado: $(echo $0 | cut -d'/' -f2)" >> LOGD
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
#* AJUSTES DO SISTEMA
echo -e "Iniciando customização e ajustes do sistema..." >> $LOG
echo "Alterando sistema de data e hora..." >> $LOGD
timedatectl set-local-rtc 1 --adjust-system-clock &>> $LOGD

#============================================================================================
#* ATUALIZAÇÃO DO SISTEMA
HORAINICIAL=$(date +%T)
HORA_UP=$(date +%T)
echo -e "Atualizando repositórios..." >> $LOG
echo "Atualizando repositórios..." >> $LOGD
if ! sudo apt-get update &>> $LOGD
then
    echo -e "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list" >> $LOG
    exit 1
fi
echo -e "Atualização do repositório feita com sucesso!!"

echo -e "Atualizando pacotes e sistema..." >> $LOG
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
#* INSTALAÇÂO DE SNAPs
HORA_SNAP=$(date +%T)
echo -e "Instalando suporte a SNAP e aplicativos SNAP..." >> $LOG
echo "Instalando aplicativos snap..." >> $LOGD
if ! sudo apt install snap -y &>> $LOGD
then
    echo -e "Não foi possível instalar o suporte a snap." >> $LOG
	echo -e "Verifique o LOG em $LOGD para maires detalhes.."
    exit 1
fi
echo -e "Instalação do suporte a SNAP feita com sucesso!!"

if ! sudo snap install $WSNAP &>> $LOGD
then
	echo -e "Não foi possivel realizar a instalação dos aplicativos SNAP." >> $LOG
	echo -e "Verifique o LOG em $LOGD para maires detalhes.."
	exit 1
fi
echo "Instalação dos aplicativos SNAP feita com sucesso!!"
HORA_SNAPFIM=$(date +%T)

#============================================================================================
#* INSTALAÇÂO DE SOFTWARES .DEB
HORA_DEB=$(date +%T)
echo -e "Instalando aplicativos DEB..." >> $LOG
echo "Instalando aplicativos DEB..." >> $LOGD
if ! sudo DEBIAN_FRONTEND=noninteractive apt install $WDEB -y &>> $LOGD
then
	echo -e "Não foi possivel instalar todos os pacotes DEB." >> $LOG
	echo -e "Verifique o LOG em $LOGD para maiores detalhes.."
	echo "Não foi possivel instalar todos os pacotes DEB." >> $LOGD
	exit 1
fi
echo -e "Instalação dos pacotes DEB finalizados com sucesso!!"


#============================================================================================
#* INSTALAÇÂO DE SOFTWARES .DEB ADMINISTRATIVOS
echo -e "Instalando aplicativos DEB administrativos..." >> $LOG
echo "Instalando aplicativos DEB administrativos..." >> $LOGD
if ! sudo apt DEBIAN_FRONTEND=noninteractive install $WDEBADM -y &>> $LOGD
then
	echo -e "Não foi possivel instalar todos os pacotes .DEB admnistrativos." >> $LOG
	echo -e "Verifique o LOG em $LOGD para maires detalhes.."
	echo "Não foi possivel instalar todos os pacotes .DEB admnistrativos." >> $LOGD
	exit 1
fi
echo -e "Instalação dos pacotes administrativos concuida com sucesso!!"
HORA_DEBFIM=$(date +%T)

HORAFINAL=$(date +%T)

#============================================================================================
#* CALCULOS DOS TEMPOS GASTOS DE EXECUÇÃO
HORAUP01=$(date -u -d "$HORA_UP" +"%s")
HORAUP02=$(date -u -d "$HORA_UPFIM" +"%s")
TEMPO_UP=$(date -u -d "0 $HORAUP01 sec - $HORAUP02 sec" +"%H:%M:%S")
echo -e "Tempo gasto para atualização do sistema: $TEMPO_UP" >> $LOG
echo "Tempo gasto para atualização do sistema: $TEMPO_UP" &>> $LOGD

HORASNAP01=$(date -u -d "$HORA_SNAP" +"%s")
HORASNAP02=$(date -u -d "$HORA_SNAPFIM" +"%s")
TEMPO_SNAP=$(date -u -d "0 $HORASNAP01 sec - $HORASNAP02 sec" +"%H:%M:%S")
echo -e "Tempo gasto instalar softwares SNAP: $TEMPO_SNAP" >> $LOG
echo "Tempo gasto instalar softwares SNAP: $TEMPO_SNAP" &>>LOGD

HORADEB01=$(date -u -d "$HORA_DEB" +"%s")
HORADEB02=$(date -u -d "$HORA_DEBFINAL" +"%s")
TEMPO_DEB=$(date -u -d "0 $HORADEB01 sec - $HORADEB02 sec" +"%H:%M:%S")
echo -e "Tempo gasto instalar softwares .DEB: $TEMPO_DEB" >> $LOG
echo "Tempo gasto instalar softwares .DEB: $TEMPO_DEB" &>> $LOGD

HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
echo -e "Tempo gasto para execução do script $0: $TEMPO" >> $LOG
echo "Tempo gasto para execução do script $0: $TEMPO" &>> $LOGD
#============================================================================================
#* FIM DO PROCESSO E RESTART
echo -e "Pressione <Enter> para concluir o processo e reiniciar o sistema."
read
echo -e "Fim do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" >> $LOGD
echo -e "Reiniciando sistema para aplicar atualizações!....." >> $LOG
sleep 10
sudo reboot now
exit 1