SELECT
  EXPLODE(SPLIT(body, '\n'))
FROM ${inputView}