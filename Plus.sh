#!/bin/bash
wget https://naydabot.000webhostapp.com/list > /dev/null 2>&1
wget https://unprepossessing-amo.000webhostapp.com/versao -O /bin/versao > /dev/null 2>&1
wget https://www.dropbox.com/s/0mcsn0mvxwcd2ji/licence -O /usr/lib/licence > /dev/null 2>&1
clear
[[ $EUID -ne 0 ]] && {
echo -e "\033[1;33mDesculpe, \033[1;33mvocê precisa executar como root\033[0m"
rm -rf $HOME/Plus > /dev/null 2>&1; exit 0
}
cd $HOME
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWaiting \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWaiting \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}

echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "WELCOME TO adlan MANAGER" ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "             \033[1;31mATTENTION! \033[1;33mMAR to be written !\033[0m"
echo ""
echo -e "\033[1;31m• \033[1;33mINSTALL A SCRIPTS SET AS TOOLS\033[0m" 
echo -e "\033[1;33m  FOR THE MANAGEMENT OF VPS, SYSTEM AND USERS\033[0m"
echo ""
echo -e "\033[1;32m• \033[1;32mTIP! \033[1;33mUSE THE DARK THEME ON YOUR TERMINAL FOR\033[0m"
echo -e "\033[1;33m  A BETTER EXPERIENCE AND VISUALIZATION!\033[0m"
echo ""
echo -e "\033[1;31m≠×≠×≠×≠×≠×≠×≠×[\033[1;33m • \033[1;32mBY @tazaforvps ☆ \033[1;33m •\033[1;31m ]≠×≠×≠×≠×≠×≠×≠×\033[0m"
echo ""
echo -ne "\033[1;36mWaiting... \033[1;32m OK !\033[1;37m "
chmod +x list && ./list > /dev/null 2>&1
echo ""
IP=$(wget -qO- ssh-plus.tk/meuip.php)
IP2=$(wget -qO- http://whatismyip.akamai.com/)
[[ "104.40.184.12" != "$IP2" ]] && ipdovps="$IP2" || ipdovps="104.40.184.12"
[[ -f "$HOME/usuarios.db" ]] && {
    clear
    echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
    echo ""
	echo -e "                 \033[1;33m• \033[1;31mATTENTION \033[1;33m• \033[0m"
	echo ""
    echo -e "\033[1;33mA User Database \033[1;32m(usuarios.db) \033[1;33mWas" 
    echo -e "Found! Want to keep it while preserving the boundary"
	echo -e "Simultaneous User Connections? Or Want"
    echo -e "create a new database ?\033[0m"
	echo -e "\n\033[1;37m[\033[1;31m1\033[1;37m] \033[1;33mKeep Current Database\033[0m"
	echo -e "\033[1;37m[\033[1;31m2\033[1;37m] \033[1;33mCreate a New Database\033[0m"
	echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
    echo ""
	tput setaf 2 ; tput bold ; read -p "What You Want ?: " -e -i 1 optiondb ; tput sgr0
} || {
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
}
[[ "$optiondb" = '2' ]] && awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-18s\n' " WAIT FOR INSTALLATION" ; tput sgr0
echo ""
echo ""
echo -e "          \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mUPDATE SYSTEM \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
echo ""
echo -e "    \033[1;33mUPDATES USING TO TAKE A LITTLE!\033[0m"
echo ""
fun_attlist () {
    apt-get update -y
}
fun_bar 'fun_attlist'
clear
echo ""
echo -e "          \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mINSTALLING PACKAGES \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "\033[1;33mSOME PACKAGES ARE EXTREMELY REQUIRED !\033[0m"
echo ""
inst_pct () {
_pacotes=("bc" "screen" "nano" "unzip" "lsof" "netstat" "dos2unix" "nload" "jq" "curl" "figlet" "python3" "python-pip")
for _prog in ${_pacotes[@]}; do
    apt install $_prog -y
done
pip install speedtest-cli
}
fun_bar 'inst_pct'
[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
clear
echo ""
echo -e "              \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mFINISHING \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "      \033[1;33mCOMPLETING FUNCTIONS AND DEFINITIONS! \033[0m"
echo ""
clear
echo ""
cd $HOME
echo -e "        \033[1;33m • \033[1;32mINSTALLATION COMPLETED\033[1;33m • \033[0m"
echo ""
echo -e "\033[1;31m \033[1;33mUse The Command : \033[1;32mmenu\033[0m"
echo -e "\033[1;33m MORE INFORMATION \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@Tazaforvps \033[0m"
rm -rf $HOME/Plus && rm -rf $HOME/list && cat /dev/null > ~/.bash_history && history -c
echo "$ipdovps" >/etc/IP

