select ev.id
      , ev.value
from enumeration_value ev
LEFT JOIN extent on extent.extent_type = ev.id
where extent.id is null
and ev.enumeration_id = 14
UNION
select ev.id
    , ev.value
from enumeration_value ev
RIGHT JOIN extent on extent.extent_type = ev.id
where extent.id is null
and ev.enumeration_id = 14
