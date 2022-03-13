<?php
//!/bin/bash
// Autor:						Jensy Gregorio Gomez
// YouTube:						youtube.com/systech
// Instagram:					https://www.instagram.com/systech5/?hl=pt-br
// Github:						https://github.com/vaasystech-brz
// Data de criação:				01/01/2022
// Data de atualização:			01/01/2022
// Versão:						0.01
// Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64
// Testado e homologado para a versão do Apache2 v2.4.x 
// Testado e homologado para a versão do MySQL v8.0.x 
// Testado e homologado para a versão do OCS Inventory Server v2.9.x
//
// Nome da Base de Dados do OCS Inventory Server
define("DB_NAME", "ocsweb");
//
// Nome do Servidor de Leitura da Base de Dados do OCS Inventory Server
define("SERVER_READ","localhost");
//
// Nome do Servidor de Escrita da Base de Dados do OCS Inventory Server
define("SERVER_WRITE","localhost");
//
// Porta de Conexão do Banco de Dados do MySQL do OCS Inventory Server
define("SERVER_PORT","3306");
//
// Nome do Usuário de autenticação na Base de Dados do OCS Inventory Server
define("COMPTE_BASE","ocsweb");
//
// Senha do Usuário de autenticação na Base de Dados do OCS Inventory Server
define("PSWD_BASE","ocsweb");
//
// Configurações do Suporte ao SSL HTTPS do OCS Inventory Server (desativado)
define("ENABLE_SSL","0");
define("SSL_MODE","");
define("SSL_KEY","");
define("SSL_CERT","");
define("CA_CERT","");
?>