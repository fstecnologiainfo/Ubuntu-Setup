#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 10/04/2022
# Ultima Modificação: 17/04/2022
# Versão: 0.2
#============================================================================================

# IMPORTAÇÃO DOS PARAMETROS e VARIAVEIS GLOBAIS
source parametros.sh
HORAINICIAL=$(date +%T)
LOG_DETAIL=$LOGSCRIPT
LOG=$LOGSCRIPT2
VERSAO="0.2"
#============================================================================================
#? VERIFICAÇÕES INICIARIS
echo -e "Verificando se o script já foi executado..."
if [ -f $LOG ]
	then
		echo -e "Script $0 já foi executado 1 (uma) vez nesse computador..."
		echo -e "É recomendado analisar o arquivo de $LOG e $LOG_DETAIL para informações de falhas ou erros"
		echo -e "na instalação e configuração do serviço de rede utilizando esse script..."
		echo -e "Todos os scripts foram projetados para serem executados apenas 1 (uma) vez."
		echo "Nâo passou pela checagem de execução unica." >> $LOG
		sleep 5
		exit 1
	else
		echo -e "Primeira vez que você está executando esse script, tudo OK, agora só aguardar..."
		echo "Passou pela checagem de execução unica." >> $LOG
		sleep 5
fi
clear

echo "Início do script $0 versão $VERSAO em: $(date +%d/%m/%Y-"("%H:%M")")" &>> $LOG_DETAIL
echo "Inicio do script $0 versao $VERSAO em: $(date +%d/%m/%Y-"("%H:%M")")" >> $LOG

echo -e "Verificando se o usuario e Root..." >> $LOG
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

echo -e "Verificando compatibilidade com o sistema operacional..." >> $LOG
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

echo -e "Verificando conexão com internet..." >> $LOG
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
#? ATUALIZAÇÃO DO SISTEMA
HORA_UP=$(date +%T)
echo -e "Atualizando repositórios....." >> $LOG
if ! sudo apt-get update &>> $LOG_DETAIL
then
    echo -e "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list" >> $LOG
    exit 1
fi
echo -e "Atualização do repositório feita com sucesso!!"  >> $LOG

echo -e "Atualizando pacotes e sistema....."  >> $LOG
if ! sudo apt-get upgrade --autoremove -y &>> $LOG_DETAIL
then
    echo -e "Não foi possível atualizar pacotes."  >> $LOG
    exit 1
fi
echo -e "Atualização de pacotes feita com sucesso!!"  >> $LOG
clear
HORA_UPFIM=$(date +%T)

#============================================================================================
#? INSTALAÇÂO DE SNAPs
HORA_SNAP=$(date +%T)
echo -e "Instalando aplicativos snap....."  >> $LOG
if ! sudo apt install snap -y &>> $LOG_DETAIL
then
    echo "Não foi possível instalar o pacote de snap." >> $LOG
    exit 1
fi
echo -e "Instalação do pacote de snap feita com sucesso!!" >> $LOG
sudo snap install whatsdesk walc wrapup teams-for-linux &>> $LOG_DETAIL
sudo snap install pdfmixtool &>> $LOG_DETAIL
clear
HORA_SNAPFIM=$(date +%T)

#============================================================================================
#? INSTALAÇÂO DE SOFTWARES .DEB
HORA_DEB=$(date +%T)
echo -e "Instalando aplicativos DEB...."  >> $LOG
sudo apt install htop vlc filezilla flatpak git preload curl qbittorrent -y &>> $LOG_DETAIL
clear

#============================================================================================
#? INSTALAÇÂO DE SOFTWARES .DEB ADMINISTRATIVOS
echo -e "Instalando aplicativos DEB administrativos...."  >> $LOG
sudo apt install nomacs synaptic openvpn gnome-boxes remmina net-tools dnsutils -y &>> $LOG_DETAIL
sudo apt install neofetch speedtest-cli nmap &>> $LOG_DETAIL
clear
HORA_DEBFIM=$(date +%T)

#============================================================================================
#? CUSTOMIZAÇÃO DO SISTEMA
echo -e "Adicionando repositórios extras....."  >> $LOG
sudo add-apt-repository ppa:danielrichter2007/grub-customizer &>> $LOG_DETAIL
sudo apt-get update &>> $LOG_DETAIL
echo -e "Instalando Grub-Customizer....."  >> $LOG
sudo apt-get install grub-customizer -y &>> $LOG_DETAIL
echo -e "Iniciando costumização do sistema..." >> $LOG
echo -e "Alterando sistema de data e hora em dual-boot" >> $LOG
timedatectl set-local-rtc 1 --adjust-system-clock &>> $LOG_DETAIL
echo -e "Instalação do Grub Theme...." >> $LOG
cd /conf/Grub-Theme/ &>> $LOG_DETAIL
if ! sudo bash ./install.sh &>> $LOG_DETAIL
then
    echo -e "Não foi possível instalar o Grub Theme. Verificar permissões do arquivo, ou se o mesmo se encontra no diretório." >> $LOG
    sleep 10
    exit 1
fi
echo -e "Grub Theme instalado com sucesso!" >> $LOG
sleep 3
HORAFINAL=$(date +%T)

#! Verificar se necessário na versão 20.4 superior
#! echo "Implementando minimizar app para dock com duplo clique....."
#! gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
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
echo -e "Pressione <Enter> para concluir o processo."
read
echo -e "Fim do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG_DETAIL
echo "Reiniciando sistema para aplicar atualizações!....." >> $LOG
sleep 8
sudo reboot now
exit 1