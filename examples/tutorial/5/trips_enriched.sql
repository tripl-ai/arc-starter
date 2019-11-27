-- enrich the data by:
-- - filtering bad data
-- - one-hot encode hour component of pickup_datetime
-- - one-hot encode dayofweek component of pickup_datetime
-- - calculate duration in seconds
-- - adding flag to indicate whether pickup/dropoff within jfk airport bounding box
SELECT 
    *
    ,CAST(HOUR(pickup_datetime) = 0 AS INT) AS pickup_hour_0
    ,CAST(HOUR(pickup_datetime) = 1 AS INT) AS pickup_hour_1
    ,CAST(HOUR(pickup_datetime) = 2 AS INT) AS pickup_hour_2
    ,CAST(HOUR(pickup_datetime) = 3 AS INT) AS pickup_hour_3
    ,CAST(HOUR(pickup_datetime) = 4 AS INT) AS pickup_hour_4
    ,CAST(HOUR(pickup_datetime) = 5 AS INT) AS pickup_hour_5
    ,CAST(HOUR(pickup_datetime) = 6 AS INT) AS pickup_hour_6
    ,CAST(HOUR(pickup_datetime) = 7 AS INT) AS pickup_hour_7
    ,CAST(HOUR(pickup_datetime) = 8 AS INT) AS pickup_hour_8
    ,CAST(HOUR(pickup_datetime) = 9 AS INT) AS pickup_hour_9
    ,CAST(HOUR(pickup_datetime) = 10 AS INT) AS pickup_hour_10
    ,CAST(HOUR(pickup_datetime) = 11 AS INT) AS pickup_hour_11
    ,CAST(HOUR(pickup_datetime) = 12 AS INT) AS pickup_hour_12
    ,CAST(HOUR(pickup_datetime) = 13 AS INT) AS pickup_hour_13
    ,CAST(HOUR(pickup_datetime) = 14 AS INT) AS pickup_hour_14
    ,CAST(HOUR(pickup_datetime) = 15 AS INT) AS pickup_hour_15
    ,CAST(HOUR(pickup_datetime) = 16 AS INT) AS pickup_hour_16
    ,CAST(HOUR(pickup_datetime) = 17 AS INT) AS pickup_hour_17
    ,CAST(HOUR(pickup_datetime) = 18 AS INT) AS pickup_hour_18
    ,CAST(HOUR(pickup_datetime) = 19 AS INT) AS pickup_hour_19
    ,CAST(HOUR(pickup_datetime) = 20 AS INT) AS pickup_hour_20
    ,CAST(HOUR(pickup_datetime) = 21 AS INT) AS pickup_hour_21
    ,CAST(HOUR(pickup_datetime) = 22 AS INT) AS pickup_hour_22
    ,CAST(HOUR(pickup_datetime) = 23 AS INT) AS pickup_hour_23
    ,CAST(DAYOFWEEK(pickup_datetime) = 0 AS INT) AS pickup_dayofweek_0
    ,CAST(DAYOFWEEK(pickup_datetime) = 1 AS INT) AS pickup_dayofweek_1
    ,CAST(DAYOFWEEK(pickup_datetime) = 2 AS INT) AS pickup_dayofweek_2
    ,CAST(DAYOFWEEK(pickup_datetime) = 3 AS INT) AS pickup_dayofweek_3
    ,CAST(DAYOFWEEK(pickup_datetime) = 4 AS INT) AS pickup_dayofweek_4
    ,CAST(DAYOFWEEK(pickup_datetime) = 5 AS INT) AS pickup_dayofweek_5
    ,CAST(DAYOFWEEK(pickup_datetime) = 6 AS INT) AS pickup_dayofweek_6
    ,UNIX_TIMESTAMP(dropoff_datetime) - UNIX_TIMESTAMP(pickup_datetime) AS duration
    ,CASE
        WHEN 
            (pickup_latitude < 40.651381 
            AND pickup_latitude > 40.640668
            AND pickup_longitude < -73.776283
            AND pickup_longitude > -73.794694)
            OR
            (dropoff_latitude < 40.651381 
            AND dropoff_latitude > 40.640668
            AND dropoff_longitude < -73.776283
            AND dropoff_longitude > -73.794694)           
        THEN 1 
        ELSE 0
    END AS jfk
FROM trips
WHERE trip_distance > 0
AND pickup_longitude IS NOT NULL
AND pickup_latitude IS NOT NULL
AND dropoff_longitude IS NOT NULL
AND dropoff_latitude IS NOT NULL