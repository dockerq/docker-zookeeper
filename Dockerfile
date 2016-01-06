# suggest tag is `docker build -t adolphlwq/cluster_zookeeper .`
FROM adolphlwq/ubuntu_jre8

ADD supervisord.conf /etc/

RUN apt-get install -y curl && \
    curl -fL http://ftp.riken.jp/net/apache/zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz | tar xzf - -C /usr/local && \
    mv /usr/local/zookeeper-3.4.7 /usr/local/zookeeper

ENV ZK_HOME=/usr/zookeeper
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
