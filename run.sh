docker run \
--rm \
--volume $(pwd)/examples:/home/jovyan/examples:Z \
--env "ETL_CONF_ENV=production" \
--entrypoint='' \
--publish 4041:4040 \
triplai/arc:arc_3.1.0_spark_3.0.0_scala_2.12_hadoop_3.2.0_1.0.0 \
bin/spark-submit \
--master local[*] \
--driver-memory 4g \
--driver-java-options "-XX:+UseG1GC" \
--conf spark.authenticate.secret=$(openssl rand -hex 64) \
--class ai.tripl.arc.ARC \
/opt/spark/jars/arc.jar \
--etl.config.uri=file:///home/jovyan/examples/tutorial/0/nyctaxi.ipynb
