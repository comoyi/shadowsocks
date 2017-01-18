#!/bin/sh

# a script to manage shadowsocks-client

config_path=/home/user/data/shadowsocks/client/shadowsocks-client.json
log_path=/var/log/shadowsocks/shadowsocks-client.log
script="ss-local -c ${config_path}"
script_name=ss-local
run_user=root
run_cmd=
pid=0

color_reset='\033[0m'
color_red='\033[1;31m'
color_green='\033[1;32m'
color_yellow='\033[1;33m'

checkpid() {
   target_process=`ps -ef | grep ${script_name} | grep -v 'grep'`

   if [ -n "${target_process}" ]; then
      pid=`ps -ef | grep ${script_name} | grep -v 'grep' | awk '{print $2}'`
   else
      pid=0
   fi
}

start() {
    checkpid
    if [ ${pid} -ne 0 ]; then
        printf "${color_yellow}> warn: already started! [PID: ${pid}]${color_reset}\n"
   else
        printf "${color_yellow}Starting...${color_reset}"
        run_cmd="nohup ${script} > ${log_path} 2>&1 &"
        su - ${run_user} -c "${run_cmd}"
        checkpid
        if [ ${pid} -ne 0 ]; then
           printf " [PID: ${pid}] ${color_green}[OK]${color_reset}\n"
        else
           printf " ${color_red}[Failed]${color_reset}\n"
        fi
   fi
}

stop() {
    checkpid
    if [ ${pid} -ne 0 ]; then
        printf "${color_yellow}Stopping...${color_reset} [PID: ${pid}]"
        su - ${run_user} -c "kill -9 ${pid}"
        if [ $? -eq 0 ]; then
            printf " ${color_green}[OK]${color_reset}\n"
        else
            printf " ${color_red}[Failed]${color_reset}\n"
        fi

        checkpid
        if [ ${pid} -ne 0 ]; then
           stop
        fi
    else
        printf "${color_yellow}> warn: script is not running${color_reset}\n"
    fi
}

restart() {
    stop
    start
}

status() {
    checkpid
    if [ ${pid} -ne 0 ];  then
        printf "script is running! [PID: ${pid}]\n"
    else
        printf "script is not running\n"
    fi
}

help() {
    printf "Usage: ${0} {start|stop|restart|status|help}\n"
}


case "${1}" in
   'start')
      start
      ;;
   'stop')
     stop
     ;;
   'restart')
     restart
     ;;
   'status')
     status
     ;;
   'help')
     help
     ;;
  *)
     printf "Usage: ${0} {start|stop|restart|status|help}\n"
     exit 1
esac
exit 0
