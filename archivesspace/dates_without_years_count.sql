select date.expression
    , count(date.expression) as `count`
from date
where date.expression not rlike '[0-9]{4}'
and date.expression is not null
GROUP BY date.expression
ORDER BY `count` DESC
