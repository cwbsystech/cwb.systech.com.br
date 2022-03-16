Opções do Console do pfSense: https://docs.netgate.com/pfsense/en/latest/config/console-menu.html

Opções do Console do Netgate pfSense
	0) Logout (SSH only) - sair do acesso remoto via SSH
	1) Assign _Lans - ativação e atribuição de _Lans de Rede
	2) Set _Lan(s) IP address - configuração do Endereço IPv4, IPv6 e DHCP Server
	3) Reset WebConfigurator password - resetar para a senha padrão (pfSense) do usuário admin o acesso via WebGui
	4) Reset to factory defaults - resetar para as configurações padrão do pfSense
	5) Reboot system - reinicializar o pfSense
	6) Halt system - desligar o pfSense
	7) Ping host - testar a conectividade de rede LAN ou WAN com o comando ping no pfSense
	8) Shell - acessar o Bash/Shell do pfSense
	9) pfTop - software de monitoramento de protocolo de conexões de rede LAN ou WAN do pfSense
	10) Filter Logs - filtros dos logs referente as regras de Firewall de LAN ou WAN do pfSense
	11) Restart WebConfigurator - reinicializar o WebConfigurator após uma falha de acesso via navegador
	12) PHP Shell + pfSense tools - acesso ao PHP Shell e conjunto de ferramentas de desenvolvedor do pfSense
	13) Update from console - atualização do pfSense via console
	14) Enable Secure Shell (sshd) - habilitar ou desabilitar o acesso seguro via SSH via console
	15) Restore recent configuration - restauração da última configuração válida do pfSense via console
	16) Restart PHP-FPM - reinicializar o serviço do PHP-FPM (FastCGI Process Manager) do WebConfigurator

Primeira etapa: Endereçamento das _Lans do pfSense
01. _Lan WAN: Padrão de configuração via DHCP
02. _Lan LAN: Padrão de configuração de Endereço IP Estático
03. Endereço IPv4 Padrão da _Lan de LAN do pfSense: 192.168.1.1/24

Atribuição de _Lans do pfSense: https://docs.netgate.com/pfsense/en/latest/config/console-menu.html#assign-_Lans

Segunda etapa: Atribuição das _Lans do pfSense
01. Atribuição das _Lans de WAN e LAN
	1) Assign _Lans
		Should VLANs be set up now [y/n]? n <Enter>
		Enter the WAN _Lan name or 'a' for auto-detection
			(em0 em1 or a): em0 <Enter>
		Enter the LAN _Lan name or 'a' for auto-detection
		NOTE: this enables full Firewalling/NAT mode.
			(em1 a or nothing if finished): em1 <Enter>
		Do you want to proceed [y/n]? y <Enter>

Configuração das _Lans do pfSense: https://docs.netgate.com/pfsense/en/latest/config/console-menu.html#set-_Lan-s-ip-address

Terceira etapa: Configuração do Endereço de Rede Local e DHCP Server
01. Setando o Endereçamento IPv4 ou IPV6 das _Lans de WAN e LAN
	2) Set _Lan(s) IP address
		Enter the number of the _Lan you wish to configure: 2 <Enter>
		Enter the new LAN IPv4 address.
			> 173.169.73.254 <Enter>
		Enter the new LAN IPv4 subnet.
			> 24 <Enter>
		For a WAN, enter the new LAN IPv4 upstream gateway address
		For a LAN, press <Enter> for nome:
			> <Enter>
		Enter the new LAN IPv6 address.
			> <Enter>
		Do you want to enable the DHCP server on LAN? (y/n): y <Enter>
		Enter the start address of the IPv4 client address range: 173.169.73.50 <Enter>
		Enter the end address fo the IPv4 client address range: 173.169.73.150 <Enter>
		Do you want to revert to HTTP as the WebConfigurator protocol? (y/n): y <Enter>	
		Press <Enter> to continue.

Teste de conectividade do pfSense: https://docs.netgate.com/pfsense/en/latest/config/console-menu.html#ping-host

Quarta Etapa: Verificação da conexão com a Internet na _Lan WAN
01. Testando a conectividade com a Internet
	7) Ping host
		Enter a host name or IP address: google.com <Enter>
		Press <Enter> to continue.