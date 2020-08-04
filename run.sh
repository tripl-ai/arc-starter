docker run \
--rm \
--volume $(pwd)/examples:/home/jovyan/examples:Z \
--env "ETL_CONF_ENV=production" \
--entrypoint='' \
--publish 4041:4040 \
triplai/arc:latest \
bin/spark-submit \
--master local[*] \
--driver-memory 4g \
--driver-java-options "-XX:+UseG1GC" \
--conf spark.authenticate.secret=$(openssl rand -hex 64) \
--class ai.tripl.arc.ARC \
/opt/spark/jars/arc.jar \
--etl.config.uri=file:///home/jovyan/examples/tutorial/0/nyctaxi.ipynb
