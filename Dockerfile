# suggest tag is `docker build -t adolphlwq/zookeeper .`
FROM alpine:3.2

ENV FRESHED_AT 2016.4.3

#unify time zone
RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV ZK_VERSION 3.4.6
RUN apk --update add openjdk-8-jre curl && \
    curl -fL http://apache.fayea.com/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz | tar xzf - -C /usr/local && \
    mv /usr/local/zookeeper-${ZK_VERSION} /usr/local/zookeeper && \
    apk del curl

ENV ZK_HOME=/usr/local/zookeeper
#config zookeeper
RUN mv ${ZK_HOME}/conf/zoo_sample.cfg ${ZK_HOME}/conf/zoo.cfg && \
    sed -i s@zookeeper.log.dir=.*@zookeeper.log.dir=/var/zookeeper/log@ ${ZK_HOME}/conf/log4j.properties && \
    sed -i s@zookeeper.tracelog.dir=.*@zookeeper.tracelog.dir=/var/zookeeper/tracelog@ ${ZK_HOME}/conf/log4j.properties && \
    sed -i s@dataDir=.*@dataDir=/var/zookeeper/@ ${ZK_HOME}/conf/zoo.cfg && \
    mkdir -p /var/zookeeper/log && \
    mkdir -p /var/zookeeper/tracelog

RUN echo 1 > /var/zookeeper/myid
ENTRYPOINT ["${ZK_HOME}/bin/zkServer.sh", "start"]
