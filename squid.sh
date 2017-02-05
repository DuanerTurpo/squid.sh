
#!/bin/bash
if [ ! "$BASH" ]
then
echo "Este script é um experimental, que configura o SQUID PARA criação USO de contas SSH em aplicativos (Http INJECTOR , EPRO etc ..."
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
			KHALIL CONFIG VPS $fim"
			
echo -e "$cyanClaro
Este é um script que configura O SSH E ADICIONA UMA EXTENSA LISTA DE HOSTs ACEITAS
PELO SERVIDOR PARA TESTES DE NOVAS HOST, EM FOCO A OPERADORA CLARO.
Neste script não há nenhuma garantia de funcionamento ou
suporte do autor, use por sua conta e risco.
            SR. KHALIL  @CompreSSH
CANAL:      TELEGRAM.ME/INEXISTENTESVPN
EQUIPE SERVER FULL
$fim"
read -p "Pressione Qualquer Tecla para Continuar..."


read -p "Digite o IP do SEU SERVIDOR: " ip
echo -e "$cyanClaro
Instalando SQUID3, aguarde...$fim"
apt-get update 1>/dev/null 2>/dev/null
apt-get upgrade -y 1>/dev/null 2>/dev/null
apt-get install squid3 -y 1>/dev/null 2>/dev/null 

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
.bradescocelular.com.br
.claroseguranca.com.br
.claroimprensa.com.br
.combosclaro.com.br
.nowonline.com.br
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
echo -e "$cyanClaro
Recarregando serviços...$fim"
squid3 -k reconfigure 1>/dev/null 2>/dev/null
service ssh restart 1>/dev/null 2>/dev/null
service squid3 restart 1>/dev/null 2>/dev/null

# echo -e "$verde
# SUCESSO NA Correção de problemas de pacotes no SSH...$fim"
# apt-get install ethtool -y 1>/dev/null 2>/dev/null
# read -p "Digite o nome da sua interface de rede (Padrão: eth0): " interface
# if [ "$interface" = "" ]
# then
# interface=eth0
# fi
# ethtool -G $interface rx 999999999 tx 999999999 1>/dev/null 2>/dev/null


echo -e "$verde
Configuração terminada.$fim"
echo "$amarelo
  instalando o VPSPACK AGUARDE... $fim"
  
#!/bin/bash

if [ $(id -u) -eq 0 ]
then
	clear
else
	if echo $(id) |grep sudo > /dev/null
	then
	clear
	echo "Voce não é root"
	echo "Seu usuario esta no grupo sudo"
	echo -e "Para virar root execute \033[1;31msudo su\033[0m"
	exit
	else
	clear
	echo -e "Vc nao esta como usuario root, nem com seus direitos (sudo)\nPara virar root execute \033[1;31msu\033[0m e digite sua senha root"
	exit
	fi
fi

if [ -d /etc/VpsPackdir ]
then
echo ""
else
mkdir /etc/VpsPackdir
fi

if [ -d /etc/VpsPackdir/senha ]
then
echo ""
else
mkdir /etc/VpsPackdir/senha
fi

if [ -d /etc/VpsPackdir/limite ]
then
echo ""
else
mkdir /etc/VpsPackdir/limite
fi

clear
echo -e "\033[1;37m VpsPack ©Sr.KHALIL \033[0m"
echo -e "\033[1;37mEscolha uma das opçoẽs:    \033[1;37mFaça o teste de velocidade com a opçao 14\033[1;33m
[1] Limit \033[1;30m(limite de conexoes simultaneas)\033[1;33m
[2] UserCreate \033[1;30m(Criar usuarios)\033[1;33m
[3] UserRedefine \033[1;30m(Opções para mudanças no usuario)\033[1;33m
[4] UserBack \033[1;30m(Deletar, Desconectar, Opções)\033[1;33m
[5] Firewall-block \033[1;30m(Regras iptables block torrent, icmp [RISCOS])\033[1;33m
[6] ResetFirewall \033[1;30m(Retira todas as regras iptables [RISCOS])\033[1;33m
[7] Istall-addhosts \033[1;30m(Faz a preparaçao para add-host)\033[1;33m
[8] Add-host \033[1;30m(Adicionar hosts aceitos pelo squid )\033[1;33m
[9] Monitoring \033[1;30m(IMPORTANTE monitorar conexões por usuarios)\033[0m\033[1;33m
[10] Backup-Users \033[1;30m(Backup dos usuarios para reinstalação futura)\033[1;33m
[11] Rest-Users \033[1;30m(Restaurar usuarios feito backup)\033[1;33m
[12] Detalhes-Users \033[1;30m(Mostra informações sobre os usuarios !!)\033[1;33m
[13] Banner \033[1;30m(Banner mensagem no ssh)\033[1;33m
[14] Speedtest \033[1;30m(Teste de conexão [velocidade de banda])\033[1;33m
[15] System-Detalhes \033[1;30m(Detalhes sobre o Sistema )\033[1;33m
[16] Detalhes \033[1;30m(Detalhes sobre o VpsPack)\033[1;33m
[17] Desinstalar \033[1;30m(Remover o VpsPack)\033[0m"
read -p ": " opcao

case $opcao in
 1)
  read -p "Usuario: " user
  read -p "Limite de Conexoes: " limit
  limit $user $limit;;
 2)
  Usercreate;;
 3)
  UserRedefine;;
 4)
  UserBack;;
 5)
  firewall-block;;
 6)
  ResetFirewall;;
 7)
  install-addhost;;
 8)
  add-host;;
 9)
  Monitoring;;
 10)
  backupusers;; 
 11)
  read -p "Em qual diretorio esta o arquivo de Backup: " arq 
  restusers $arq;;
 12)
  detalhesusers;;
 13)
  banner;;
 14)
  speedtest;;
 15)
  systemdetalhes;;
 16)
  Detalhes;;
 17)
  Desinstalar;;
 *)
  id > /dev/null 2> /dev/null
esac

#!/bin/bash

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
echo -e "\033[1;33mConcluido, Execute o comando \033[1;32mVpsPack\033[1;33m como root \033[0m $fim"
apt-get update 1>/dev/null 2>/dev/null
apt-get install -y git 1>/dev/null 2>/dev/null
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

echo -e "$azul
    Veja as novas hosts adicionada em ( nano /etc/payloads )
$fim"
