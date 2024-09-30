SELECT root_record_id
	, COUNT(root_record_id) as counts
FROM (SELECT DISTINCT CONCAT('/repositories/', tc.repo_id, '/top_containers/', tc.id) as uri
	, tc.indicator
	, ao.root_record_id
FROM top_container tc
JOIN top_container_link_rlshp tclr on tclr.top_container_id = tc.id
JOIN sub_container sc on sc.id = tclr.sub_container_id
JOIN instance on instance.id = sc.instance_id
JOIN archival_object ao on ao.id = instance.archival_object_id) containers
GROUP BY root_record_id
ORDER BY counts desc