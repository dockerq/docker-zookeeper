# suggest tag is `docker build -t adolphlwq/zookeeper .`
FROM ubuntu:14.04

ADD supervisord.conf /etc/

RUN apt-get install -y curl && \
    curl -fL http://apache.fayea.com/zookeeper/zookeeper-3.3.6/zookeeper-3.3.6.tar.gz | tar xzf - -C /usr/local && \
    mv /usr/local/zookeeper-3.3.6 /usr/local/zookeeper

ENV ZK_HOME=/usr/local/zookeeper

RUN mv ${ZK_HOME}/conf/zoo_sample.cfg ${ZK_HOME}/conf/zoo.cfg && \
    sed -i s@zookeeper.log.dir=.*@zookeeper.log.dir=/var/zookeeper/log@ ${ZK_HOME}/conf/log4j.properties && \
    sed -i s@zookeeper.tracelog.dir=.*@zookeeper.tracelog.dir=/var/zookeeper/tracelog@ ${ZK_HOME}/conf/log4j.properties && \
    sed -i s@dataDir=.*@dataDir=/var/zookeeper/@ ${ZK_HOME}/conf/zoo.cfg && \
    mkdir -p /var/zookeeper/log && \
    mkdir -p /var/zookeeper/tracelog

RUN apt-get update && \
	apt-get install -y openjdk-7-jre && \
	rm -rf /var/cache/apt/archives/*

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
