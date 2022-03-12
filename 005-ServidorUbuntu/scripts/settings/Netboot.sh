#!/bin/bash
# Autor:				JENSY GEGORIO GOMEZ
# Bio:					Tecnico em Informatica e Eletronica
# YouTube: 				youtube.com/Sys-tech
# Instagram: 			https://www.instagram.com/systech5/?hl=pt-br
# Github: 				https://github.com/systech-brz

# Data de criação: 		01/01/2022
# Data de atualização: 	01/01/2022
# Versão: 				0.01

# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64
#

#Atualização das Listas do Apt-Get - Apt
sudo apt update

#Atualização dos Software instalados
sudo apt upgrade

#Atualização das Versões de Kernel
sudo apt dist-upgrade

#Nova opção de atualização, a mesma utilizada no Debian
sudo apt full-upgrade

#Verificando o Espaço em Disco
sudo df -h

#verificando o arquivo Swapfile
sudo ls -lh swapfile

#Analisando o conteúdo da arquivo OS-Release
sudo cat /etc/os-release

#Analisando o conteúdo do arquivo lsb-release
sudo cat /etc/lsb-release