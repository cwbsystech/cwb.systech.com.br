################################################################
################################################################
####														####
####            CRIAÇÃO VM NO PROXMOX		           		####
####														####
################################################################
################################################################

Segunda etapa: Criação e Configuração da Máquina Virtual no Oracle VirtualBOX
01. Ferramentas;
		Novo
			Nome e Sistema Operacional:
			Nome: UCS Univention 5.0
			Pasta da Máquina: (deixar o padrão do sistema) 
			Tipo: Linux
			Versão: Debian (64-bit)
			<Próximo>
		Tamanho da memória:
			Tamanho: 4096MB
			<Próximo>
		Disco Rígido:
			Criar um novo disco rígido virtual agora
			<Criar>
				Tipo de arquivo de disco rígido
				VDI (VirtualBOX Disk Image)
				<Próximo>
			Armazenamento em disco rígido físico
				Dinamicamente alocado
				<Próximo>
			Localização e tamanho do arquivo
				Localização: (deixar o padrão do sistema)
				Tamanho do disco: 50GB
				<Criar>

08. Configurações da Máquina Virtual UCS (Propriedades/Configurações)
	Sistema
		Processador
			Processadores: 02 CPUs
			Recursos Estendidos: Habilitar PAE/NX
	Monitor
		Tela
			Memória de Vídeo: 128MB
			Aceleração: Habilitar Aceleração 3D
	Áudio
		Habilitar Áudio: Desabilitar
	Rede
		Adaptador 1 (WAN)
			Habilitar Placa de Rede
			Conectado a: Rede Interna
			Nome: (deixar o padrão do sistema: intnet)
	<OK>










################################################################
################################################################
####														####
####            INSTALANDO O UCS UNIVENTION           		####
####														####
################################################################
################################################################

Terceira Etapa: Instalando o UCS Univention 5.0.x Core Free
01. Parar o Boot do Grub do UCS Univention
		Start with manual network settings <Enter>
02. Select a Language
		English - English 
		<Continue>
03. Select your Location
		other
			South America
				Brazil 
		<Continue>
04. Configure Locales
		United States - en_US.UTF-8
		<Continue>
05. Configure the Keyboard
		American English
		<Continue>
06. Configure the network
		IP address: 173.169.73.3/24
		<Continue>
07. Configure the network
		Gateway: 173.169.73.254
		<Continue>
08. Configure the network
		Name server addresses: 173.169.73.1 173.169.73.2
		<Continue>
09. Se up users and passwords
		Root password: 												Casado#55
		Re-enter password to verify: 								Casado#55
		<Continue>
10. Partition disks
		Partitioning method: Guided - use entire disk and set up LVM
		<Continue>

11. Partition disks
		Select disk to partition: SCSI3 (0,0,0)(sda) - 20,7 GB ATA VBOX HARD DISK
		<Continue>

12 Partition disks
		Partitioning scheme: Separate /home, /var and /tmp partitions
		<Continue>

13  Partition disks
		Write the changes to disks and configure? Yes
		<Continue>

14  Partition disks
		Write the changes to disks? Yes
		<Continue>

15. Finish the installation
		<Continue>





################################################################
################################################################
####														####
####            CONFIGURAÇAO DO UCS			           		####
####														####
################################################################
################################################################



01. Domain setup
		Join into an existing UCS domain
		<Next>

02. System role
		Managed Node
		<Next>

03. Domain join information
		[Select] Start join at the end of the installation
		[Select] Search Primary Directory Node in DNS
		Hostname of the Primary Directory Node:						UCS-DC-01.systech.brz
		Username: 													administrator
		Password: 													Casado#55
		<Next>

04. Host settings
		Specify the name of this system: 							Gerenciado.systech.brz
		<Next>

05. Confirm configuration settings
		[Disable] Update system after setup
		<Configure System>

06. UCS setup successful
		<Finish>




################################################################
################################################################
####														####
####            ATUALIZANDO O UCS UNIVENTION           		####
####														####
################################################################
################################################################


Quinta etapa: Atualizando o UCS Univention 5.0.x Core Free
01. Login
		login: root <Enter>
		password: Casado#55 <Enter>
02. Upgrade
		univention-upgrade <Enter>
		Do you want to continue [Y|N]? Y <Enter>
		
		apt update
		apt upgrade
		apt -y autoremove
		apt autoclean


		
03. Reboot
		reboot <Enter>






################################################################
################################################################
####														####
####            		ZEROTIER				       		####
####														####
################################################################
################################################################


01.	Instalacion
		curl -s https://install.zerotier.com | bash

		zerotier-cli join xxxxxxxxxxxxx

02. Aprovação no site do Zerotier
		Members
			Autorizar									Sim 	
			Name/Description							UCSGerenciado
			Managed IPs									10.147.18.3

03. Conectar via SSH com PUTTY
		Host Name (or IP Addres)						10.147.18.3
		Port											22
		Save Sessions									UCSGerenciado Zerotier
		Save









