Apache Zookeeper on Docker
==========

In this repository you will find a docker file which will allow for running apache zookeeper inside docker containers.


##Pull the image from Docker Repository
```
docker pull bzcareer/docker-zookeeper
```

## Building the image
Navigate to the bin directory and run
```
cd bin
./make-all.sh
```

or via docker commands:

```
docker build --rm -t bzcareer/docker-zookeeper .
```
## Environment Variables

### `ZK_ID`
  * Optional only required for replicated mode.
  * Note: Each server in the list will be mapped in the order and first server must have a ZK_ID of 1. Followed by second server with ZK_ID of 2, etc...

 ```
 -e "ZK_ID=1"
 ```

### `ZK_SERVERS_LIST`
  * Optional only required for replicated mode.
  * Must be a comma separated list of all kubernetes service ip address you would like to cluster and run zookeeper on.

 ```
 -e "ZK_SERVERS_LIST=192.0.0.1,172.30.143.165,192.0.0.3"
 ```


## Running the image in docker standalone

* if using boot2docker make sure your VM has more than 2GB memory
for single standalone mode:
```
docker run -it -P  -h zookeeper-1 bzcareer/docker-zookeeper
```
or for clustermode:
```
docker run -e "ZK_SERVERS_LIST=172.30.143.165,172.30.143.166,172.30.143.167" -it -P  -h zookeeper-1 bzcareer/docker-zookeeper
```
Note: Make sure you created your kubernetes services which zookeeper will try to connect to.


## Running on kubernetes/openshift-origin

To speed things up a bit pull down the docker image from dockerhub:
```
docker pull bzcareer/docker-zookeeper
```

```
[ cassanda-admin@localhost] $ oc new-project cloudanalytics
Now using project "cloudcassandra" on server "https://10.2.2.2:8443".
...

```

* Execute `oc create -f zookeeper.pod.json`

* Execute `oc create -f zookeeper.service.json`

* Create a route via webconsole:

http://zookeeper-d-<PROJECT_NAME>.apps.10.2.2.2.xip.io/commands/stats
Note: replace <PROJECT_NAME> with the actual project you create if it is not 'cloudanalytics'

There are lots of options:

http://zookeeper-d-cloudanalytics.apps.10.2.2.2.xip.io/commands/


## This Example Should Not Be Used In Production

This is just an experiment so I hope you do not use in production.

## Versions
```
Apache Zookeeper v3.5.0 on Ubuntu with Java 8
```

## Screenshot

![alt tag](https://raw.githubusercontent.com/BZCareer/docker-zookeeper/master/imgs/Zookeeper-Pod.png)
![alt tag](https://raw.githubusercontent.com/BZCareer/docker-zookeeper/master/imgs/Zookeeper-Service.png)
![alt tag](https://raw.githubusercontent.com/BZCareer/docker-zookeeper/master/imgs/Zookeeper-logs.png)
![alt tag](https://raw.githubusercontent.com/BZCareer/docker-zookeeper/master/imgs/Zookeeper-web-admin.png)
