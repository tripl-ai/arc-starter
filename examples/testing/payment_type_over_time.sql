-- this query calculates the percentage of different payment methods by month which could be used by a business to track whether to keep accepting cash etc.

-- get a count of all records so monthly percentage can be calculated
WITH green_tripdata_monthly_trips AS (
  SELECT 
    COUNT(payment_type) AS green_tripdata_count 
    ,DATE_TRUNC('MM', lpep_pickup_datetime) AS month
  FROM green_tripdata0
  GROUP BY month
)
-- use the count to calcualte percentages
SELECT 
  CASE
    WHEN payment_type = '1' THEN 'Credit card'
    WHEN payment_type = '2' THEN 'Cash'
    WHEN payment_type = '3' THEN 'No charge'
    WHEN payment_type = '4' THEN 'Dispute'
    WHEN payment_type = '5' THEN 'Unknown'
    WHEN payment_type = '6' THEN 'Voided trip'
    ELSE 'Unknown'
  END AS payment_type
  ,DATE_TRUNC('MM', lpep_pickup_datetime) AS month
  ,COUNT(payment_type) / green_tripdata_count AS percent
FROM green_tripdata0
INNER JOIN green_tripdata_monthly_trips ON DATE_TRUNC('MM', green_tripdata0.lpep_pickup_datetime) = green_tripdata_monthly_trips.month
GROUP BY payment_type, DATE_TRUNC('MM', green_tripdata0.lpep_pickup_datetime), green_tripdata_count
ORDER BY payment_type, DATE_TRUNC('MM', green_tripdata0.lpep_pickup_datetime)