SELECT
  COALESCE(SUM(error) = 0, TRUE) AS valid
  ,TO_JSON(
      NAMED_STRUCT(
        'count', COUNT(error),
        'errors', COALESCE(SUM(error), 0)
      )
  ) AS message
FROM (
  SELECT
    CASE
      WHEN SIZE(_errors) > 0 THEN 1
      ELSE 0
    END AS error
  FROM ${inputView}
) input_table