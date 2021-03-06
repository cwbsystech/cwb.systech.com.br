Dashboard do pfSense: https://docs.netgate.com/pfsense/en/latest/monitoring/dashboard.html
Configurações Gerais do pfSense: https://docs.netgate.com/pfsense/en/latest/config/general.html
Configurações de Atualização: https://docs.netgate.com/pfsense/en/latest/install/upgrade-guide.html

Configurações Gerais do Dashboard do pfSense
System
	General Setup
		webConfigurator
			Theme: pfsense-dark
			Top Navigation: Scroll with pages
			Hostname in Menu: Fully Qualified Domain Name
			Dashboard Columms: 3
			_Lans Sort: ON
			Associated Panels Show/Hide
				Available Widgest: ON
				Log Filter: ON
				Manage Log: ON
				Monitoring Settings: ON
			Login page color: Dark Blue
			Login hostname: ON
	Save

Desativar verificação de atualização no Dashboard
System
	Update
		Update Settings
			Updates
				Dashboard check: ON
		Save

Configuração do Dashboard do pfSense
Dashboard
	Available Widgest
		#Configuração dos Widgest Lado Esquerdo
			Picture: - Left-01
				Widgest title: BoraParaPratica
				New pictures: image.png
				Save
			System Information: ON - Left-02
		#Configuração dos Widgest Centro
			_Lans: ON - Center-01
			Gateways: ON - Center-02
			_Lan Statistics: ON - Center-03
			Traffic Graphs: ON - Center-04
			Service Status: ON - Center-05
		#Configuração dos Widgest Lado Direito
			NTP Status: ON - Right-01
			Dynamic DNS Status: ON - Right-02
			IPSec: ON - Right-03
			OpenVPN: ON - Right-04
			Firewall Logs: ON - Right-05
				Edit
				Widgest: Firewall Logs 
				Number of entries: 15
				Filter actions: ON Pass, ON Block and ON Reject
				Filter _Lan: ALL 
				Update interval: 5 Seconds
				Save
Save