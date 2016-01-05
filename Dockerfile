# suggest tag is `docker build -t adolphlwq/cluster_zookeeper .`
FROM adolphlwq/ubuntu_jre8

ADD supervisord.conf /etc/

RUN curl -fL http://apache.mirror.digitalpacific.com.au/zookeeper/stable/zookeeper-3.4.6.tar.gz | tar xzf - -C /usr/local && \
    mv /usr/local/zookeeper-3.4.6 /usr/local/zookeeper

ENV ZK_HOME=/usr/zookeeper
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
