Atualização da versão do pfSense 2.5.2: https://docs.netgate.com/pfsense/en/latest/releases/2-5-2.html
Versão anterior do pfSense 2.5.1: https://docs.netgate.com/pfsense/en/latest/releases/21-02-2_2-5-1.html
Versão base do pfSense 2.5.0: https://docs.netgate.com/pfsense/en/latest/releases/2-5-0.html

Servidores de DNS recomendados para serem utilizados no pfSense
DNS Google..............: Preferencial: 8.8.8.8 - Secundário: 8.8.4.4
OpenDNS Cisco...........: Preferencial: 208.67.222.222 - Secundário: 208.67.220.220
OpenDNS FamilyShield....: Preferencial: 208.67.222.123 - Secundário: 208.67.220.123
CloudFlare..............: Preferencial: 1.1.1.1 - Secundário: 1.0.0.1
CloudFlare FamilyShield.: Preferencial: 1.1.1.3 - Secundário: 1.0.0.3

Assistente de configuração pfSense: https://docs.netgate.com/pfsense/en/latest/config/setup-wizard.html

Primeira etapa: Acessando o pfSense via Navegador (recomendado utilizar o Navegador Firefox)
01. Acessar o endereço IPv4: http://173.169.730.254
	Sign In
		Username: admin 
		Password: pfsense
		Sign In
	pfSense Setup
		Welcome to pfSense® software!
		<Next>
	Netgate® Global Support is available 24/7
		<Next>
	General Information
		Hostname: firewall
		Domain: cwbpr.systech.brz
		Primary DNS Server: 8.8.8.8
		Secondary DNS Server: 8.8.4.4
		Override DNS: (Disable)
		<Next>
	Time Server Information
		Time server hostname: a.st1.ntp.br
		Timezone: America/Sao_Paulo
		<Next>
	Configure WAN _Lan
		SelectedType: DHCP
		General configuration
			MAC Address: (default)
			MTU: (default)
			MSS: (default)
		RFC1918 Networks
			Block RFC1918 Private Networks: (Disable)
			Block bogon networks: (Disable)
		<Next>
	Configure LAN _Lan
		LAN IP Address: 173.169.73.254
		Subnet Mask: 24
		<Next>
	Set Admin WebGUI Password
		Admin Password: News_Password
		Admin Password AGAIN: Renew_Password
		<Next>
	Reload configuration
		<Reload>
	Wizard completed.
		<Finish>
02. Copyright and Trademark Notices.
	<Accept>
	Thank you!
	<Close>