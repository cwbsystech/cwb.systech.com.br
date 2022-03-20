#!/bin/bash
# Autor:						Jensy Gregorio Gomez
# YouTube:						youtube.com/systech
# Instagram:					https://www.instagram.com/systech5/?hl=pt-br
# Github:						https://github.com/vaasystech-brz
# Data de criação:				01/01/2022
# Data de atualização:			01/01/2022
# Versão:						0.01
# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64
# Testado e homologado para a versão do OpenSSH Server v8.2.x
#
# OpenSSH 
#			(Open Secure Shell) é um conjunto de utilitários de rede relacionado à
#			segurança que provém a criptografia em sessões de comunicações em uma 
#			rede de computadores usando o protocolo SSH. Foi criado com um código 
#			aberto alternativo ao código proprietário da suíte de softwares Secure 
#			Shell, oferecido pela SSH Communications Security. OpenSSH foi desenvolvido 
#			como parte do projeto OpenBSD.
#
# O TCP Wrapper 
#			É um sistema de rede ACL baseado em host, usado para filtrar acesso à 
#			rede a servidores de protocolo de Internet (IP) em sistemas operacionais 
#			do tipo Unix, como Linux ou BSD. Ele permite que o host, endereços IP de 
#			sub-rede, nomes e/ou respostas de consulta ident, sejam usados como tokens 
#			sobre os quais realizam-se filtros para propósitos de controle de acesso.

#
# Site Oficial do Projeto OpenSSH: https://www.openssh.com/
# Site Oficial do Projeto OpenSSL: https://www.openssl.org/
# Site Oficial do Projeto Shell-In-a-Box: https://code.google.com/archive/p/shellinabox/
# Site Oficial do Projeto Neofetch: https://github.com/dylanaraps/neofetch
#
# Acesso remoto utilizando o GNU/Linux ou Microsoft Windows
#
# Linux Mint Terminal: Ctrl+Alt+T
# 	ssh vaamonde@172.16.1.20
#	ssh vaamonde@ssh.pti.intra
#
# Windows Powershell: Menu, Powershell 
#	ssh vaamonde@172.16.1.20
#	ssh vaamonde@ssh.pti.intra
#
# Linux Mint ou Windows:
#	apt install putty putty-tools
#	windows: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
#
# Verificando os usuários logados na sessão do OpenSSH Server no Ubuntu Server
# Terminal:
#	sudo who -a (show who is logged on)
#	sudo w (Show who is logged on and what they are doing)
#	sudo users (print the user names of users currently logged in to the current host)
#	sudo last -a | grep 'still logged in' (show a listing of last logged in users)
#	sudo ss | grep -i ssh (another utility to investigate sockets)
#	sudo netstat -tnpa | grep 'ESTABLISHED.*sshd' (show networking connection)
#	sudo ps -axfj | grep sshd (report a snapshot of the current processes)
#
# Gerando os pares de chaves Pública/Privadas utilizando o GNU/Linux
# Linux Mint Terminal: Ctrl+Alt+T
#	ssh-keygen
#		Enter file in which to save the key (/home/vaamonde/.ssh/id_rsa): /home/vaamonde/.ssh/vaamonde <Enter>
#		Enter passphrase (empty for no passphrase): <Enter>
#		Enter same passphrase again: <Enter>
#	ssh-copy-id vaamonde@172.16.1.20
#
# Importando os pares de chaves Públicas/Privadas utilizando o Powershell
# Windows Powershell: Menu, Powershell 
#	Primeira etapa: clicar com o botão direito do mouse e selecionar: Abrir como Administrador
#		Get-Service ssh-agent <Enter>
#		Set-Service ssh-agent -StartupType Manual <Enter> (Ou mudar para: Automatic)
#		Start-Service ssh-agent <Enter>
#
#	Segunda etapa: Powershell do perfil do usuário sem ser como administrador
#		ssh-add .\vaamonde <Enter>
#
# Arquivo de configuração dos parâmetros utilizados nesse script
source 00-parametros.sh
#
pacote=$(dpkg --get-selections | grep "figlet" )
	if [ -n "$pacote" ] ;then
		echo
	else
		apt-get install figlet -qq > /dev/null
	fi
# Configuração da variável de Log utilizado nesse script
LOG=$LOGSCRIPT
#
# Verificando se o usuário é Root e se a Distribuição é >= 20.04.x 
# [ ] = teste de expressão, && = operador lógico AND, == comparação de string, exit 1 = A maioria 
# dos erros comuns na execução
_Logo_Empresa
if [ "$_Usuario" == "0" ] && [ "$_VersaoUbuntu" == "20.04" ]
	then
	_Logo_Empresa
		echo -e "O usuário é Root, continuando com o script..."
		echo -e "Distribuição é >= 20.04.x, continuando com o script..."
		sleep 5
	else
	_Logo_Empresa
		echo -e "Usuário não é Root ($_Usuario) ou a Distribuição não é >= 20.04.x ($_VersaoUbuntu)"
		echo -e "Caso você não tenha executado o script com o comando: sudo -i"
		echo -e "Execute novamente o script para verificar o ambiente."
		exit 1
