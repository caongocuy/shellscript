#/bin/bash
#Script Monitor System Using Function
#Create By The Linux Bash Script Team - endcolor
clear
endcolor=$(tput sgr0)

#Create Function
#Check Network
checknet() {
ping -c 1 google.com &> /dev/null && echo -e '\E[32m'"Internet: $endcolor Connected" || echo -e '\E[32m'"Internet: $endcolor Disconnected Or Timeout"
echo -e '\E[32m'"Internal IP :" $endcolor $(hostname -I)
echo -e '\E[32m'"Default Gateway :" $endcolor $(route -n | grep UG | awk '{print $2}')
echo -e '\E[32m'"External IP :" $endcolor $(curl -s ipecho.net/plain;echo)
echo -e '\E[32m'"Name Servers :" $endcolor $(cat /etc/resolv.conf | grep 'nameserver' | awk '{print $2}') 
}

#Check OS Type And OS System
checkos() {
echo -e '\E[32m'"Operating System Type :" $endcolor $(uname -o)

if [ -f /etc/os-release ]
then 
echo -n -e '\E[32m'"OS Name :" $endcolor  && cat /etc/os-release | grep 'NAME' | grep -v 'PRETTY_NAME' | cut -f2 -d\"
echo -n -e '\E[32m'"OS Version :" $endcolor && cat /etc/os-release | grep 'VERSION' | grep -v 'VERSION_ID' | cut -f2 -d\"
else
echo -n -e '\E[32m'"OS Name :" $endcolor && cat /etc/system-release | awk '{print $1}'
echo -n -e '\E[32m'"OS Version :" $endcolor && cat /etc/system-release
fi

echo -e '\E[32m'"Architecture :" $endcolor $(uname -m)
echo -e '\E[32m'"Kernel Release :" $endcolor $(uname -r)
echo -e '\E[32m'"Hostname :" $endcolor $HOSTNAME
}

#Check login user
checklogin() {
echo -e '\E[32m'"Logged In users :" $endcolor && who
}

# Check RAM and SWAP Usages
checkram_swap() {
#free -h | grep -v + > /tmp/ramcache
echo -e '\E[32m'"Ram Usages (Mb):" $endcolor
free -m | grep -v '+\|Swap'
echo -e '\E[32m'"Swap Usages (Mb):" $endcolor
free -m | grep -v '+\|Mem'
}

# Check Disk Usages
checkdisk() {
echo -e '\E[32m'"Disk Usages :" $endcolor 
df -h
}

# Check Load Average
#checkloadAverage() {
#echo -e '\E[32m'"Load Average :" $endcolor $(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
#}

# Check System Uptime
checktimeup() {
echo -e '\E[32m'"System Uptime Days/(HH:MM) :" $endcolor $(uptime | awk '{print $3,$4}' | cut -f1 -d,)
}

#Case In
case $1 in
n|N|-n|-N|--network|--Network)
checknet
;;
s|S|-s|-S|--System|--system)
checkos
;;
l|L|-l|L|--Login|--login)
checklogin
;;
r|R|-r|-R|--memory|--Memory)
checkram_swap
;;
d|D|-d|-D|--disk|--Disk)
checkdisk
;;
t|T|-t|-T|--uptime|--Uptime)
checktimeup
;;
a|A|-a|-A|--all|--All)
checkos
checknet
checklogin
checkram_swap
checkdisk
checktimeup
;;
-ns|-sn)
checkos
checknet
;;
-nl|-ln)
checknet
checklogin
;;
-nr|-rn)
checknet
checkram_swap
;;
-nd|-dn)
checknet
checkdisk
;;
-nt|-tn)
checknet
checktimeup
;;
-sl|-ls)
checkos
checklogin
;;
-sr|-rs)
checkos
checkram_swap
;;
-sd|-ds)
checkos
checkdisk
;;
-st|-ts)
checkos
checktimeup
;;
-lr|-rl)
checklogin
checkram_swap
;;
-ld|-dl)
checklogin
checkdisk
;;
-lt|-tl)
checklogin
checktimeup
;;
-rd|-dr)
checkram_swap
checkdisk
;;
-rt|-tr)
checkram_swap
checktimeup
;;
-dt|-td)
checkdisk
checktimeup
;;
*)
echo "=========================================================="
echo "Error: Xin vui long nhap lai lua chon cua ban theo cau truc sau"
echo 'monitor <option>'
echo ''
echo -e '\E[32m'"Option:" $endcolor
echo '-n, --network: Hien thi cac thong tin lien quan den cac ket noi mang.'
echo '-s, --system: Hien thi cac thong tin lien quan den System.'
echo '-l, --login: Hien thi thong tin cac phien dang nhap hien tai.'.
echo '-r, --memory: Hien thi thong tin lien quan den RAM va Swap.'
echo '-d, --disk: Hien thi cac thong tin lien quan den Disk.'
echo '-t, --uptime: Hien thi thoi gian Up Time cua May Chu.'
echo '-a, --all: hien thi toan bo thong tin.'
echo "=========================================================="
echo ""
;;
esac
