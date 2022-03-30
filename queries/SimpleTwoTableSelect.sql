select count(*) as impressions, avg(bid.bid_price) as bid_price, bid.publisher, bid.domain, imp.city, imp.country
from AdBids bid join AdImpressions imp on bid.id = imp.id
group by bid.publisher, bid.domain, imp.city, imp.country