fi
#
# Verificando o acesso a Internet do servidor Ubuntu Server
# [ ] = teste de expressão, exit 1 = A maioria dos erros comuns na execução
# $? código de retorno do último comando executado, ; execução de comando, 
# opção do comando nc: -z (scan for listening daemons), -w (timeouts), 1 (one timeout), 443 (port)
if [ "$(nc -zw1 google.com 443 &> /dev/null ; echo $?)" == "0" ]
	then
	_Logo_Empresa
		echo -e "Você tem acesso a Internet, continuando com o script..."
		sleep 5
	else
	_Logo_Empresa
		echo -e "Você NÃO tem acesso a Internet, verifique suas configurações de rede IPV4"
		echo -e "e execute novamente este script."
		sleep 5
		exit 1
fi
#
# Verificando se a porta 22 está sendo utilizada no servidor Ubuntu Server
# [ ] = teste de expressão, == comparação de string, exit 1 = A maioria dos erros comuns na execução,
# $? código de retorno do último comando executado, ; execução de comando, 
# opção do comando nc: -v (verbose), -z (DCCP mode), &> redirecionador de saída de erro
if [ "$(nc -vz 127.0.0.1 $PORTSSH &> /dev/null ; echo $?)" == "0" ]
	then
	_Logo_Empresa
		echo -e "A porta: $PORTSSH está sendo utilizada pelo serviço do OpenSSH Server, continuando com o script..."
		sleep 5
	else
	_Logo_Empresa
		echo -e "A porta: $PORTSSH não está sendo utilizada nesse servidor."
		echo -e "Verifique as dependências desse serviço e execute novamente esse script.\n"
		sleep 5
		exit 1
fi
#
# Verificando se a porta 4200 está sendo utilizada no servidor Ubuntu Server
# [ ] = teste de expressão, == comparação de string, exit 1 = A maioria dos erros comuns na execução,
# $? código de retorno do último comando executado, ; execução de comando, 
# opção do comando nc: -v (verbose), -z (DCCP mode), &> redirecionador de saída de erro
if [ "$(nc -vz 127.0.0.1 $PORTSHELLINABOX &> /dev/null ; echo $?)" == "0" ]
	then
	_Logo_Empresa
		echo -e "A porta: $PORTSHELLINABOX já está sendo utilizada nesse servidor."
		echo -e "Verifique o serviço associado a essa porta e execute novamente esse script.\n"
		sleep 5
		exit 1
	else
	_Logo_Empresa
		echo -e "A porta: $PORTSHELLINABOX está disponível, continuando com o script..."
		sleep 5
fi
#
# Verificando todas as dependências do OpenSSH Server
# opção do dpkg: -s (status), opção do echo: -e (interpretador de escapes de barra invertida), 
# -n (permite nova linha), || (operador lógico OU), 2> (redirecionar de saída de erro STDERR), 
# && = operador lógico AND, { } = agrupa comandos em blocos, [ ] = testa uma expressão, retornando 
# 0 ou 1, -ne = é diferente (NotEqual)
_Logo_Empresa
echo -n "Verificando as dependências do OpenSSH Server, aguarde... "
	for name in $SSHDEP
	do
  		[[ $(dpkg -s $name 2> /dev/null) ]] || { 
              echo -en "\n\nO software: $name precisa ser instalado. \nUse o comando 'apt install $name'\n";
              deps=1; 
              }
	done
		[[ $deps -ne 1 ]] && echo "Dependências.: OK" || { 
            echo -en "\nInstale as dependências acima e execute novamente este script\n";
            exit 1; 
            }
		sleep 5
#
# Verificando se o script já foi executado mais de 1 (uma) vez nesse servidor
# OBSERVAÇÃO IMPORTANTE: OS SCRIPTS FORAM PROJETADOS PARA SEREM EXECUTADOS APENAS 1 (UMA) VEZ
if [ -f $LOG ]
	then
	_Logo_Empresa
		echo -e "Script $0 já foi executado 1 (uma) vez nesse servidor..."
		echo -e "É recomendado analisar o arquivo de $LOG para informações de falhas ou erros"
		echo -e "na instalação e configuração do serviço de rede utilizando esse script..."
		echo -e "Todos os scripts foram projetados para serem executados apenas 1 (uma) vez."
		sleep 5
		exit 1
	else
	_Logo_Empresa
		echo -e "Primeira vez que você está executando esse script, tudo OK, agora só aguardar..."
		sleep 5
