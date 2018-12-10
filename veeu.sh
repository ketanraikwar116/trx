#!/bin/bash
# Author : Agus Kurniawan (Guzz)
# FB : アグスクルニアワン (facebook.com/agusu.des)
# Github : github.com/agusgans
clear
merah='\e[31m'
ijo='\e[1;32m'
kuning='\e[1;33m'
biru='\e[1;34m'
NC='\e[0m'
#intro
printf "${ijo}
	 ██████╗ ██╗   ██╗███████╗███████╗
	██╔════╝ ██║   ██║╚══███╔╝╚══███╔╝
	██║  ███╗██║   ██║  ███╔╝   ███╔╝
	██║   ██║██║   ██║ ███╔╝   ███╔╝
	╚██████╔╝╚██████╔╝███████╗███████╗
	 ╚═════╝  ╚═════╝ ╚══════╝╚══════╝                                 ${biru}
	        VeeU APP BOT
	       Code By : Guzz
	          (グッズ)
"
printf "${kuning}__________________________________________________${NC}\n\n"
if [[ ! -f veeu.reg ]]
	then
printf "${kuning}[!]${NC} Insert Your Veeu Token: "; read token
echo "$token" >> veeu.reg
fi
vetoken=$(cat veeu.reg)
printf "${kuning}[+]${NC} Checking Token..\n"
cek=$(curl -m 30 "http://nandrbiz1.com/veeu.php" -d "token=$vetoken" -s -D -)
uid=$(echo "$cek" | grep -Po '(?<=user_id": ")[^"]*')
current=$(echo "$cek" | grep -Po '(?<=current_point": )[^}]*')
sukses=$(echo "$cek" | grep -o '200' | sed -n 1p)
reg=$(echo "$cek"  | grep -o 'FAILED TO REGISTER')
if [[ $sukses == '200' ]]
then
if [[ $reg == 'FAILED TO REGISTER' ]]
    then
    printf "${merah}[!]${NC} Token Not Registered Please Use New Account\n"
    rm veeu.reg 2>/dev/null
    exit
else
    printf "${ijo}[+]${NC} Token Registered\n"
	printf "${ijo}[+]${NC} Account Id : $uid\n"
	printf "${ijo}[+]${NC} Current Points : $current\n"
fi
else
printf "${merah}[+]${NC} Can't Connect..\n"
exit
fi
printf "${kuning}[!]${NC} Starting Bot..\n"
bots(){
bot=$(curl -m 30 -s "http://nandrbiz1.com/veeu.php" -d "token=$vetoken")
getmessage=$(echo "$bot" | grep -o 'complete full')
getreg=$(echo "$bot" | grep -o 'FAILED TO REGISTER')
getgold=$(echo "$bot" | grep -Po '(?<=current_point": )[^}]*')
getreward=$(echo "$bot"| grep -Po '(?<=reward_point": )[^,]*')
getcomplete=$(echo "$bot" | grep -Po '(?<=completed_count": )[^,]*')
#getrevenue=$(cat award.tmp 2> /dev/null| grep -Po '(?<=today_revenue_point": )[^,]*')
if [[ $getreward == "" ]]
  then
    if [[ $getmessage == 'complete full' ]]
	    then
	      printf "${kuning}[!]${NC} Daily Limit Reached Come Back Tomorrow [${kuning}Limit${NC}]\n"
          exit
          elif [[ $getreg == "FAILED TO REGISTER" ]]
		  then
		  printf "${merah}[+]${NC} You Are not Registered\n"
		  exit
		  else
	      printf "${merah}[!]${NC} [Reward : 0] [${merah}Failed${NC}]\n"
     fi
else
  printf "${ijo}[!]${NC} [Reward : $getreward] [Poins : $getgold] [Completed : $getcomplete] [${ijo}Success${NC}]\n"
 fi
 }
for (( ; ; ))
do
bots
done
wait
