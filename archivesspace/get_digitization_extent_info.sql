SELECT DISTINCT CONCAT('https://archives.yale.edu/repositories/', resource.repo_id, '/resources/', resource.id) as aay_url 
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as resource_uri 
	, JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as call_number
	, resource.title as collection_title
	, COUNT(access_dobs.dob_id) as dob_id_counts
	, SUM(access_dobs.av_uris) as av_item_counts
	, SUM(IFNULL(access_dobs.file_uri_captions, 0)) as dob_image_counts
	, instantiated.count as instantiated_components_pub
	, all_components.components as all_components
FROM archival_object ao
JOIN instance on instance.archival_object_id = ao.id
JOIN instance_do_link_rlshp idlr on idlr.instance_id = instance.id
JOIN digital_object dob on dob.id = idlr.digital_object_id
JOIN resource on resource.id = ao.root_record_id
JOIN (# this gets all the aviary and dcs digital objects and their image counts, if present
	SELECT dob.id as dob_db_id
		, CONCAT('/repositories/', dob.repo_id, '/digital_objects/', dob.id) as dob_uri
		, dob.digital_object_id as dob_id
		, dob.title as dob_title
		, SUM(IF(fv.file_uri like '%aviary%', 1, 0)) as av_uris
		, GROUP_CONCAT(replace(replace(fv.caption, ' images', ''), ' image', '') SEPARATOR '; ') as file_uri_captions
	FROM digital_object dob
	LEFT JOIN file_version fv on fv.digital_object_id = dob.id
	WHERE dob.title not like '%preservica%'
	AND fv.file_uri not like "%vufind%"
	AND fv.file_uri not like '%findit%'
	AND dob.publish = 1
	AND (dob.digital_object_id like '%oid%'
			OR dob.digital_object_id like '%aviary%')
	AND (fv.caption is NULL or fv.caption like '% image%')
	GROUP BY dob.id) as access_dobs on access_dobs.dob_db_id = dob.id
# all components, and all published/instantiated components
JOIN (SELECT COUNT(*) as count
		, instance_aos.root_record_id as resource_id
		FROM (SELECT DISTINCT ao.id
				, ao.root_record_id 
			FROM archival_object ao
			JOIN resource on resource.id = ao.root_record_id
			JOIN instance on instance.archival_object_id = ao.id
			WHERE ao.publish = 1
			AND resource.publish = 1
			AND resource.suppressed = 0
			AND ao.suppressed = 0) as instance_aos
		GROUP BY instance_aos.root_record_id) as instantiated on instantiated.resource_id = resource.id
JOIN (SELECT COUNT(*) AS components
		, ao.root_record_id as resource_id
	FROM archival_object ao
	JOIN resource on resource.id = ao.root_record_id
	GROUP BY ao.root_record_id) as all_components on all_components.resource_id = resource.id
GROUP BY resource.id
ORDER BY access_dobs.file_uri_captions