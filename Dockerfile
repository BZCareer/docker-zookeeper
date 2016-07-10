FROM docker.io/anapsix/docker-oracle-java8

MAINTAINER Zak Hassan zak.hassan1010@gmail.com

RUN wget http://apache.mirror.gtcomm.net/zookeeper/zookeeper-3.5.0-alpha/zookeeper-3.5.0-alpha.tar.gz && tar xvzf zookeeper-3.5.0-alpha.tar.gz -C /usr/local/  && rm zookeeper-3.5.0-alpha.tar.gz

RUN cd /usr/local &&  mv /usr/local/zookeeper-3.5.0-alpha  /usr/local/zookeeper
# && chown -Rv zookeeper /usr/local/zookeeper
# USER zookeeper

ENV ZOOKEEPER_HOME /usr/local/zookeeper
COPY entrypoint.sh /etc/entrypoint.sh

COPY zookeeper.conf  /etc/security/limits.d/zookeeper.conf
COPY limits.conf /etc/security/limits.conf
RUN sysctl -p

ENV PATH $PATH:$ZOOKEEPER_HOME/bin

EXPOSE  2181  2888  3888

ENTRYPOINT ["/etc/entrypoint.sh"]
