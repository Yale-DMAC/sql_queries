SELECT DISTINCT CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) as uri 
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as resource_uri
	, JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as resource_id
	, resource.title as resource_title
	, hiers.series_cuid
	, hiers.path
	, ao.display_string
FROM archival_object ao
JOIN resource on resource.id = ao.root_record_id
JOIN instance on instance.archival_object_id = ao.id
LEFT JOIN sub_container sc on sc.instance_id = instance.id
LEFT JOIN top_container_link_rlshp tclr on tclr.sub_container_id = sc.id
LEFT JOIN top_container tc on tclr.top_container_id = tc.id
LEFT JOIN (WITH RECURSIVE hierarchies
		AS (SELECT ao.id as id
				, ao.repo_id as repo_id
				, 0 as lvl
				, IF(ev.value = 'series', ao.component_id, NULL) as series_cuid
				, IF(ev.value = 'series', ao.display_string, NULL) as series_title
				, IF(ev.value = 'series', ao.id, NULL) as series_id
		        , CONCAT(ao.display_string, ' (', CONCAT(UPPER(SUBSTRING(ev.value,1,1)),LOWER(SUBSTRING(ev.value,2))), ' ', IF(ao.component_id is not NULL, CAST(ao.component_id as CHAR), "N/A"), ')') as 						path
		    FROM archival_object ao
		    LEFT JOIN enumeration_value ev on ev.id = ao.level_id
		    JOIN resource on resource.id  = ao.root_record_id
		    WHERE ao.parent_id is NULL
		    UNION ALL
		    SELECT ao.id as id
		        , ao.repo_id as repo_id
		        , h.lvl + 1 as lvl
		        , h.series_cuid
		        , h.series_title
		        , h.series_id
		        , CONCAT(h.path ,' > ', CONCAT(ao.display_string, ' (', CONCAT(UPPER(SUBSTRING(ev.value,1,1)),LOWER(SUBSTRING(ev.value,2))), ' ', IF(ao.component_id is not NULL, CAST(ao.component_id as 						CHAR), "N/A"), ')')) AS path
		    FROM hierarchies h
		    JOIN archival_object ao on h.id = ao.parent_id
			JOIN resource on resource.id  = ao.root_record_id
		    LEFT JOIN enumeration_value ev on ev.id = ao.level_id)
			SELECT id
		        , repo_id
		        , lvl
				, series_cuid
				, series_title
				, path
		    FROM hierarchies) hiers on hiers.id = ao.id
WHERE ao.repo_id = 12
AND resource.identifier like '%RU%'
AND (lower(hiers.path) like '%ex-students%'
		OR lower(hiers.path) like '%expelled%'
		OR lower(hiers.path) like '%withdr%'
		OR lower(hiers.path) like '%executive committee%'
		OR lower(hiers.path) like '%non-graduates%'
		OR lower(hiers.path) like '%students on leave%'
		OR lower(hiers.path) like '%students not receiving degree%'
		OR lower(hiers.path) like '%x class of%')
ORDER BY JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]'))