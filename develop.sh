#!/bin/bash
JAVA_OPTS=-Xmx4G
cat <<"EOF"

    ___                     __                  __
   /   |  __________       / /_  ______  __  __/ /____  _____
  / /| | / ___/ ___/  __  / / / / / __ \/ / / / __/ _ \/ ___/
 / ___ |/ /  / /__   / /_/ / /_/ / /_/ / /_/ / /_/  __/ /
/_/  |_/_/   \___/   \____/\__,_/ .___/\__, /\__/\___/_/
                               /_/    /____/

EOF

docker run \
--name arc-jupyter \
--rm \
--volume $(pwd)/examples:/home/jovyan/examples:Z \
--env "JAVA_OPTS=${JAVA_OPTS}" \
--entrypoint="" \
--publish 4040:4040 \
--publish 8888:8888 \
triplai/arc-jupyter:latest \
jupyter lab \
--ip=0.0.0.0 \
--no-browser \
--NotebookApp.password='' \
--NotebookApp.token=''
