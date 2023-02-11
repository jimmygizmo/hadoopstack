# Deprecated custom Ubuntu Java base image
# FROM ubuntu:18.04
# RUN apt-get update -y \
#     && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends \
#         sudo \
#         wget \
#         openjdk-8-jdk \
#     && apt-get clean

# About Temurin images: The Eclipse Temurin™ project provides code and processes that support
# the building of runtime binaries and associated technologies that are high performance,
# enterprise-caliber, cross-platform, open-source licensed, and Java SE TCK-tested for general
# use across the Java ecosystem. Sounds good to me! TODO: Note the size here.
FROM eclipse-temurin:8-jdk-focal

RUN apt-get update -y \
    && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends \
        sudo \
        curl \
        ssh \
    && apt-get clean

RUN useradd -m hduser && echo "hduser:supergroup" | chpasswd && adduser hduser sudo && echo "hduser     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && cd /usr/bin/ && sudo ln -s python3 python

COPY ssh_config /etc/ssh/ssh_config

WORKDIR /home/hduser

USER hduser

# Interesting that the self public key is added to the self authorized_keys. Question: What happens when ssh to self
# without this? Would we have to enter a password to ssh to ourselves? Possibly. So this might just be to enable ssh
# to self. Simplge as that. Also note. It seems that the known_hosts prompt will still occur the first time, so
# this has not eliminated that stopping point. There is no issue here. Merely a curiosity. It's good to understand
# each step you use in it's entirety.
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys

ENV HADOOP_VERSION=3.3.3

ENV HADOOP_HOME /home/hduser/hadoop-${HADOOP_VERSION}

# The source archive file here must be put in place manually prior to docker build. See SETUP.md
COPY "hadoop-$HADOOP_VERSION.tar.gz" /home/hduser
RUN gunzip "/home/hduser/hadoop-$HADOOP_VERSION.tar.gz"
RUN tar -xvf "/home/hduser/hadoop-$HADOOP_VERSION.tar"
RUN rm -rf ${HADOOP_HOME}/share/doc

ENV HDFS_NAMENODE_USER hduser

ENV HDFS_DATANODE_USER hduser

ENV HDFS_SECONDARYNAMENODE_USER hduser

ENV YARN_RESOURCEMANAGER_USER hduser

ENV YARN_NODEMANAGER_USER hduser

RUN echo "export JAVA_HOME=/opt/java/openjdk/" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

COPY yarn-site.xml $HADOOP_HOME/etc/hadoop/
COPY core-site.xml $HADOOP_HOME/etc/hadoop/
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY entrypoint.sh $HADOOP_HOME/etc/hadoop/

ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ADD mapreduce/ mapreduce/

# This chmod fixes a permission problem preventing container startup. Exact root cause not totally understood yet.
# Problem started after reconfiguring project but it was not a simple typo or missed conifig. Still a mystery why
# older structure worked and then a simple project structure change caused the need for this chmod. The structure
# change was outside the image not within it, hence why it is rather mysterious at this point. But it's fixed now!
RUN sudo chmod -R 755 $HADOOP_HOME/etc/hadoop/

EXPOSE 22
EXPOSE 50070 50075 50010 50020 50090
EXPOSE 8020 9000 9864 9870
EXPOSE 10020 19888
EXPOSE 8088 8030 8031 8032 8033 8040 8042

WORKDIR /usr/local/bin

RUN sudo ln -s ${HADOOP_HOME}/etc/hadoop/entrypoint.sh .

WORKDIR /home/hduser

# YARNSTART=0 will prevent yarn scheduler from being launched
ENV YARNSTART 0

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

