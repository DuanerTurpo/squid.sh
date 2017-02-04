#!/bin/bash

if [ ! "$BASH" ]

then

echo "Este script é  experimental, que configura o SQUID PARA criação USO de contas SSH em aplicativos (Http INJECTOR , EPRO etc ) ...

Reiniciando o Script usando BASH em 3 segundos..."

sleep 3

bash $0 $@

exit $?

fi

clear

menu="\033[41;1;37m"

corPadrao="\033[0m"

preto="\033[0;30m"

vermelho="\033[0;31m"

verde="\033[0;32m"

marrom="\033[0;33m"

azul="\033[0;34m"

purple="\033[0;35m"

cyan="\033[0;36m"

cinzaClaro="\033[0;37m"

pretoCinza="\033[1;30m"

vermelhoClaro="\033[1;31m"

verdeClaro="\033[1;32m"

amarelo="\033[1;33m"

azulClaro="\033[1;34m"

purpleClaro="\033[1;35m"

cyanClaro="\033[1;36m"

branco="\033[1;37m"

fim="\033[0m"


echo -e "$menu

			Sr. KHALIL CONFIG		$fim"


echo -e "$cyanClaro

Este é um script que configura O SSH E ADICIONA UMA EXTENSA LISTA DE HOST ACEITAS PELO SERVIDOR PARA TESTES DE NOVAS HOST, EM FOCO DA CLARO.

Neste script não a nenhuma garantia de funcionamento ou suporte do autor.

$fim"

read -p "Pressione Qualquer Tecla para Continuar...
$fim"


read -p "AO CONTINUAR VC CONFIRMA QUE É GAY, ahsuahsuah...
$fim"



echo -e "$cyanClaro

Instalando SQUID3...$fim"

apt-get update 

apt-get upgrade 

apt-get install squid3  


echo -e "$azulClaro

Configurando SQUID3...$fim"


echo "

http_port 80

http_port 8080

http_port 3128

acl accept dstdomain -i $ip

acl allowed dstdomain -i "/etc/payloads"

acl combr dstdomain -i .com.br

acl all src 0.0.0.0/0.0.0.0

http_access allow accept

http_access allow allowed

http_access allow combr

http_access deny all" > /etc/squid3/squid.conf


echo -e "$azulClaro

Configurando SSH...$fim"


echo -e "

Port 443" >> /etc/ssh/sshd_config

echo -e "

.bookclaro.com.br

.universoclaro.com.br

.claro.com.ar

.claro.com.br

.claro.com.co

.claro.com.ec

.claro.com.gt

.claro.com.ni

.claro.com.pe

.claro.com.sv

.claro.cr

.claro.com.hn

.claro.com.yu

.clarochile.cl

.clarocurtas.com.br

.claroideas.com

.claroideias.com.br

.claromusica.com

.clarosomdechamada.com.br

.clarovideo.com

.claroblog.com.br

.lojaclaro.com.br

.clarotodo.com

.facebook.net

.netclaro.com.br

.turbclaro.com.br

.fbiz.com.br

.oi.com.br

.oimusica.com.br

.speedtest.net

.tim.com.br

.timanamaria.com.br

.vivo.com.br

.vivo-base.com.br

.vivomensagens.com.br

.vivotorpedo.com

.d1n212ccp6ldpw.cloudfront.net

.rdio.com

.ec2-52-22-60-103.compute-1.amazonaws.com

.portalrecarga.vivo.com.br/recarga/home/

.w1716.smartadserver.com

.vivo.ddivulga.com/

.clarosomdechamada.com.br

.portalsva2.vivo.com.br" > /etc/payloads

echo -e "$cyanClaro

Recarregando serviços...$fim"

squid3 -k reconfigure 

service ssh restart 

service squid3 restart 


# echo -e "$verde

# Correção de problemas de pacotes no SSH...$fim"



echo -e "$verde

# Configuração terminada.$fim"


echo -e "$vermelho

Novas host adicionadas: (em /etc/payloads)

 .bookclaro.com.br
.universoclaro.com.br
.claro.com.ar
.claro.com.br
.claro.com.co
.claro.com.ec
.claro.com.gt
.claro.com.ni
.claro.com.pe
.claro.com.sv
.claro.cr
.claro.com.hn
.claro.com.yu
.clarochile.cl
.clarocurtas.com.br
.claroideas.com
.claroideias.com.br
.claromusica.com
.clarosomdechamada.com.br
.clarovideo.com
.claroblog.com.br
.lojaclaro.com.br
.clarotodo.com
.facebook.net
.netclaro.com.br
.turbclaro.com.br
.fbiz.com.br
.oi.com.br
.oimusica.com.br
.speedtest.net
.tim.com.br
.timanamaria.com.br
.vivo.com.br
.vivo-base.com.br
.vivomensagens.com.br
.vivotorpedo.com
.d1n212ccp6ldpw.cloudfront.net
.rdio.com
.ec2-52-22-60-103.compute-1.amazonaws.com
.portalrecarga.vivo.com.br/recarga/home/
.w1716.smartadserver.com
.interatividade.vivo.ddivulga.com/produto
.navegue.vivo.ddivulga.com/pacote
.clarosomdechamada.com.br
.portalsva2.vivo.com.br"

echo -e "$menu

By: SR. KHALIL 
CANAL: TELEGRAM.ME/INEXISTENTESVPN

SALVE GRUPO SERVER FULL

$fim"
