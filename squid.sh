#/bin/bash
clear
if [ $(id -u) -eq 0 ]
then
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

clear
if [ $(id -u) -eq 0 ]
then
	clear
else
	if echo $(id) |grep sudo > /dev/null
	then
	clear
	echo -e "\033[1;37mVoce não é root"
	echo -e "\033[1;37mSeu usuario esta no grupo sudo"
	echo -e "\033[1;37mPara virar root execute \033[1;31msudo su\033[1;37m ou execute \033[1;31msudo $0\033[0m"
	exit
	else
	clear
	echo -e "Vc nao esta como usuario root, nem com seus direitos (sudo)\nPara virar root execute \033[1;31msu\033[0m e digite sua senha root"
	exit
	fi
fi

cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/	//' > /etc/so 
echo -e "\033[0;31mPara a instalação ser correta é preciso o ip.
Digite o IP !\033[0m"
read -p ": " ip
clear
echo -e "\033[1;31m-----> \033[0;34mScript ATUALIZADO por KHALIL\033[0m"
echo -e "\033[1;31m-----> \033[0;34mSeu sistema operacional:\033[1;31m $(cat /etc/so)"
echo -e "\033[1;31m-----> \033[0;34mSeu ip:\033[1;31m $ip"
echo -e "\033[1;31m-----> \033[0;34mSQUID NAS PORTAS:\033[1;31m 80, 8080, 8799, 3128\033[0m"
echo -e "\033[1;31m-----> \033[0;34mSSH NAS PORTAS: \033[1;31m443, 22\033[0m"
echo -e "\033[1;31m-----> \033[0;34mSSH NOS IPS: \033[1;31m$ip, localhost, 127.0.0.1\033[0m"
echo -e "\033[1;31m-----> \033[0;34mFERRAMENTA ADICIONAR DOMINIOS:\033[1;31m addhost\033[0m"

function sshd_config(){ echo "Port 22
Port 443
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes" > /etc/ssh/sshd_config
}

function addhost(){ echo '#!/bin/bash
echo "Qual host deseja adicionar ?"
read -p ": " host
echo "$host" >> /etc/payloads
squid -k reconfigure > /dev/null 2> /dev/null
squid3 -k reconfigure > /dev/null 2> /dev/null
echo "$host Adicionado" ' > /bin/addhost
chmod a+x /bin/addhost
}

function payloads(){ echo ".bookclaro.com.br
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
.bradescocelular.com.br
.claroseguranca.com.br
.claroimprensa.com.br
.combosclaro.com.br
.nowonline.com.br
.clarocloud.com.co/portal/co/cld/
.clarocpfprotegido.com.br
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
}

if cat /etc/so |grep -i ubuntu |grep 16 1> /dev/null 2> /dev/null ; then
echo -e "\033[1;32mConfigurando, Aguarde...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install -y squid3 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null
chattr -i /etc/ssh/sshd_config > /dev/null 2> /dev/null
sshd_config
service ssh restart 1> /dev/null 2> /dev/null

echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid/squid.conf

addhost

echo -e "\033[1;37mPara adicionar novos hosts ao squid execute o comando addhost
os hosts ficam no arquivo /etc/payloads\033[0m"
payloads
service squid restart 1> /dev/null 2> /dev/null

echo -e "\033[01;31mTudo terminado crie um usuario e teste !!\033[0m"
exit 0
fi

if cat /etc/so |grep -i ubuntu 1> /dev/null 2> /dev/null ; then
echo -e "\033[1;37mConfigurando, Aguarde...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install -y squid3 1> /dev/null 2> /dev/null

service apache2 stop 1> /dev/null 2> /dev/null
chattr -i /etc/ssh/sshd_config > /dev/null 2> /dev/null
sshd_config
service ssh restart 1> /dev/null 2> /dev/null

echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid3/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid3/squid.conf
payloads
service squid3 restart 1> /dev/null 2> /dev/null
addhost

echo -e "\033[1;37mPara adicionar novos hosts ao squid execute o comando addhost
os hosts ficam no arquivo /etc/payloads\033[0m"
echo -e "\033[01;31mTudo terminado crie um usuario e teste !! \033[0m"
exit 0
fi

if cat /etc/so |grep -i centos 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;37mConfigurando, Aguarde...\033[0m"
yum -y update 1> /dev/null 2> /dev/null
yum install -y squid 1> /dev/null 2> /dev/null

service httpd stop 1> /dev/null 2> /dev/null
chattr -i /etc/ssh/sshd_config > /dev/null 2> /dev/null
sshd_config
service sshd restart 1> /dev/null 2> /dev/null

echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid/squid.conf
payloads
service squid restart 1> /dev/null 2> /dev/null
addhost

echo -e "\033[1;37mPara adicionar novos hosts ao squid execute o comando addhost
os hosts ficam no arquivo /etc/payloads\033[0m"
echo -e "\033[01;31mTudo terminado crie um usuario e teste !! \033[0m"
exit
fi

if cat /etc/so |grep -i debian 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;37mConfigurando, Aguarde...\033[0m"
apt-get update 1> /dev/null 2> /dev/null
apt-get install -y squid3 1> /dev/null 2> /dev/null
service apache2 stop 1> /dev/null 2> /dev/null
chattr -i /etc/ssh/sshd_config > /dev/null 2> /dev/null
sshd_config

service ssh restart 1> /dev/null 2> /dev/null

echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid3/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid3/squid.conf
payloads
service squid3 restart 1> /dev/null 2> /dev/null
addhost

echo -e "\033[1;37mPara adicionar novos hosts ao squid execute o comando addhost
os hosts ficam no arquivo /etc/payloads\033[0m"
echo -e "\033[01;31mTudo terminado crie um usuario e teste !! \033[0m"
exit 0
fi



if cat /etc/issue |grep -i kernel 1> /dev/null 2> /dev/null ; then
echo -e "\033[01;31mConfigurando, Aguarde...\033[0m"
yum -y update 1> /dev/null 2> /dev/null
yum install -y squid 1> /dev/null 2> /dev/null

service httpd stop 1> /dev/null 2> /dev/null
chattr -i /etc/ssh/sshd_config > /dev/null 2> /dev/null
sshd_config
service sshd restart 1> /dev/null 2> /dev/null

echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid/squid.conf
payloads
service squid restart 1> /dev/null 2> /dev/null
addhost

echo -e "\033[1;37mPara adicionar novos hosts ao squid execute o comando addhost
os hosts ficam no arquivo /etc/payloads\033[0m"
echo -e "\033[01;31mTudo terminado crie um usuario e teste !! \033[0m"
exit
fi

echo -e "\033[01;31mConfigurando, Aguarde...\033[0m"

yum -y update 1> /dev/null 2> /dev/null
yum install -y squid 1> /dev/null 2> /dev/null
apt-get update > /dev/null 2> /dev/null
apt-get install -y squid3 > /dev/null 2>/dev/null
service httpd stop 1> /dev/null 2> /dev/null
service apache2 stop >/dev/null 2> /dev/null
chattr -i /etc/ssh/sshd_config > /dev/null 2> /dev/null
sshd_config
service sshd restart 1> /dev/null 2> /dev/null
service ssh restart > /dev/null 2> /dev/null
echo "http_port 80
http_port 8080
http_port 8799
http_port 3128
visible_hostname VpsPack
acl ip dstdomain $ip
http_access allow ip" > /etc/squid*/squid.conf
echo 'acl accept dstdomain -i "/etc/payloads"
http_access allow accept
acl local dstdomain localhost
http_access allow local
acl iplocal dstdomain 127.0.0.1
http_access allow iplocal
http_access deny all' >> /etc/squid*/squid.conf
payloads
service squid restart 1> /dev/null 2> /dev/null
service squid3 restart > /dev/null 2> /dev/null
addhost
echo -e "\033[1;37mPara adicionar novos hosts ao squid execute o comando addhost
os hosts ficam no arquivo /etc/payloads\033[0m"
echo -e "\033[01;31mTudo terminado crie um usuario e teste !! \033[0m"

cd

if [ $(id -u) -eq 0 ]
then
        clear
else
        if echo $(id) |grep sudo > /dev/null
        then
        clear
        echo "Voce não é root"
        echo "Seu usuario esta no grupo sudo"
        echo -e "Para virar root e fazer a instalação execute \033[1;31msudo su\033[0m"
        exit
        else
        clear
        echo -e "Vc pecisa esta como root para poder fazer a instalção, Para virar root execute \033[1;31msu\033[0m e digite sua senha root"
        exit
        fi
fi


if yum -y update
then
yum -y update
yum -y install git
git clone https://github.com/RicKbrL/VpsPack.git
clear
cd VpsPack
rm -rf README.md
rm -rf install
for arqs in `ls`
do
rm /bin/$arqs 2>/dev/null
mv $arqs /bin
chmod +x /bin/$arqs
done
echo -e "\033[1;33mConcluido, Execute o comando \033[1;32mVpsPack\033[1;33m como root \033[0m"
else
apt-get update
apt-get install -y git
git clone https://github.com/RicKbrL/VpsPack.git
clear
cd VpsPack
rm -rf README.md
rm -rf install
for arqs in `ls`
do
rm /bin/$arqs 2>/dev/null
mv $arqs /bin
chmod +x /bin/$arqs
done
echo -e "\033[1;37mConcluido, Execute o comando \033[1;33mVpsPack\033[1;37m como root \033[0m"
fi
cd
rm -rf install 2> /dev/null
rm -rf VpsPack 2> /dev/null

echo -e "\033[1;31m-----> \033[0;34mINSTALANDO também o badudp fundamental para HABILITAR o Uso de chamada via whatsapp e outros de Audio/Video usando o servidor... aguarde \033[0m"
read -p "clique ENTER para continuar"
wget http://phreaker56.xyz/badvpnsetup.sh
chmod +x badvpnsetup.sh
./badvpnsetup.sh

echo -e "\033[42;1;37mTUDO OK, SEU SERVIDOR VPS ESTÁ TOTALMENTE CONFIGURADO,
EQUIPE SERVERFULL
BY: SR. KHALIL\033[0m"
