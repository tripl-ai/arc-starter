#!/bin/bash
docker run \
--interactive \
--tty \
--name arc-jupyter \
--rm \
--volume $(pwd)/examples:/home/jovyan/examples:Z \
--env "JAVA_OPTS=-Xmx4G" \
--publish 4040:4040 \
--publish 8080:8080 \
ghcr.io/tripl-ai/arc-jupyter:latest