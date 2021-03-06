Gerenciamento de autoridade de certificação do pfSense: https://docs.netgate.com/pfsense/en/latest/certificates/ca.html
CA do pfSense: https://docs.netgate.com/pfsense/en/latest/certificates/index.html
Configurando o suporte ao HTTPS do pfSense: https://docs.netgate.com/pfsense/en/latest/config/advanced-admin.html

Configuração do CA (Certificate Authority) e do Certificado SSL do pfSense
System
	Cert. Manager
		CAs
			+ADD
				Create / Edit CA
					Descriptive name: BoraParaPratica
					Method: Create an internal Certificate Authority
					Trust Store: (default)
					Randomize Serial: (default)
				Internal Certificate Authority
					Key type: RSA
					Key length (bits): 2048
					Digest Algorithm: sha256
					Lifetime (days): 3650
					Common Name: internal-ca
					Country Code: BR
					Sate or Province: Guarulhos
					City: Sao Paulo
					Organization: Bora para Pratica
					Organizational Unit: Matriz Bora para Pratica
			Save

Exportando a CA do BoraParaPratica do pfSense
System
	Cert. Manager
		CAs
		BoraParaPratica
			Export CA
				Salvar Arquivo: BoraParaPratica.crt


Configuração do Certificado SSL de Serviços do pfSense
System
	Cert. Manager
		Certificates
			+Add/Sign
				Add/Sign a New Certificate
					Method: Create an internal Certificate
					Descriptive name: Certificado do pfSense
				Internal Certificate 
					Certificate authority: BoraParaPratica
					Key type: RSA
					Key length: 2048
					Digest Algorithm: sha256
					Lifetime (days): 3650
					Common Name: ptispo01fw01.cwbpr.systech.brz 
					Country Code: BR
					State or Province: Guarulhos
					City: Sao Paulo
					Organization: Bora para Pratica
					Organization Unit: Matriz de Bora para Pratica
				Certificate Attributes
					Certificate Type: Server Certificate
					Alternative Names:
						IP Address: 173.169.73.254 +Add
						FQDN or Hostname: ptispo01fw01 +Add
						FQDN or Hostname: ptispo01fw01.cwbpr.systech.brz
			Save

Configurando o Suporte ao HTTPS do pfSense
System
	Advanced
		webConfigurator
			Protocol: HTTPS
			SSL/TLS Certificate: Certificado do pfSense
		Save

Instalação do CA (Certificate Authority) no Firefox (Linux ou Windows)
Firefox
	Menu de Aplicativo
		Preferências
			Pesquisar em Preferências
				Certificados
					Ver Certificados...
						Autoridades
							Importar: BoraParaPratica.crt <Abrir>
								Confiar nesta CA para identificar sites (yes)
								Confiar nesta CA para identificar usuários de e-mail (yes)
							<Ver>
							<OK>

Instalação do CA (Certificate Authority) no Google Chrome (Linux)
Google Chrome
	Digite a URL: chrome://settings/certificates
		Autoridade
			Importar
				BoraParaPratica.crt <Abrir>
					Confiar neste certificado para identificar sites (yes)
					Confiar neste certificado para identificar usuários de e-mail (yes)
					Confiar neste certificado para identificar fabricantes de software (yes)
				<OK>
	Digite a URL: chrome://restart

Instalação do CA (Certificate Authority) no Windows
BoraParaPratica.crt (clicar duas vezes em cima do certificado)
	Abrir
		Certificado
			Geral
				Instalar Certificado...
					Assistente para Importação de Certificados
						Máquina Local <Avançar>
						Deseja permitir que este aplicativo faça alterações no seu dispositivo? <sim>
						Colocar todos os certificados no repositório a seguir
							Repositório de Certificados <Procurar>
								Autoridades de Certificação Raiz Confiáveis <OK>
						<Avançar>
						<Concluir>
						<OK>
Pesquisa do Windows
	Gerenciar Certificados de Computador <Sim>
		Autoridades de Certificação Raiz Confiáveis
			Certificados
				internal-ca

Instalação do CA (Certificate Authority) no Linux
BoraParaPratica.crt
		Abrir como Root 
			Copia: BoraParaPratica.crt
			Colar: /usr/local/share/ca-certificates
		Terminal
			sudo update-ca-certificates