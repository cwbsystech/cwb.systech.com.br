01.	Instalacion
		curl -s https://install.zerotier.com | bash

		zerotier-cli join 35c192ce9b69fb9f

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


03. Zerotier
		touch /etc/systemd/system/zerotier.service

		cat << EOF > /etc/systemd/system/zerotier.service
		# Gerado pelo script SYSTECH - Soluções em TI

		[Unit]
		Description=Samba Active Directory Domain Controller
		After=network.target remote-fs.target nss-lookup.target

		[Service]
		Type=forking
		ExecStart=/usr/sbin/zerotier-one

		[Install]
		WantedBy=multi-user.target
EOF