fi
#
# Script de configuração do OpenSSH Server no GNU/Linux Ubuntu Server 20.04.x LTS
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
# opção do comando hostname: -I (all-ip-addresses)
# opção do comando cut: -d (delimiter), -f (fields)
_Logo_Empresa
echo -e "Início do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG
_Logo_Empresa
echo
#
echo -e "Configuração do OpenSSH Server no GNU/Linux Ubuntu Server 20.04.x\n"
echo -e "Porta padrão utilizada pelo OpenSSH Server.: TCP $PORTSSH"
echo -e "Porta padrão utilizada pelo Shell-In-a-Box.: TCP $PORTSHELLINABOX"
echo -e "Após a instalação do Shell-In-a-Box acessar a URL: https://$(hostname -I | cut -d' ' -f1):$PORTSHELLINABOX/\n"
echo -e "Aguarde, esse processo demora um pouco dependendo do seu Link de Internet...\n"
sleep 5
#
_Logo_Empresa
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
	# Universe - Software de código aberto mantido pela comunidade:
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
_Logo_Empresa
echo -e "Adicionando o Repositório Multiversão do Apt, aguarde..."
	# Multiverse – Software não suportado, de código fechado e com patente: 
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository multiverse &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
_Logo_Empresa
echo -e "Adicionando o Repositório Restrito do Apt, aguarde..."
	# Restricted - Software de código fechado oficialmente suportado:
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository restricted &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
_Logo_Empresa
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a saída padrão)
	apt update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
_Logo_Empresa
echo -e "Atualizando todo o sistema operacional, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes)
	apt -y upgrade &>> $LOG
	apt -y dist-upgrade &>> $LOG
	apt -y full-upgrade &>> $LOG
echo -e "Sistema atualizado com sucesso!!!, continuando com o script...\n"
sleep 5
#
_Logo_Empresa
echo -e "Removendo todos os software desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes)
	apt -y autoremove &>> $LOG
	apt -y autoclean &>> $LOG
echo -e "Software removidos com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Iniciando a Configuração do OpenSSH Server, aguarde...\n"
sleep 5
#
_Logo_Empresa
echo -e "Instalando as ferramentas básicas de rede do OpenSSH Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando apt: -y (yes)
	apt -y install $SSHINSTALL &>> $LOG
echo -e "Ferramentas instaladas com sucesso!!!, continuando com o script...\n"
sleep 5
#
_Logo_Empresa
echo -e "Atualizando os arquivos de configuração do OpenSSH Server, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando mkdir: -v (verbose)
	# opção do comando cp: -v (verbose)
	# opção do bloco e agrupamentos {}: (Agrupa comandos em um bloco)




	mv -v /etc/ssh/sshd_config /etc/ssh/sshd_config.old &>> $LOG
	mv -v /etc/default/shellinabox /etc/default/shellinabox.old &>> $LOG
	mv -v /etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf.old &>> $LOG
	mkdir -v /etc/neofetch/ &>> $LOG
	cp -v conf/ubuntu/config.conf /etc/neofetch/ &>> $LOG
	cp -v conf/ubuntu/neofetch-cron /etc/cron.d/ &>> $LOG
	cp -v conf/ubuntu/50-default.conf /etc/rsyslog.d/ &>> $LOG

cat <<EOF > /etc/hostname
	
	# Gerado:				cwb.systech.com.br -- Soluçoes em TI
	# Autor:				Jensy Gregorio Gomez
	# Bio:					Têcnico em Informatica e Eletronica
	# WhatsApp:				(41) 99896-2670    /    99799-3164
	# Date:					01/01/2022
	# Versão:				0.01
	#

	$_Nome_FQDN	
EOF

cat << EOF > /etc/hosts
	# Gerado:			cwb.systech.com.br -- Soluçoes em TI
	# Autor:			Jensy Gregorio Gomez
	# Bio:				Têcnico em Informatica e Eletronica
	# WhatsApp:			(41) 99896-2670    /    99799-3164
	# Date:				01/01/2022
	# Versão:			0.01
	#


	# Configuração do Banco de Dados de DNS Estático IPv4 do Servidor Local
	# IPv4		FQDN                    CNAME	
	127.0.0.1 	localhost.localdomain	localhost
	127.0.1.1 	$_Nome_FQDN $_Nome_Servidor
	$_Ip_V4_Servidor	$_Nome_FQDN	$_Nome_Servidor


	# Configuração do Banco de Dados de DNS Estático IPv6 do Servidor Local

	# IPV6	    FQDN                    CNAME
	::1 	    ip6-localhost           ip6-loopback
	fe00::0     ip6-localnet
	ff00::0     ip6-mcastprefix
	ff02::1     ip6-allnodes
	ff02::2     ip6-allrouters
EOF

