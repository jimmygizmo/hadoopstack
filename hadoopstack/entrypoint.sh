#! /bin/bash


set -e
sudo service ssh start

if [ ! -d "/tmp/hadoop-hduser/dfs/name" ]; then
        $HADOOP_HOME/bin/hdfs namenode -format && echo "OK : HDFS namenode format complete."
fi

$HADOOP_HOME/sbin/start-dfs.sh

echo "YARNSTART = $YARNSTART"
if [[ -z $YARNSTART || $YARNSTART -ne 0 ]]; then
        echo "======== YARN STARTUP ========: Executing start-yarn.sh"
        $HADOOP_HOME/sbin/start-yarn.sh
fi

# dfs
$HADOOP_HOME/bin/hdfs dfs -mkdir /tmp
$HADOOP_HOME/bin/hdfs dfs -mkdir /users
$HADOOP_HOME/bin/hdfs dfs -mkdir /jars
$HADOOP_HOME/bin/hdfs dfs -chmod 777 /tmp
$HADOOP_HOME/bin/hdfs dfs -chmod 777 /users
$HADOOP_HOME/bin/hdfs dfs -chmod 777 /jars
# dfsadmin
$HADOOP_HOME/bin/hdfs dfsadmin -safemode leave

# this will keep the container running
tail -f $HADOOP_HOME/logs/hadoop-*-namenode-*.log

