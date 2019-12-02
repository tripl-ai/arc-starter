#!/bin/bash
ARC_JUPYTER_VERSION=1.9.1
HADOOP_VERSION=2.9.2
IMAGE_VERSION=1.0.0
JAVA_OPTS=-Xmx4g
cat <<"EOF"

   ___             ______           __         
  / _ | ________  / __/ /____ _____/ /____ ____
 / __ |/ __/ __/ _\ \/ __/ _ `/ __/ __/ -_) __/
/_/ |_/_/  \__/ /___/\__/\_,_/_/  \__/\__/_/   
EOF
cat <<EOF

version $ARC_JUPYTER_VERSION

EOF
PS3='Please choose version: '
options=("Scala 2.11 (includes arc-cassandra-pipeline-plugin, arc-deltaperiod-config-plugin, arc-deltalake-pipeline-plugin, arc-elasticsearch-pipeline-plugin, arc-kafka-pipeline-plugin, arc-mongodb-pipeline-plugin, arc-sas-pipeline-plugin)" "Scala 2.12 (includes arc-deltalake-pipeline-plugin, arc-deltaperiod-config-plugin, arc-graph-pipeline-plugin, arc-kafka-pipeline-plugin, arc-mongodb-pipeline-plugin, arc-sas-pipeline-plugin)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Scala 2.11 (includes arc-cassandra-pipeline-plugin, arc-deltaperiod-config-plugin, arc-deltalake-pipeline-plugin, arc-elasticsearch-pipeline-plugin, arc-kafka-pipeline-plugin, arc-mongodb-pipeline-plugin, arc-sas-pipeline-plugin)")
            docker run \
                --name arc-jupyter \
                --rm \
                -v $(pwd)/examples:/home/jovyan/examples:Z \
                -e JAVA_OPTS=${JAVA_OPTS} \
                -p 4040:4040 \
                -p 8888:8888 \
                triplai/arc-jupyter:arc-jupyter_${ARC_JUPYTER_VERSION}_scala_2.11_hadoop_${HADOOP_VERSION}_${IMAGE_VERSION} \
                start-notebook.sh \
                --NotebookApp.password='' \
                --NotebookApp.token=''
            break
            ;;
        "Scala 2.12 (includes arc-deltalake-pipeline-plugin, arc-deltaperiod-config-plugin, arc-graph-pipeline-plugin, arc-kafka-pipeline-plugin, arc-mongodb-pipeline-plugin, arc-sas-pipeline-plugin)")
            docker run \
                --name arc-jupyter \
                --rm \
                -v $(pwd)/examples:/home/jovyan/examples:Z \
                -e JAVA_OPTS=${JAVA_OPTS} \
                -p 4040:4040 \
                -p 8888:8888 \
                triplai/arc-jupyter:arc-jupyter_${ARC_JUPYTER_VERSION}_scala_2.12_hadoop_${HADOOP_VERSION}_${IMAGE_VERSION} \
                start-notebook.sh \
                --NotebookApp.password='' \
                --NotebookApp.token=''
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
