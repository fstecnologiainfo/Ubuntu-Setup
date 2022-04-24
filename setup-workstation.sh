#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 24/04/2022
# Versão: 1.2
#============================================================================================

# IMPORTAÇÃO DOS PARAMETROS e VARIAVEIS GLOBAIS
source parametros.sh
LOG_DETAIL=$LOGSCRIPT
LOG=$LOGSCRIPT2
LOCAL=$(pwd)
VERSAO="1.2"
#============================================================================================
#? APRESENTACAO DO SCRIPT
bannerDesk()
echo -e "Versão do Script: $VERSAO"
echo -e ""

#============================================================================================
#? VERIFICAÇÕES INICIARIS
echo -e "Verificando se o script já foi executado..."
if [ -f $LOG ]
	then
		else
		# populando LOG com informações do script e execução
		echo "Data de Execução: $(date)" >> $LOG_DETAIL
		echo "Local de Execução: $LOCAL" >> $LOG_DETAIL
		echo "Usuario: $(whoami) " >> $LOG_DETAIL
		echo "Script executado: $(echo $0 | cut -d'/' -f2)"
		echo "Versão do Script: $VERSAO" >> $LOG_DETAIL
		echo "======================================================" >> $LOG_DETAIL

		echo "Data de Execução: $(date)" >> $LOG
		echo "Local de Execução: $LOCAL" >> $LOG
		echo "Usuario: $(whoami) " >> $LOG
		echo "Script executado: $(echo $0 | cut -d'/' -f2)"
		echo "Versão do Script: $VERSAO" >> $LOG
		echo "======================================================" >> $LOG
		echo -e "Script $0 já foi executado 1 (uma) vez nesse computador..."
		echo -e "É recomendado analisar o arquivo de $LOG e $LOG_DETAIL para informações de falhas ou erros"
		echo -e "na instalação e configuração do serviço de rede utilizando esse script..."
		echo -e "Todos os scripts foram projetados para serem executados apenas 1 (uma) vez."
		echo "Nâo passou pela checagem de execução unica." >> $LOG
		sleep 5
		exit 1
	else
		# populando LOG com informações do script e execução
		echo "Data de Execução: $(date)" >> $LOG_DETAIL
		echo "Local de Execução: $LOCAL" >> $LOG_DETAIL
		echo "Usuario: $(whoami) " >> $LOG_DETAIL
		echo "Script executado: $(echo $0 | cut -d'/' -f2)"
		echo "Versão do Script: $VERSAO" >> $LOG_DETAIL
		echo "======================================================" >> $LOG_DETAIL

		echo "Data de Execução: $(date)" >> $LOG
		echo "Local de Execução: $LOCAL" >> $LOG
		echo "Usuario: $(whoami) " >> $LOG
		echo "Script executado: $(echo $0 | cut -d'/' -f2)"
		echo "Versão do Script: $VERSAO" >> $LOG
		echo "======================================================" >> $LOG
		echo -e "Primeira vez que você está executando esse script, tudo OK, agora só aguardar..."
		echo "Passou pela checagem de execução unica." >> $LOG
		sleep 5
fi
clear

echo "Início do script $0 versão $VERSAO em: $(date +%d/%m/%Y-"("%H:%M")")" &>> $LOG_DETAIL
echo "Inicio do script $0 versao $VERSAO em: $(date +%d/%m/%Y-"("%H:%M")")" >> $LOG

echo -e "Verificando se o usuario e Root..."
if [ "$USUARIO" == "0" ]
	then
		echo -e "O usuário é Root, continuando com o script..."
        echo "Passou pela checagem de usuário." >> $LOG
		sleep 5
	else
		echo -e "Usuário ($USUARIO) não é Root"
		echo -e "Caso você não tenha executado o script com o comando: sudo"
		echo -e "Execute novamente o script para verificar o ambiente."
		echo "Não passou pela checagem de usuário root." >> $LOG
        exit 1
fi

echo -e "Verificando compatibilidade com o sistema operacional..."
if [ "$UBUNTU" == "20.04" ] || [ "$UBUNTU" == "21.10" ]
	then
		echo -e "A versão do sistema operacional é superior a 20.04, continuando com o script..."
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

echo "Passou pelas verificações iniciais!" &>> $LOG_DETAIL
sleep 5

#============================================================================================
#? AJUSTES DO SISTEMA
echo -e "Iniciando customização e ajustes do sistema..."
echo "Alterando sistema de data e hora..." >> $LOG
echo "Alterando sistema de data e hora..." >> $LOG_DETAIL
timedatectl set-local-rtc 1 --adjust-system-clock &>> $LOG_DETAIL