cat << EOF > /etc/hosts.allow
	
	# Gerado:			cwb.systech.com.br -- Soluçoes em TI
	# Autor:			Jensy Gregorio Gomez
	# Bio:				Têcnico em Informatica e Eletronica
	# WhatsApp:			(41) 99896-2670    /    99799-3164
	# Date:				01/01/2022
	# Versão:			0.01



	# Comando utilizado para verificar se o serviço (daemon) de rede tem suporte ao 
	# TCPWrappers: ldd /usr/sbin/sshd | grep libwrap (Biblioteca LibWrap)
	# Logando todas as informações de acesso nos arquivos de Log's de cada serviço
	# em: /var/log/tcpwrappers-allow-*.log (* nome do serviço)
	#
	# Permitindo a Rede $_Network/$_Mascara se autenticar remotamente no Servidor de OpenSSH
	# DAEMON   CLIENT     OPTION
	sshd: $_Network/$_Mascara: spawn /bin/echo "$(date) - SSH - IP %a" >> /var/log/tcpwrappers-allow-ssh.log
	#
	# Permitindo a Rede $_Network/$_Mascara se autenticar remotamente no Servidor de MySQL
	# DAEMON   CLIENT     OPTION
	mysqld: $_Network/$_Mascara: spawn /bin/echo "$(date) - MySQL - IP %a" >> /var/log/tcpwrappers-allow-mysql.log
	#
	# Permitindo a Rede $_Network/$_Mascara se autenticar remotamente no Servidor de Telnet
	# DAEMON   CLIENT     OPTION
	in.telnetd: $_Network/$_Mascara: spawn /bin/echo "$(date) - Telnet - IP %a" >> /var/log/tcpwrappers-allow-telnet.log
	#
	# Permitindo a Rede $_Network/$_Mascara se autenticar remotamente no Servidor de FTP
	# DAEMON   CLIENT     OPTION
	vsftpd: $_Network/$_Mascara: spawn /bin/echo "$(date) - Vsftpd - IP %a" >> /var/log/tcpwrappers-allow-vsftpd.log
	#
	# Permitindo a Rede $_Network/$_Mascara se conectar remotamente no Servidor de TFTP
	# DAEMON   CLIENT     OPTION
	in.tftpd: $_Network/$_Mascara: spawn /bin/echo "$(date) - Tftpd - IP %a" >> /var/log/tcpwrappers-allow-tftpd.log
	#
	# Permitindo a Rede $_Network/$_Mascara se autenticar remotamente no Servidor de NFS
	# DAEMON		CLIENT			OPTION
	portmap: $_Network/$_Mascara: spawn /bin/echo "$(date) - Portmap - IP %a" >> /var/log/tcpwrappers-allow-nfs.log
	lockd: $_Network/$_Mascara: spawn /bin/echo "$(date) - Lockd - IP %a" >> /var/log/tcpwrappers-allow-nfs.log
	rquotad: $_Network/$_Mascara: spawn /bin/echo "$(date) - Rquotad - IP %a" >> /var/log/tcpwrappers-allow-nfs.log
	mountd: $_Network/$_Mascara: spawn /bin/echo "$(date) - Mountd - IP %a" >> /var/log/tcpwrappers-allow-nfs.log
	statd: $_Network/$_Mascara: spawn /bin/echo "$(date) - Statd - IP %a" >> /var/log/tcpwrappers-allow-nfs.log
	#
	# Permitindo que todas as redes acesse os serviços remotos do Servidor Bacula
	# DAEMON   CLIENT     OPTION
	bacula-fd: ALL: spawn /bin/echo "$(date) - Bacula-FD - IP %a" >> /var/log/tcpwrappers-allow-bacula.log
	bacula-sd: ALL: spawn /bin/echo "$(date) - Bacula-SD - IP %a" >> /var/log/tcpwrappers-allow-bacula.log
	bacula-dir: ALL: spawn /bin/echo "$(date) - Bacula-DIR - IP %a" >> /var/log/tcpwrappers-allow-bacula.log
	$_Nome_FQDN-fd: ALL: spawn /bin/echo "$(date) - Bacula-FD - IP %a" >> /var/log/tcpwrappers-allow-bacula.log
	$_Nome_FQDN-mon: ALL: spawn /bin/echo "$(date) - Bacula-MON - IP %a" >> /var/log/tcpwrappers-allow-bacula.log
	$_Nome_FQDN-dir: ALL: spawn /bin/echo "$(date) - Bacula-DIR - IP %a" >> /var/log/tcpwrappers-allow-bacula.log
	#
	# Exemplos de configuração do TCPWrappers do arquivo hosts.allow:
	# Permitindo uma Subrede ou nome de domínio FQDN
	# DAEMON   CLIENT     OPTION
	#sshd: 192.168.1. : spawn /bin/echo "$(date) Conexão Liberada - SSH - IP %a" >> /var/log/tcpwrappers-allow-ssh.log
	#sshd: 192.168.1.0/255.255.255.0: spawn /bin/echo "$(date) Conexão Liberada - SSH - IP %a" >> /var/log/tcpwrappers-allow-ssh.log
	#sshd: 192.168.1.0/$_Mascara: spawn /bin/echo "$(date) Conexão Liberada - SSH - IP %a" >> /var/log/tcpwrappers-allow-ssh.log
	#sshd: *.$_Nome_Dominio_FQDN: spawn /bin/echo "$(date) Conexão Liberada - SSH - IP %a" >> /var/log/tcpwrappers-allow-ssh.log
	#sshd: 192.168.1. EXCEPT 192.168.1.11: spawn /bin/echo "$(date) Conexão Liberada - SSH - IP %a" >> /var/log/tcpwrappers-allow-ssh.log

EOF

