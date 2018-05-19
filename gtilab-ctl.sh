#!/bin/sh
###  docker gitlab 容器 启动/关闭脚本    ###
###  启动方法：./start_gitlab.sh start image_id  port      ###
###  使用方法：./start_gitlab.sh stop container_id         ###
###  不使用id时，默认关闭第一个容器：                      ###
# ./start_gitlab.sh [option] [images_id] [port]
echo -e "\033[32mCommand: \033[0m"

Usage_fn(){
  echo -e "\033[31mUsage: ./start_gitlab.sh [option] [images_id] [port]"
  echo -e "  [option]: start/stop"
  echo -e "  [images_id]: docker gitlab image id "
  echo -e "  [port]: gitlab server port "
  echo -e "Example: ./start_gitlab.sh start e420c3fac3e3 1234\033[0m"
}

# step 1 error check
if [ $# -lt 1 ];then
  Usage_fn
  exit
fi

# step 2 set value
pt=1234
if [ -n "$3" ];then
  pt=$3
fi
id=$2

# step 3 run command
if [ $1 == "start" ];then
  if [ $# -ge 2 ];then
    re1=`docker run --detach \
        --hostname www.gitlab.com \
        --publish 1022:22 --publish 443:443 --publish $pt:80  \
        --name gitlab \
        --restart always \
        --volume /srv/gitlab/config:/etc/gitlab \
        --volume /srv/gitlab/logs:/var/log/gitlab \
        --volume /srv/gitlab/data:/var/opt/gitlab \
        $id `
    re2=`ifconfig | grep '192.168' | awk '{print $2}' | sed 's/addr://g'`
    echo -e "\033[34m Start Gitlab Image \033[31m$id \033[0m "
    echo -e "\033[34m Gitlab ip is \033[31m http://$re2:$pt/\033[0m "
    echo -e "\033[34m Container Id is \033[31m ${re1:0:12}\033[0m "
  else
     Usage_fn
     exit
  fi
  exit
fi

word=""
if [ $1 == "stop" ]; then
  if [ -z "$2" ]; then 
    id=`docker ps -l |sed -n '2p'| awk '{print $1}'`
    if [ -z "$id" ];then
      echo -e "\033[31m No Running Container.....\033[0m"
      exit
    else
      word="Fisrt"
    fi
  fi
  docker rm -f $id > /dev/null
  echo -e "\033[34m Rm $word Container \033[31m$id \033[0m"
fi

exit

