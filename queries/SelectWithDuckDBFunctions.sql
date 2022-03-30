select min(col) as min, max(col) as max, avg(col)::FLOAT as mean, stddev_pop(col) as sd,
reservoir_quantile(col, 0.25) as q25, reservoir_quantile(col, 0.5) as q50, reservoir_quantile(col, 0.75) as q75 FROM AdBids;
