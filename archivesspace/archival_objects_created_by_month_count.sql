SELECT left(rtrim(ao.create_time), 7) as `yyyy_mm`
  , count(left(rtrim(ao.create_time), 7)) as `archival_objects_created`
FROM archival_object ao
WHERE ao.repo_id = 12
GROUP BY left(rtrim(ao.create_time), 7)
