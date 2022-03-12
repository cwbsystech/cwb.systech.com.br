Criação de Apelidos: https://docs.netgate.com/pfsense/en/latest/firewall/aliases.html
NAT Encaminhamento de Portas: https://docs.netgate.com/pfsense/en/latest/nat/port-forwards.html
Configuração das Regras de Firewall: https://docs.netgate.com/pfsense/en/latest/firewall/configure.html

Criando os apelidos no pfSense
Firewall
	Aliases
		IP
			+ADD
				Properties
					Name: ControladorDominioUCS
					Description: Servidor Primario UCS Univention
					Type: Host(s)
				Host(s)
					IP or FQDN: 173.169.73.1 				- Description: 		IP
					IP or FQDN: UCS-DC-01  					- Description: 		Hostname 
					IP or FQDN: UCS-DC-01.systech.brz  		- Description: 		FQDN
			Save
	Apply Changes



Criando os apelidos no pfSense
Firewall
	Aliases
		PORTS
			+ADD
				Properties
					Name								:PortasUCSPrimario
					Description							:Portas acesso Remoto ao UCSPrimario
					Type								:Port(s)
				Port(s)
					Port		: 2201					:Description: 		SSH
					Port		: 44301					:Description: 		HTTPS
					Port		: 8001					:Description: 		HTTP
			Save
	Apply Changes









Criando as regras de NAT no pfSense SSH
Firewall
	NAT
		Port Forward
			ADD
				Edit Redirect Entry
					Disabled: Off
					No RDR(NOT): Off
					Interface: WAN
					Address Family: IPv4
					Protocol: TCP
					Source: Default
					Destination
						Invert match: Off
						WAN Address
					Destination port range: 
						From port: OTHER
						Custom: Default
						To port: 	SSH
						Custom: 	2201
					Redirect target IP:
						Type: Single host
						Address: 	ControladorDominioUCS
					Redirect target port: 
						Port: SSH
						Custom: Default
					Description: Redirecionamento Externo da Porta 22 SSH do UCS Univention
					No XMLRPC Sync: Off
					NAT reflection: Use system default
					Filter rule association: Add association filter rule
			Save
		Apply Changes

		+Separator
			Enter a description: Regras de NAT do Servidor UCS Univention - Color: Blue
		Save

Configurando as regras de Firewall na Interface WAN do pfSense
Firewall
	Rules
		WAN
			Edit
				Extra Options
					Log: ON
					Description: NAT Redirecionamento Externo da Porta 22 SSH do UCS Univention
			Save
		Apply Changes
		
		+Separator
				Enter a description: Regras de NAT do Servidor UCS Univention - Color: Blue
		Save

######################################################
######################################################
		Criando as regras de NAT no pfSense HTTPS
Firewall
	NAT
		Port Forward
			ADD
				Edit Redirect Entry
					Disabled: Off
					No RDR(NOT): Off
					Interface: WAN
					Address Family: IPv4
					Protocol: TCP
					Source: Default
					Destination
						Invert match: Off
						WAN Address
					Destination port range: 
						From port: 	Other
						Custom: 	44301
						To port: 	Other
						Custom: 	44301
					Redirect target IP:
						Type: Single host
						Address: 	ControladorDominioUCS
					Redirect target port: 
						Port: 		HTTPS
						Custom: 	Default
					Description: Redirecionamento Externo da Porta 443 HTTPS do UCS Univention
					No XMLRPC Sync: Off
					NAT reflection: Use system default
					Filter rule association: Add association filter rule
			Save
		Apply Changes


Configurando as regras de Firewall na Interface WAN do pfSense
Firewall
	Rules
		WAN
			Edit
				Extra Options
					Log: ON
					Description:	Redirecionamento Externo da Porta 443 HTTPS do UCS Univention
			Save
		Apply Changes
		
		+Separator
				Enter a description: Redirecionamento Externo da Porta 443 HTTPS do UCS Univention - Color: Blue
		Save


		Para Acessar
		endereco porta WAN Porta SSH 22 	ssh -p 220X root@192.168.1.110

		endereco porta WAN Porta HTTPS 443 	https://192.168.1.110:8430X

		endereco porta WAN Porta HTTP 80 	http://192.168.1.110:800X

	