#============================================================================================
#? ATUALIZAÇÃO DO SISTEMA
HORAINICIAL=$(date +%T)
HORA_UP=$(date +%T)
echo -e "Atualizando repositórios..."
echo "Atualizando repositórios..." >> $LOG
echo "Atualizando repositórios..." >> $LOG_DETAIL
if ! sudo apt-get update &>> $LOG_DETAIL
then
    echo -e "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list" >> $LOG
    exit 1
fi
echo -e "Atualização do repositório feita com sucesso!!"

echo -e "Atualizando pacotes e sistema..."
echo "Atualizando pacotes e sistema..." >> $LOG
echo "Atualizando pacotes e sistema..." >> $LOG_DETAIL
if ! sudo apt-get upgrade --autoremove -y &>> $LOG_DETAIL
then
    echo -e "Não foi possível atualizar pacotes."
    echo "Não foi possível atualizar pacotes." >> $LOG
    exit 1
fi
echo -e "Atualização de pacotes feita com sucesso!!"
HORA_UPFIM=$(date +%T)

#============================================================================================
#? INSTALAÇÂO DE SNAPs
#TODO Testar o uso da variavel de instalação
HORA_SNAP=$(date +%T)
echo -e "Instalando aplicativos snap..."
echo "Instalando aplicativos snap..." >> $LOG
echo "Instalando aplicativos snap..." >> $LOG_DETAIL
if ! sudo apt install snap -y &>> $LOG_DETAIL
then
    echo -e "Não foi possível instalar o pacote de snap."
    echo "Não foi possível instalar o pacote de snap." >> $LOG
    exit 1
fi
echo -e "Instalação do pacote de snap feita com sucesso!!"
sudo snap install whatsdesk walc wrapup teams-for-linux &>> $LOG_DETAIL
HORA_SNAPFIM=$(date +%T)

#============================================================================================
#? INSTALAÇÂO DE SOFTWARES .DEB
#TODO Testar a não interação do usuário
#TODO Testar o uso da variavel de instalação
#TODO Criar condição de IF ! para instalação dos softwares
HORA_DEB=$(date +%T)
echo -e "Instalando aplicativos DEB..."
echo "Instalando aplicativos DEB..." >> $LOG
echo "Instalando aplicativos DEB..." >> $LOG_DETAIL
sudo DEBIAN_FRONTEND=noninteractive apt install htop vlc nomacs filezilla flatpak preload curl qbittorrent -y &>> $LOG_DETAIL

#============================================================================================
#? INSTALAÇÂO DE SOFTWARES .DEB ADMINISTRATIVOS
echo -e "Instalando aplicativos DEB administrativos..."
echo "Instalando aplicativos DEB administrativos..." >> $LOG
echo "Instalando aplicativos DEB administrativos..." >> $LOG_DETAIL
sudo apt DEBIAN_FRONTEND=noninteractive install git synaptic openvpn gnome-boxes remmina net-tools dnsutils -y &>> $LOG_DETAIL
HORA_DEBFIM=$(date +%T)

HORAFINAL=$(date +%T)

#============================================================================================
#? CALCULOS DOS TEMPOS GASTOS DE EXECUÇÃO
HORAUP01=$(date -u -d "$HORA_UP" +"%s")
HORAUP02=$(date -u -d "$HORA_UPFIM" +"%s")
TEMPO_UP=$(date -u -d "0 $HORAUP01 sec - $HORAUP02 sec" +"%H:%M:%S")
echo -e "Tempo gasto para atualização do sistema: $TEMPO_UP"

HORASNAP01=$(date -u -d "$HORA_SNAP" +"%s")
HORASNAP02=$(date -u -d "$HORA_SNAPFIM" +"%s")
TEMPO_SNAP=$(date -u -d "0 $HORASNAP01 sec - $HORASNAP02 sec" +"%H:%M:%S")
echo -e "Tempo gasto instalar softwares SNAP: $TEMPO_SNAP"

HORADEB01=$(date -u -d "$HORA_DEB" +"%s")
HORADEB02=$(date -u -d "$HORA_DEBFINAL" +"%s")
TEMPO_DEB=$(date -u -d "0 $HORADEB01 sec - $HORADEB02 sec" +"%H:%M:%S")
echo -e "Tempo gasto instalar softwares .DEB: $TEMPO_DEB"

HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
echo -e "Tempo gasto para execução do script $0: $TEMPO"
#============================================================================================
#? FIM DO PROCESSO E RESTART
echo -e "Pressione <Enter> para concluir o processo e reiniciar o sistema."
read
echo -e "Fim do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG_DETAIL
echo "Reiniciando sistema para aplicar atualizações!....." >> $LOG
sleep 8
sudo reboot now
exit 1