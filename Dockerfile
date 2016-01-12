# suggest tag is `docker build -t adolphlwq/cluster_zookeeper .`
FROM adolphlwq/ubuntu_jre8

ADD supervisord.conf /etc/

RUN apt-get install -y curl && \
    curl -fL http://ftp.riken.jp/net/apache/zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz | tar xzf - -C /usr/local && \
    mv /usr/local/zookeeper-3.4.7 /usr/local/zookeeper

ENV ZK_HOME=/usr/local/zookeeper

RUN mv ${ZK_HOME}/conf/zoo_sample.cfg ${ZK_HOME}/conf/zoo.cfg && \
    sed -i s@zookeeper.log.dir=.*@zookeeper.log.dir=/var/zookeeper/log@ ${ZK_HOME}/conf/log4j.properties && \
    sed -i s@zookeeper.tracelog.dir=.*@zookeeper.tracelog.dir=/var/zookeeper/tracelog@ ${ZK_HOME}/conf/log4j.properties && \
    sed -i s@dataDir=.*@dataDir==/var/zookeeper/@ ${ZK_HOME}/conf/zoo.cfg && \
    mkdir -p /var/zookeeper/log && \
    mkdir -p /var/zookeeper/tracelog

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
