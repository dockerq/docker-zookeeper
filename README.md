# Docker zookeeper image
## Overview
![](http://zookeeper.apache.org/images/zookeeper_small.gif)

>ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications. Each time they are implemented there is a lot of work that goes into fixing the bugs and race conditions that are inevitable. Because of the difficulty of implementing these kinds of services, applications initially usually skimp on them ,which make them brittle in the presence of change and difficult to manage. Even when done correctly, different implementations of these services lead to management complexity when the applications are deployed.

[zookeeper](http://zookeeper.apache.org/)是一种中心化的服务。维护配置信息、名称、组服务以及在分布式集群中同步信息。

zookeeper在分布式应用中扮演非常重要的角色。由于历史悠久、稳定性高。很多分布式应用都对zookeeper有很强的依赖：kafka，mesos，marathon在集群部署模式、HA模式下都可以使用zookeeper做状态管理、Leader选举。

zookeeper本身支持集群部署，这样会提高zookeeper的可用性。这里我的Dockerfile只将zookeeper配置为`单节点`，如果想把zookeeper配置成集群模式，[请参考这里](http://zookeeper.apache.org/doc/trunk/zookeeperStarted.html)。

## Note
在使用zookeeper过程中有很多注意事项：

1. 很多依赖zookeeper的分布式应用都会提供基于zookeeper编译好的包。这时**一定要注意分布式应用的zookeeper包版本和zookeeper的版本要一致**，否则会报错。
2. `zoo.cfg`中存放了zookeeper的相关配置信息，这里我只配置了`dataDir`，您可以很据自己的使用需求结合[zookeeper配置](http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration)来个性化自己的配置。
3. 另外我在[Dockerfile](https://github.com/DHOPL/docker-zookeeper/blob/master/Dockerfile)中配置了zookeeper的日志:
```
sed -i s@zookeeper.log.dir=.*@zookeeper.log.dir=/var/zookeeper/log@ ${ZK_HOME}/conf/log4j.properties && \
sed -i s@zookeeper.tracelog.dir=.*@zookeeper.tracelog.dir=/var/zookeeper/tracelog@ ${ZK_HOME}/conf/log4j.properties
```
可以根据自己的居然来修改日志文件的位置。
