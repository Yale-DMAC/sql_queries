SELECT CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) as uri
	, ao.display_string as title
	, ev.value
	, hiers.series_cuid
	, hiers.series_title as series_title
	, dobs.dob_title
	, dobs.dob_id
	, NULL as container_indicator
	, NULL as container_type
FROM archival_object ao
LEFT JOIN enumeration_value ev on ev.id = ao.level_id
LEFT JOIN (WITH RECURSIVE hierarchies
		AS (SELECT ao.id as id
				, ao.repo_id as repo_id
				, 0 as lvl
				, IF(ev.value = 'otherlevel', ao.component_id, NULL) as series_cuid
				, IF(ev.value = 'otherlevel', ao.display_string, NULL) as series_title
				, IF(ev.value = 'otherlevel', ao.id, NULL) as series_id
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
		    FROM hierarchies) hiers on hiers.id = ao.id
LEFT JOIN (SELECT dob.title as dob_title
				, dob.digital_object_id as dob_id
				, ao.id as ao_id
		   FROM digital_object dob
		   LEFT JOIN instance_do_link_rlshp idlr on idlr.digital_object_id = dob.id
		   LEFT JOIN instance on instance.id = idlr.instance_id
		   LEFT JOIN archival_object ao on ao.id = instance.archival_object_id) dobs on dobs.ao_id = ao.id
WHERE ao.repo_id = 13
AND ao.component_id is not null