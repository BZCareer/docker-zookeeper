#!/bin/bash
# Author: Zak Hassan

# Standalone :
#     - env variables required:
# Cluster mode:
#     - env variables required: $ZK_ID, $ZK_SERVERS_LIST (should be the ip address of the kubernetes service
#       each zk node should run independent in its own pod.)
#
#

# SETUP CONFIGURATIONS:
mkdir /usr/local/zookeeper/logs
if [ -z "$ZK_ID" ]; then
echo $ZK_ID >> /usr/local/zookeeper/logs/myid
fi
 
echo "tickTime=2000" >> /usr/local/zookeeper/conf/zoo.cfg
echo "initLimit=5"  >> /usr/local/zookeeper/conf/zoo.cfg
echo "syncLimit=3" >> /usr/local/zookeeper/conf/zoo.cfg
echo "dataDir=/usr/local/zookeeper/logs" >> /usr/local/zookeeper/conf/zoo.cfg
echo "clientPort=2181" >> /usr/local/zookeeper/conf/zoo.cfg
#ZK_SERVERS_LIST="192.0.0.1,172.30.143.165,192.0.0.3"
# if you don't specify a zk server list it will assume it's running standalone
if [ -z "$ZK_SERVERS_LIST" ]; then
      IFS=',' eval 'array=($ZK_SERVERS_LIST)'
      SERVICE_IP=$(cat kubeEnv | grep "SERVICE_HOST" | grep -v "KUBERNETES"| cut -d '=' -f2)
   for i in "${!array[@]}"
        do
           if [ "${array[i]}" != "$SERVICE_IP" ]; then
                echo "server.$((i+1))=${array[i]}:2888:3888" >> /usr/local/zookeeper/conf/zoo.cfg
           else
                echo "server.$((i+1))=0.0.0.0:2888:3888" >> /usr/local/zookeeper/conf/zoo.cfg
          fi
   done
fi

# Running zookeeper server in foreground so logs show up with docker logs <container_id>
/usr/local/zookeeper/bin/zkServer.sh start-foreground /usr/local/zookeeper/conf/zoo.cfg
