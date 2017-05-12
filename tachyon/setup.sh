#!/bin/bash

/root/spark-ec2/copy-dir /root/tachyon > /tmp/spark-ec2_tachyon.log

/root/tachyon/bin/tachyon format > /tmp/spark-ec2_tachyon.log

sleep 1

/root/tachyon/bin/tachyon-start.sh all Mount > /tmp/spark-ec2_tachyon.log
