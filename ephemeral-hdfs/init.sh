#!/bin/bash

pushd /root > /dev/null

if [ -d "ephemeral-hdfs" ]; then
  echo "Ephemeral HDFS seems to be installed. Exiting."
  return 0
fi

case "$HADOOP_MAJOR_VERSION" in
  1)
    wget -q http://s3.amazonaws.com/spark-related-packages/hadoop-1.0.4.tar.gz
    echo "Unpacking Hadoop"
    tar xvzf hadoop-1.0.4.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    mv hadoop-1.0.4/ ephemeral-hdfs/ > /tmp/spark-ec2_hadoop.log
    sed -i 's/-jvm server/-server/g' /root/ephemeral-hdfs/bin/hadoop > /tmp/spark-ec2_hadoop.log
    cp /root/hadoop-native/* /root/ephemeral-hdfs/lib/native/ > /tmp/spark-ec2_hadoop.log
    ;;
  2) 
    wget -q http://s3.amazonaws.com/spark-related-packages/hadoop-2.0.0-cdh4.2.0.tar.gz
    echo "Unpacking Hadoop"
    tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    mv hadoop-2.0.0-cdh4.2.0/ ephemeral-hdfs/ > /tmp/spark-ec2_hadoop.log

    # Have single conf dir
    rm -rf /root/ephemeral-hdfs/etc/hadoop/ > /tmp/spark-ec2_hadoop.log
    ln -s /root/ephemeral-hdfs/conf /root/ephemeral-hdfs/etc/hadoop > /tmp/spark-ec2_hadoop.log
    cp /root/hadoop-native/* /root/ephemeral-hdfs/lib/native/ > /tmp/spark-ec2_hadoop.log
    ;;
  yarn)
    wget -q http://s3.amazonaws.com/spark-related-packages/hadoop-2.7.3.tar.gz
    echo "Unpacking Hadoop"
    tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    mv hadoop-2.7.3/ ephemeral-hdfs/ > /tmp/spark-ec2_hadoop.log

    # Have single conf dir
    rm -rf /root/ephemeral-hdfs/etc/hadoop/ > /tmp/spark-ec2_hadoop.log
    ln -s /root/ephemeral-hdfs/conf /root/ephemeral-hdfs/etc/hadoop > /tmp/spark-ec2_hadoop.log
    ;;

  *)
     echo "ERROR: Unknown Hadoop version"
     return 1
esac
/root/spark-ec2/copy-dir /root/ephemeral-hdfs > /tmp/spark-ec2_hadoop.log

popd > /dev/null
