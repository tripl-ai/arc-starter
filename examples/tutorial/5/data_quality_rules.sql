SELECT
  TRUE AS valid
  ,TO_JSON(
      NAMED_STRUCT(
        'count', COUNT(*),
        'distance_without_charge', COALESCE(SUM(distance_without_charge), 0),
        'charge_without_distance', COALESCE(SUM(distance_without_charge), 0),
        'distance_without_passenger', COALESCE(SUM(distance_without_charge), 0)
      )
  ) AS message
FROM (
  SELECT
    CASE
      WHEN trip_distance > 0 AND fare_amount = 0 THEN 1
      ELSE 0
    END AS distance_without_charge,
    CASE
      WHEN trip_distance = 0 AND fare_amount > 0 THEN 1
      ELSE 0
    END AS charge_without_distance    
    ,CASE
      WHEN trip_distance > 0 AND passenger_count = 0 THEN 1
      ELSE 0
    END AS distance_without_passenger   
  FROM ${inputView}
) input_table