cat << EOF > /etc/hosts.deny
	# Gerado:			cwb.systech.com.br -- Soluçoes em TI
	# Autor:			Jensy Gregorio Gomez
	# Bio:				Têcnico em Informatica e Eletronica
	# WhatsApp:			(41) 99896-2670    /    99799-3164
	# Date:				01/01/2022
	# Versão:			0.01
	#

	# Comando utilizado para verificar se o serviço (daemon) de rede tem suporte 
	# ao TCPWrappers: ldd /usr/sbin/sshd | grep libwrap (Biblioteca LibWrap)
	# Negando todas as redes acessarem os serviços remotamente do Ubuntu Server, 
	# somente os serviços e redes configuradas no arquivo host.allow estão liberados 
	# para acessar o servidor.
	# Logando todas as informações de acesso negado de todos os serviços no arquivos 
	# de Log em: /var/log/tcpwrappers-deny-.log
	#
	# Negando todas as Redes de acessar remotamente os serviços no Servidor Ubuntu
	# DAEMON		CLIENT		OPTION
	ALL: ALL: spawn /bin/echo "$(date) Conexão Recusada - IP %a" >> /var/log/tcpwrappers-deny.log
	#
	# Exemplos de configuração do TCPWrappers do arquivo hosts.deny:
	# Negando uma subrede ou nome de domínio FQDN para um serviço
	#sshd: 192.168.1. : spawn /bin/echo "$(date) Conexão Recusada - SSH - IP %a" >> /var/log/tcpwrappers-deny.log
	#sshd: 192.168.1.0/255.255.255.0: spawn /bin/echo "$(date) Conexão Recusada - SSH - IP %a" >> /var/log/tcpwrappers-deny.logg
	#sshd: *.systech.brz: spawn /bin/echo "$(date) Conexão Recusada - SSH - IP %a" >> /var/log/tcpwrappers-deny.log
	#sshd: 192.168.1. EXCEPT 192.168.1.11: spawn /bin/echo "$(date) Conexão Recusada - SSH - IP %a" >> /var/log/tcpwrappers-deny.log
EOF

