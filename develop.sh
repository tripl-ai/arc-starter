#!/bin/bash
ARC_JUPYTER_VERSION=2.4.0
HADOOP_VERSION=2.9.2
IMAGE_VERSION=1.0.0
JAVA_OPTS=-Xmx4G
cat <<"EOF"

    ___                     __                  __
   /   |  __________       / /_  ______  __  __/ /____  _____
  / /| | / ___/ ___/  __  / / / / / __ \/ / / / __/ _ \/ ___/
 / ___ |/ /  / /__   / /_/ / /_/ / /_/ / /_/ / /_/  __/ /
/_/  |_/_/   \___/   \____/\__,_/ .___/\__, /\__/\___/_/
                               /_/    /____/
EOF
cat <<EOF
version: ${ARC_JUPYTER_VERSION}
includes arc-cassandra-pipeline-plugin, arc-dataquality-udf-plugin, arc-deltalake-pipeline-plugin, arc-deltaperiod-config-plugin, arc-kafka-pipeline-plugin, arc-mongodb-pipeline-plugin, arc-sas-pipeline-plugin

EOF

docker run \
--name arc-jupyter \
--rm \
--volume $(pwd)/examples:/home/jovyan/examples:Z \
--env "JAVA_OPTS=${JAVA_OPTS}" \
--env "conf_spark_sql_extensions=io.delta.sql.DeltaSparkSessionExtension" \
--entrypoint="" \
--publish 4040:4040 \
--publish 8888:8888 \
triplai/arc-jupyter:arc-jupyter_${ARC_JUPYTER_VERSION}_scala_2.12_hadoop_${HADOOP_VERSION}_${IMAGE_VERSION} \
jupyter notebook \
--ip=0.0.0.0 \
--no-browser \
--NotebookApp.password='' \
--NotebookApp.token=''
