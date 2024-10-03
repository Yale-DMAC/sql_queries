SELECT NULL as id
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri
	, ev.value as script
	, ev2.value as language
	, resource.finding_aid_language_note as note_text
	, 'lang_finding_aid' as type
FROM resource
JOIN enumeration_value ev on ev.id = resource.finding_aid_script_id
JOIN enumeration_value ev2 on ev2.id = resource.finding_aid_language_id
UNION
SELECT lm.id
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri
	, ev.value as language
	, ev2.value as script
	, NULL as note_text
	, 'lang_code' as type
FROM language_and_script las
JOIN lang_material lm on lm.id = las.lang_material_id
JOIN resource on resource.id = lm.resource_id
LEFT JOIN enumeration_value ev on ev.id = las.language_id
LEFT JOIN enumeration_value ev2 on ev2.id = las.script_id
UNION
SELECT lm.id
	, CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) as uri
	, ev.value as language
	, ev2.value as script
	, NULL as note_text
	, 'lang_code' as type
FROM language_and_script las
JOIN lang_material lm on lm.id = las.lang_material_id
JOIN archival_object ao on ao.id = lm.archival_object_id
LEFT JOIN enumeration_value ev on ev.id = las.language_id
LEFT JOIN enumeration_value ev2 on ev2.id = las.script_id
UNION
SELECT lm.id
	, CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) as uri
	, NULL as language
	, NULL as script
	, JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.content[0]')) as note_text
	, 'lang_material_note' as type
FROM note
JOIN lang_material lm on lm.id = note.lang_material_id
JOIN archival_object ao on ao.id = lm.archival_object_id
UNION ALL
SELECT lm.id
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri
	, NULL as language
	, NULL as script
	, JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.content[0]')) as note_text
	, 'lang_material_note' as type
FROM note
JOIN lang_material lm on lm.id = note.lang_material_id
JOIN resource on resource.id = lm.resource_id