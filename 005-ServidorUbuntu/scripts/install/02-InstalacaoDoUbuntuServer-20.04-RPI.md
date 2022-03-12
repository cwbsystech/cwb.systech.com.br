#!/bin/bash
# Autor:				JENSY GEGORIO GOMEZ
# Bio:					Tecnico em Informatica e Eletronica
# YouTube: 				youtube.com/Sys-tech
# Instagram: 			https://www.instagram.com/systech5/?hl=pt-br
# Github: 				https://github.com/systech-brz

# Data de criação: 		01/01/2022
# Data de atualização: 	01/01/2022
# Versão: 				0.01


Testado e homologado no Raspberry Pi 3 B e Ubuntu Server 20.04.x LTS ARM x64 Bits

26/08/2021 - Lançamento da versão do Ubuntu 20.04.3 LTS: https://wiki.ubuntu.com/FocalFossa/ReleaseNotes/ChangeSummary/20.04.3<br>
26/08/2021 - Release Ubuntu Desktop and Server: https://releases.ubuntu.com/20.04/

#Instalação do Ubuntu Server 20.04.x LTS ARM x64 Bits

#01_ Software para a gravação das imagens no microSD Card<br>

	_ RPI-Manager: https://www.raspberrypi.org/software/

#02_ Download da Imagem do Ubuntu Server 20.04.x LTS ARM x64 Bits
		
	_ https://ubuntu.com/download/raspberry-pi
	_ Suporte para as versões do Raspberry: Pi2 (32bits), Pi3, Pi4, Pi400 e PiCM4 

#03_ Limpando as Partições microSD Card

	_ Recomendado utilizar o Gerenciador de Unidade de Disco do Linux Mint (Menu, Discos)
	_ Limpar todas as partições antes de gravar a imagem do Ubuntu Server no microSD Card
	_ OBS1: utilizar sempre microSD Card >= 16GB Classe 10

#04_ Gravando a imagem do Ubuntu Server no SD Card

	_ Botão direito do mouse na imagem: ubuntu-20.04.3-preinstalled-server-arm64+raspi.img.xz
	_ Selecionar: Abrir com o Gravador de imagem de disco
	_ Destino: Driver de 16GB/32GB - Generic SD/MMC/MS PRO (/dev/sdb) <Iniciar restauração>

#05_ Ligando o Raspberry Pi 3 B com o microSD Card do Ubuntu Server 20.04.x LTS ARM x64 Bits
	
	_ OBSERVAÇÃO: na primeira inicialização do Ubuntu Server, aguardar alguns minutos para 
	_ que o serviço do SSH e do Cloud-Init sejá inicializado corretamente, será apresentado
	_ as mensagens de geração das Chaves do SSH e inicialização do Cloud.Init, após essas 
	_ mensagens você consegue se logar e trocar a senha do usuário ubuntu.

	_ Usuário padrão: ubuntu
	_ Senha padrão: ubuntu
	
	_ Após se logar pela primeira vez no Ubuntu Server será solicitado a troca da senha:
	_	Current password: ubuntu
	_	New password: Casado#55
	_	Retry new password: Casado#55
	
	_ Recomendado depois que você trocar a senha, fazer a reinicialização do sistema.
	_	sudo reboot
	
	_ Finalize a instalação fazendo o Upgrade do Servidor (Obs: esse processo demora um pouco)
	_	sudo apt update
	_	sudo apt upgrade
	_	sudo apt full-upgrade
	_	sudo apt dist-upgrade
	_	sudo apt autoremove
	_	sudo apt autoclean
	_	sudo apt clean
	_	sudo reboot

	_ DICA: recomendado configurar a Placa de Rede do Ubuntu Server em modo Estático:
	_ Vídeo de configuração do Netplan no Ubuntu Server: https://www.youtube.com/watch?v=zSUd4k108Zk