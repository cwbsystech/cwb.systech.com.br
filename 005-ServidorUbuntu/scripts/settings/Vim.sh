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
# Indicação de site com muita informação sobre o Editor de Texto VIM: Aurelio.net
# Link: https://aurelio.net/vim/
#
# Comandos básicos do Editor de Texto VIM
#
# Instalando o Editor de Texto VIM no Debian, Ubuntu ou Linux Mint
sudo apt update && sudo apt install vim vim-common
#
# Iniciando o editor de Texto VIM
man vim
vim
#
# Modos do editor de Texto VIM
Modo                Tecla                           Rodapé              Descrição 
---------------------------------------------------------------------------------------------------------
de Inserção         i ou Insert                     -- INSERÇÃO --      Inserção de texto
de Comandos         <Esc>                           Comandos de manipulação de texto
de Linha de comando <Esc> shift : (dois pontos)     :                   Comandos de manipulação arquivo 
de Visual           <Esc> v                         -- VISUAL --        Seleção visual de texto
de Busca            <Esc> /                         /                   Busca de padrões no texto
de Reposição        <Esc> shift R ou Insert/Insert  -- SUBSTITUIÇÃO --  Inserção sobrescrevendo
---------------------------------------------------------------------------------------------------------
#
# Ajuda do editor de Texto VIM (q = quit)
<Esc> shift :help <Enter>
<Esc> F1
<Esc> shift :q <Enter>
vimtutor
#
# Saindo do editor de Texto VIM (q = quit | a = all | ! = force)
<Esc> shift :q <Enter>
<Esc> shift :q! <Enter>
<Esc> shift :qa! <Enter>
#
# Salvando arquivo no editor de Texto VIM (w = write | wq = write/quit | x = write/quit)
<Esc> shift :w teste01.txt <Enter>
<Esc> shift :wq <Enter>
<Esc> shift :x <Enter>
#
# Criando um novo arquivo no editor de Texto VIM (enew = new file | w! = write/force | sav = save as)
vim teste01.txt <Enter>
<Esc> shift :enew <Enter>
<Esc> shift :w! teste01.txt <Enter>
<Esc> shift :sav teste02.txt <Enter>
#
# Abrindo um arquivo no editor de Texto VIM (e = explorer | o TAB funciona)
<Esc> shift :e teste01.txt <Enter>
<Esc> shift :e. <Enter>
#
# Executando comandos externos no editor de Texto VIM (o TAB funciona)
<Esc> shift :!ls -lh <Enter>
#
# Habilitando recursos no editor de Texto VIM
<Esc> shift :set number <Enter>	<-- mostra número da linha
<Esc> shift :set ignorecase <Enter> <-- ignora case insensitive na busca
<Esc> shift :set syntax on <Enter> <-- identificação da linguagem
<Esc> shift :set autoindent <Enter> <-- indentação automática
<Esc> shift :set showmatch <Enter> <-- completa as chaves e colchetes quando você os fecha
<Esc> shift :set autowrite <Enter> <-- salva o arquivo a cada alteração
#
# Arquivo de configuração do editor de Texto VIM
<Esc> shift :!ls -lha /etc/vim/vimrc
<Esc> shift :!cat /etc/vim/vimrc
<Esc> shift :e /etc/vim/vimrc
<Esc> shift :!sudo vim /etc/vim/vimrc
#
# Deletando caracteres e linhas no editor de Texto VIM (x = delete char | d = delete | dw = delete next word)
<Esc> x		<-- deleta carácter por carácter
<Esc> dw	<-- deleta palavra por palavra
<Esc> dd	<-- deleta uma linha inteira
#
# Desfazendo uma alteração no editor de Texto VIM (u = undo | . repeat)
<Esc> u
<Esc> .
#
# Copiando palavras ou linhas no editor de Texto VIM (y = yank)
<Esc> v		<-- selecionar o texto com os direcionadores
<Esc> y		<-- copia o texto
<Esc> yy	<-- copiando a linha inteira
#
# Colando palavras ou linhas no editor de Texto VIM (p = paste after)
<Esc> i		<-- colocar o curso no local que desejado para colar
<Esc> p		<-- colar o texto
#
# Localizando palavras no editor de Texto VIM (/ = find | n = next find)
<Esc> /palavra <Enter>
n		<-- localiza a próxima ocorrência
#
# Formatação de alinhamento no editor de Texto VIM
<Esc> :left <Enter>   <-- alinhamento de texto para a esquerda
<Esc> :right <Enter>  <-- alinhamento de texto centralizado
<Esc> :center <Enter> <-- alinhamento de texto para a direita
#
# Dividindo a tela horizontalmente no editor de Texto VIM (split = dividir)
:split
Ctrl W
#
# Dividindo a tela verticalmente no editor de Texto VIM (vsplit = dividir tela vertical)
:vsplit
Ctrl W
