docker run \
--rm \
-v $(pwd)/examples:/home/jovyan/examples:Z \
-e "ETL_CONF_ENV=production" \
-p 4040:4040 \
triplai/arc:arc_2.7.0_spark_2.4.4_scala_2.12_hadoop_2.9.2_1.0.0 \
bin/spark-submit \
--master local[*] \
--driver-memory 4g \
--driver-java-options "-XX:+UseG1GC -XX:-UseGCOverheadLimit -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap" \
--class ai.tripl.arc.ARC \
/opt/spark/jars/arc.jar \
--etl.config.uri=file:///home/jovyan/examples/tutorial/0/nyctaxi.ipynb
