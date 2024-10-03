SELECT CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) as uri
, JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as call_number
, resource.title as resource_title
, ao.title as ao_title
# , dcs_dobs.digital_object_id
, GROUP_CONCAT(IFNULL(dcs_dobs.title, 'NA') SEPARATOR '; ') as dcs_titles
, GROUP_CONCAT(IFNULL(pres_dobs.dob_title, 'NA') SEPARATOR '; ') as pres_titles
FROM archival_object ao
JOIN resource on resource.id = ao.root_record_id
LEFT JOIN (SELECT ao.id as ao_id
	, dob.digital_object_id
	, dob.title
	FROM digital_object dob
	JOIN instance_do_link_rlshp idlr on idlr.digital_object_id = dob.id
	JOIN instance on instance.id = idlr.instance_id
	JOIN archival_object ao on ao.id = instance.archival_object_id
	WHERE dob.digital_object_id like '%oid:%') as dcs_dobs on dcs_dobs.ao_id = ao.id
LEFT JOIN (SELECT ao.id as ao_id
	, dob.title as dob_title
	, dob.digital_object_id
	FROM archival_object ao
	JOIN instance on instance.archival_object_id = ao.id
	JOIN instance_do_link_rlshp idlr on idlr.instance_id = instance.id
	JOIN digital_object dob on dob.id = idlr.digital_object_id
	JOIN resource on resource.id = ao.root_record_id
	WHERE dob.digital_object_id REGEXP "^[a-zA-Z0-9]{8}[-][a-zA-Z0-9]{4}[-][a-zA-Z0-9]{4}[-][a-zA-Z0-9]{4}[-][a-zA-Z0-9]{12}$") pres_dobs on pres_dobs.ao_id = ao.id
GROUP BY ao.id