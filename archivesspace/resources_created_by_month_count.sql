SELECT left(rtrim(resource.create_time), 7) as `yyyy_mm`
  , count(left(rtrim(resource.create_time), 7)) as `resources_created`
FROM resource
WHERE resource.repo_id = 12
GROUP BY left(rtrim(resource.create_time), 7)
