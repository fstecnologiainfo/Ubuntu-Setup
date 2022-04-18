#!/bin/bash
# Desenvolvido: Fernando da Silva Conceição
# Data de criação do arquivo: 18/04/2022
# Ultima Modificação: 18/04/2022
# Versão: 0.1
#============================================================================================

# IMPORTAÇÃO DOS PARAMETROS e VARIAVEIS GLOBAIS
source parametros.sh
HORAINICIAL=$(date +%T)
LOG_DETAIL=$LOGSCRIPT
LOG=$LOGSCRIPT2
VERSAO="0.1"
#============================================================================================
# VERIFICAÇÕES INICIARIS
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

echo -e "Verificando se o usuario e Root..."
if [ "$USUARIO" == "0" ]
	then
		echo -e "O usuário é Root, continuando com o script..."
        echo "Passou pela checagem de usuário Root." >> $LOG
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
# ATUALIZAÇÃO DO SISTEMA
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
# INSTALAÇÂO DE SOFTWARES .DEB ADMINISTRATIVOS
HORA_DEB=$(date +%T)
sudo apt-get install $WSL2DEB -y
HORA_DEBFIM=$(date +%T)

# Instalação do acme para gerar crertificados
sudo wget -O - https://get.acme.sh | sh
HORAFINAL=$(date +%T)
#============================================================================================
# CALCULOS DOS TEMPO DE EXECUÇÃO
HORAUP01=$(date -u -d "$HORA_UP" +"%s")
HORAUP02=$(date -u -d "$HORA_UPFIM" +"%s")
TEMPO_UP=$(date -u -d "0 $HORAUP01 sec - $HORAUP02 sec" +"%H:%M:%S")
echo -e "Tempo gasto para atualização do sistema: $TEMPO_UP"
echo "Tempo gasto para atualização do sistema: $TEMPO_UP" >> $LOG

HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo "Tempo gasto para execução do script $0: $TEMPO" >> $LOG