cat << EOF > /etc/issue.net
	**************************************************************************
	##########################################################################
	##          Acesso ao Servidor Remoto utilizando o OpenSSH              ##
	##########################################################################
	**************************************************************************
		_____               _   _    _____   ______   _____    _   _   _ 
		|  __ \      /\     | \ | |  / ____| |  ____| |  __ \  | | | | | |
		| |  | |    /  \    |  \| | | |  __  | |__    | |__) | | | | | | |
		| |  | |   / /\ \   | . ` | | | |_ | |  __|   |  _  /  | | | | | |
		| |__| |  / ____ \  | |\  | | |__| | | |____  | | \ \  |_| |_| |_|
		|_____/  /_/    \_\ |_| \_|  \_____| |______| |_|  \_\ (_) (_) (_)

	AVISO: O acesso nao autorizado a este sistema e proibido e sera processado
	conforme a lei.  Ao se conectar nesse sistema,  voce concorda que todas as
	suas acoes  serao monitoradas, caso  seja  verificado  o uso  indevido dos 
	recursos de acesso remoto nesse servidor, sera aplicado a lei vigente  com
	base nas diretivas da LGPD (Lei Geral de Protecao de Dados n: 13.709/2018)

		# Gerado:			cwb.systech.com.br -- Soluçoes em TI
		# Autor:			Jensy Gregorio Gomez
		# Bio:				Têcnico em Informatica e Eletronica
		# WhatsApp:			(41) 99896-2670    /    99799-3164
		# Date:				01/01/2022
		# Versão:			0.01

	**************************************************************************
	##########################################################################
	**************************************************************************
EOF

cat << EOF > etc/nsswitch.conf

	# Gerado:			cwb.systech.com.br -- Soluçoes em TI
	# Autor:			Jensy Gregorio Gomez
	# Bio:				Têcnico em Informatica e Eletronica
	# WhatsApp:			(41) 99896-2670    /    99799-3164
	# Date:				01/01/2022
	# Versão:			0.01
	#

	# Configuração do acesso a informações de usuários, grupos e senhas.
	# Padrão consultar primeiro os arquivos (files) depois o sistema (systemd)
	# DATABASE       SERVICE
	passwd:          files systemd
	group:           files systemd
	shadow:          files
	gshadow:         files
	#
	# Configuração da forma de resolução de nomes de computadores.
	# Padrão consultar primeiro os arquivos (files) depois o serviço de DNS
	# DATABASE       SERVICE
	hosts:           files dns
	networks:        files
	#
	# Configuração da consultada dos serviços de rede
	# Padrão consultar primeiro o banco de dados local (db) depois os arquivos (files)
	# DATABASE       SERVICE
	protocols:       db files
	services:        db files
	ethers:          db files
	rpc:             db files
	#
	# Configuração da consulta de resolução do serviço de Grupos de Rede
	# Padrão consultar primeiro os serviço de rede NIS (Network Information Service)
	# DATABASE       SERVICE
	netgroup:        nis
EOF

	cp -v conf/ubuntu/vimrc /etc/vim/ &>> $LOG

cat << EOF > /etc/ssh/sshd_config
	# Testado e homologado para a versão do OpenSSH Server v8.2.x
	#
	# Incluindo o diretório de configuração personalizada do OpenSSH Server
	Include /etc/ssh/sshd_config.d/*.conf
	#
	# Porta de conexão padrão do Servidor de OpenSSH, por segurança é recomendado mudar 
	# o número da porta. Caso você mude o número da porta, no cliente você precisa usar 
	# o comando: ssh -p porta usuário@ip_do_servidor
	Port $_PortSsh
	#
	# Versão do protocolo padrão do Servidor de OpenSSH
	Protocol 2
	#
	# Endereço IPv4 do Servidor de OpenSSH que está liberado para permitir conexões remotas 
	# via protocolo SSH
	ListenAddress $_Ip_V4_Servidor
	#
	# Métodos de Autenticação do OpenSSH, utilizar chaves públicas e autenticação por senha
	# Por padrão o Servidor de OpenSSH não trabalhar com Chaves Pública para autenticação, 
	# utilizando o arquivo /etc/passwd para se autenticar no servidor, por motivos de segurança, 
	# é recomendado utilizar chaves públicas e senhas para se autenticar no servidor
	# Descomentar essa opção depois de configurar a chave pública no client e no servidor
	# OBSERVAÇÃO: O Shell-In-a-Box não tem suporte a autenticação via Chave Pública somente 
	# autenticação padrão, para esse cenário é recomendado utilizar a solução Bastillion 
	# (https://www.bastillion.io/)
	#AuthenticationMethods publickey,password
	AuthenticationMethods password
	#
	# Autenticação utilizando chaves públicas geradas no cliente com o comando: ssh-keygen 
	# e exportada para o servidor com o comando: ssh-copy-id, chaves localizadas no diretório: 
	# /home/nome_usuário/.ssh/authorized_keys. Essa opção será utiliza em conjunto com a 
	# opção: AuthenticationMethods para verificar a chave pública.
	PubkeyAuthentication yes
	#
	# Especifica se a autenticação por senha é permitida. O padrão é yes. Não é recomendado 
	# alterar essa opção.
	PasswordAuthentication yes
	#
	# Configuração do diretório de chaves públicas para autenticar os usuários, as chaves 
	# devem ser exportada para o Servidor de OpenSSH utilizando o comando: ssh-copy-id
	AuthorizedKeysFile .ssh/authorized_keys
	#
	# Evitar o uso de diretórios residenciais inseguros e permissões de arquivos de chaves 
	# não confiáveis
	StrictModes yes
	#
	# Localização das configurações das Chaves Públicas e Privadas do Servidor de OpenSSH
	HostKey /etc/ssh/ssh_host_rsa_key
	HostKey /etc/ssh/ssh_host_dsa_key
	HostKey /etc/ssh/ssh_host_ecdsa_key
	HostKey /etc/ssh/ssh_host_ed25519_key
	#
	# Limite as cifras àquelas aprovadas pelo FIPS e use somente cifras no modo contador (CTR).
	Ciphers aes128-ctr,aes192-ctr,aes256-ctr
	#
	# Configuração dos Log's do Servidor de OpenSSH, recomendado utilizar junto com os 
	# arquivos de configuração: hosts.allow e hosts.deny para geração de log´s detalhados 
	# das conexões ao Servidor de OpenSSH.
	# Log's de autenticação do OpenSSH: sudo cat -n /var/log/auth.log | grep -i sshd
	# Log's de serviço do OpenSSH: sudo cat -n /var/log/syslog | grep -i ssh
	# Log's do TCPWrappers Allow: sudo cat -n /var/log/tcpwrappers-allow-ssh.log
	# Log's do TCPWrappers Deny: sudo cat -n /var/log/tcpwrappers-deny-ssh.log
	SyslogFacility AUTH
	LogLevel INFO
	#
	# Negar o acesso remoto ao Servidor de OpenSSH para o usuário ROOT
	PermitRootLogin no
	#
	# Usuários que tem permissão de acesso remoto ao Servidor de OpenSSH, separados por 
	# espaço, deve existir no servidor. Usuários listados no arquivo /etc/passwd
	AllowUsers $_UsuarioDefault
	#
	# Grupos que tem permissão de acesso remoto ao Servidor de OpenSSH, cuidado, se você 
	# usar a variável AllowUsers o grupo padrão do usuário precisa está liberado na linha 
	# AllowGroups, separados por espaço, deve existir no servidor. Grupos listados no 
	# arquivo /etc/group
	AllowGroups $_UsuarioDefault
	#
	# Usuários que não tem permissão de acesso remoto ao Servidor de OpenSSH, separados 
	# por espaço, deve existir no servidor. Usuários listados no arquivo /etc/passwd
	DenyUsers root
	#
	# Grupos que não tem permissão de acesso remoto ao Servidor de OpenSSH, cuidado, se 
	# você usar a variável DenyUsers o grupo padrão do usuário precisa está bloqueado 
	# na linha DenyGroups, separados por espaço, deve existir no servidor. Grupos 
	# listados no arquivo /etc/group
	DenyGroups root
	#
	# Banner que será apresentado no momento do acesso remoto ao Servidor de OpenSSH, 
	# não é recomendado utilizar acentuação
	Banner /etc/issue.net
	#
	# Tempo após o qual o servidor será desconectado se o usuário não tiver efetuado 
	# login com êxito.
	LoginGraceTime 60
	#
	# Tempo de inatividade em segundos para que os usuários logados na sessão do 
	# Servidor de OpenSSH sejam desconectados. Se você utiliza o recurso do Visual 
	# Studio Code VSCode com Remote SSH, recomendo comentar ou aumentar o tempo da sessão
	ClientAliveInterval 1800
	ClientAliveCountMax 3
	#
	# Tentativa máxima de conexões simultâneas no Servidor de OpenSSH
	MaxAuthTries 3
	#
	# Número de usuários ou sessões que podem se conectar remotamente no Servidor de OpenSSH
	MaxSessions 3
	#
	# Especifica o número máximo de conexões simultâneas não autenticadas com o OpenSSH 
	# para ser rejeitado a conexão. 5=conexão não autenticada | 60=rejeitar 60% das conexões 
	# | 10=tentativas de conexão
	MaxStartups 5:60:10
	#
	# Especifica qual família de endereços IP o OpenSSH deve suportar.
	# Os argumentos válidos são: any (IPv4 e IPV6), inet (somente IPv4), inet6 (somente IPv6)
	AddressFamily inet
	#
	# Não ler os arquivos de configurações ~/.rhosts e ~/.shosts
	IgnoreRhosts yes
	HostbasedAuthentication no
	#
	# Não permitir que usuários sem senhas se autentique remotamente no Servidor de OpenSSH
	PermitEmptyPasswords no
	#
	# Não permitir que os usuários definam opções de ambiente, utilizar os pré-definidos
	PermitUserEnvironment no
	#
	# Especifica se o encaminhamento de TCP é permitido. O padrão é yes. Se você utiliza o 
	# recurso do Visual Studio Code VSCode com Remote SSH, recomendo deixar yes
	AllowTcpForwarding no
	#
	# Não permitir encaminhamento de portas via Servidor de OpenSSH para os serviços de 
	# X11 (ambiente gráfico)
	X11Forwarding no
	#
	# Especifica o primeiro número de exibição disponível para encaminhamento X11 do 
	# sshd. Isso evita que o sshd interfira nos servidores X11 reais. O padrão é 10.
	X11DisplayOffset 10
	#
	# Controla o suporte para o esquema de autenticação "keyboard-interactive" definido 
	# no RFC-4256. Utilizar um desafio para se autenticar, muito utilizado com QRCode
	ChallengeResponseAuthentication no
	#
	# Utilizar autenticação de usuário via PAM (Linux Pluggable Authentication), essa 
	# opção só vai funcionar se o Serviço do PAM esteja configurado no Servidor
	UsePAM yes
	#
	# Imprimir na tela a mensagem de boas vindas do dia no login do OpenSSH
	PrintMotd no
	#
	# Imprimir na tela o Log da última autenticação válida da sessão do OpenSSH na tela
	PrintLastLog yes
	#
	# Especifica quais variáveis de ambiente enviadas pelo cliente serão copiadas para 
	# o ambiente da sessão após se autenticar no SSH
	AcceptEnv LANG LC_*
	#
	# Configura um subsistema externo (por exemplo, daemon de transferência de arquivo). 
	# Os argumentos devem ser um nome de subsistema e um comando (com argumentos opcionais) 
	# para executar mediante solicitação do subsistema.
	Subsystem sftp /usr/lib/openssh/sftp-server
	#
	# Especifica se o sistema deve enviar mensagens de manutenção de atividade TCP para o 
	# outro lado. Se forem enviados, será devidamente notado a morte da conexão ou travamento 
	# de uma das máquinas.
	TCPKeepAlive yes
	#
	# Desativar os mecanismos de autenticação desnecessários para fins de segurança
	KerberosAuthentication no
	GSSAPIAuthentication no
	#
	# Ativar a compactação após autenticação bem-sucedida (aumentar a segurança e desempenho)
	Compression delayed
	#
	# Não procure o nome do host remoto utilizando o serviço do DNS
	UseDNS no
EOF

cat <<EOF > /etc/default/shellinabox
	# Gerado:			cwb.systech.com.br -- Soluçoes em TI
	# Autor:			Jensy Gregorio Gomez
	# Bio:				Têcnico em Informatica e Eletronica
	# WhatsApp:			(41) 99896-2670    /    99799-3164
	# Date:				01/01/2022
	# Versão:			0.01
	#

	# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64
	# Testado e homologado para a versão do OpenSSH Server v8.2.x
	# Testado e homologado para a versão do Shell-In-a-Box v2.x
	#
	# Configuração do inicialização automática do Shell-In-a-Box como serviço
	SHELLINABOX_DAEMON_START=1
	#
	# Porta padrão utilizada pelo Webservice do Shell-In-a-Box
	SHELLINABOX_PORT=$_PortShellInbox
	#
	# Configuração do Usuário e Grupo padrão do serviço do Shell-In-a-Box
	SHELLINABOX_USER=shellinabox
	SHELLINABOX_GROUP=shellinabox
	#
	# Localização padrão do diretório de informações de acesso do Shell-In-a-Box
	SHELLINABOX_DATADIR=/var/lib/shellinabox
	#
	# Configurações dos argumentos utilizados pelo Shell-In-a-Box
	# --no-beep: bipes são desativados devido a relatos de falha do plug-in VLC no Firefox
	# --service=/:SSH: configuração do endereço IPv4 do servidor de OpenSSH Server
	# Mais opções de argumentos veja a documentação oficial do Shell-In-a-Box no Link:
	# https://manpages.debian.org/unstable/shellinabox/shellinaboxd.1.en.html
	SHELLINABOX_ARGS="--no-beep --service=/:SSH:$_Ip_V4_Servidor"
EOF

	cp -v $_Netplan $_Netplan.old &>> $LOG
cat <<EOF > $_Netplan
	
	# Gerado:			cwb.systech.com.br -- Soluçoes em TI
	# Autor:			Jensy Gregorio Gomez
	# Bio:				Têcnico em Informatica e Eletronica
	# WhatsApp:			(41) 99896-2670    /    99799-3164
	# Date:				01/01/2022
	# Versão:			0.01
	#

	# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64

	# Mais informações veja o arquivo: scripts/settings/04-ConfiguracaoDoNetplan.sh
	# Após as configuração do endereço IPv4 digitar o comando: netplan --debug apply
	#
	# Configuração do Endereço IPv4 do Ubuntu Server
network:
  
  ethernets:

    $_Interface_Lan:

      #dhcp4: true

      addresses:
      - $_Ip_V4_Servidor/$_Mascara

      gateway4: $_Gateway

      nameservers:
        addresses:
        #- 172.16.1.20
        - $_Gateway
        #- 8.8.8.8
        #- 8.8.8.8

        search:
        - $_Nome_Dominio

  # Configuração da versão do Protocolo Ethernet do Ubuntu Server
  version: 2
EOF

	
echo -e "Arquivos atualizados com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo $_Netplan, pressione <Enter> para continuar.\n"
echo -e "CUIDADO!!!: o nome do arquivo de configuração da placa de rede pode mudar"
echo -e "dependendo da versão do Ubuntu Server, verifique o conteúdo do diretório:"
echo -e "/etc/netplan para saber o nome do arquivo de configuração do Netplan e altere"
echo -e "o valor da variável NETPLAN no arquivo de configuração: 00-parametros.sh"
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim $_Netplan
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração hostname, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/hostname
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração hosts, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/hosts
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração nsswitch.conf, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/nsswitch.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração sshd_config, pressione <Enter> para continuar."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando read: -s (Do not echo keystrokes)
	# opção do comando sshd: -t (text mode check configuration)
	read -s
	vim /etc/ssh/sshd_config
	sshd -t &>> $LOG
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração hosts.allow, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/hosts.allow
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração hosts.deny, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/hosts.deny
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração issue.net, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/issue.net
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração shellinabox, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/default/shellinabox
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração config.conf, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/neofetch/config.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração neofetch-cron, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/cron.d/neofetch-cron
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração 50-default.conf, pressione <Enter> para continuar."
	# opção do comando read: -s (Do not echo keystrokes)
	read -s
	vim /etc/rsyslog.d/50-default.conf
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Criando o arquivo personalizado de Banner em: /etc/motd, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	# opção do comando chmod: -v (verbose), -x (remove executable)
	neofetch --config /etc/neofetch/config.conf > /etc/motd
	chmod -v -x /etc/update-motd.d/* &>> $LOG
echo -e "Arquivo criado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Aplicando as mudanças da Placa de Rede do Netplan, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	netplan --debug apply &>> $LOG
echo -e "Mudanças aplicadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Reinicializando os serviços do OpenSSH Server e do Shell-In-a-Box, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	systemctl restart sshd &>> $LOG
	systemctl restart shellinabox &>> $LOG
echo -e "Serviços reinicializados com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando os serviços do OpenSSH Server e do Shell-In-a-Box, aguarde..."
	echo -e "OpenSSH....: $(systemctl status sshd | grep Active)"
	echo -e "Shellinabox: $(systemctl status shellinabox | grep Active)"
echo -e "Serviços verificados com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando as portas de conexões do OpenSSH Server e do Shell-In-a-Box, aguarde..."
	# opção do comando lsof: -n (inhibits the conversion of network numbers to host names for 
	# network files), -P (inhibits the conversion of port numbers to port names for network files), 
	# -i (selects the listing of files any of whose Internet address matches the address specified 
	# in i), -s (alone directs lsof to display file size at all times)
	lsof -nP -iTCP:'22,4200' -sTCP:LISTEN
echo -e "Portas verificadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Configuração do OpenSSH Server feita com Sucesso!!!."
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=$(date +%T)
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG
read
exit 1
