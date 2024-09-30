SELECT
  archival_object_id,
  event_id,
  role_id,
  COUNT(*) as duplicates
FROM `event_link_rlshp`
GROUP BY archival_object_id, event_id, role_id
HAVING duplicates > 1
ORDER BY duplicates DESC;