SELECT DISTINCT JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as identifier
	, resource.title as title
	, tc.indicator as container_number
	, location.title as location
FROM archival_object ao
JOIN instance on instance.archival_object_id = ao.id
LEFT JOIN sub_container sc on sc.instance_id = instance.id
JOIN top_container_link_rlshp tclr on tclr.sub_container_id = sc.id
JOIN top_container tc on tc.id = tclr.top_container_id
JOIN top_container_housed_at_rlshp tchar on tchar.top_container_id = tc.id
JOIN location on location.id = tchar.location_id
JOIN resource on resource.id = ao.root_record_id
WHERe location.title like '%B51-A%'
UNION ALL
SELECT DISTINCT ao.identifier as identifier
	, ao.title as title
	, tc.indicator as container_number
	, location.title as location
FROM accession ao
JOIN instance on instance.accession_id = ao.id
LEFT JOIN sub_container sc on sc.instance_id = instance.id
JOIN top_container_link_rlshp tclr on tclr.sub_container_id = sc.id
JOIN top_container tc on tc.id = tclr.top_container_id
JOIN top_container_housed_at_rlshp tchar on tchar.top_container_id = tc.id
JOIN location on location.id = tchar.location_id
WHERe location.title like '%B51-A%'