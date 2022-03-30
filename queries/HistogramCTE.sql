WITH data_table AS (
  SELECT epoch() as id  
  FROM AdBids
  WHERE id IS NOT NULL
), S AS (
  SELECT 
    min(id) as minVal,
    max(id) as maxVal,
    (max(id) - min(id)) as rng
    FROM data_table
), values AS (
  SELECT id as value from data_table
  WHERE id IS NOT NULL
), buckets AS (
  SELECT
    rng as bucket,
    (rng) * (select rng FROM S) / 50 + (select minVal from S) as low,
    (rng + 1) * (select rng FROM S) / 50 + (select minVal from S) as high
  FROM X
),
histogram_stage AS (
SELECT
    bucket,
    low,
    high,
    count(values.value) as count
  FROM buckets LEFT JOIN values ON (values.value >= low and values.value < high)
  GROUP BY bucket, low, high
  ORDER BY BUCKET
),
right_edge AS (
  SELECT count(*) as c from values WHERE value = (select maxVal from S)
)
SELECT 
  bucket,
  low,
  high,
  CASE WHEN high = (SELECT max(high) from histogram_stage) THEN count + (select c from right_edge) ELSE count END AS count
  FROM histogram_stage