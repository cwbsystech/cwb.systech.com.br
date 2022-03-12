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
#
# Desligando e reinicializando o servidor com halt
sudo hatl -p (Poweroff)
sudo halt --reboot
#
# Desligando e reinicializando o servidor com poweroff
sudo poweroff
sudo poweroff --reboot
#
# Desligando e reinicializando o servidor com init
sudo init 0
sudo init 6
#
# Desligando e reinicializando o servidor com reboot
sudo reboot --halt (Poweroff)
sudo reboot
#
# Desligando e reinicializando o servidor com shutdown
sudo shutdown -P (Poweroff)
sudo shutdown -h (Halt padrão de desligamento em 60 segundos)
sudo shutdown -h now
sudo shutdown -r now
sudo shutdown -h 19:50 Servidor será desligado
sudo shutdown -c (Para cancelar o agendamento)
sudo date