SELECT #JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as call_number
#	, resource.title as resource_title
	COUNT(*) as lang_count
	, lang_struct.lang as lang_val
#	, lang_struct.script
#	, lang_notes.note_text
#	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri
FROM resource
LEFT JOIN (SELECT lang_material_id as lmi
			, resource.id as resource_id
			, JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.content[0]')) as note_text 
		   FROM note
		   JOIN lang_material lm on lm.id = note.lang_material_id
		   JOIN resource on resource.id = lm.resource_id
		   ) as lang_notes on lang_notes.resource_id = resource.id
LEFT JOIN (SELECT resource.id as resource_id
			, lm.id as lmi
			, ev.value as lang
			, ev2.value as script
		   FROM lang_material lm
		   JOIN language_and_script las on las.lang_material_id = lm.id
		   JOIN resource on resource.id = lm.resource_id
		   LEFT JOIN enumeration_value ev on ev.id = las.language_id
		   LEFT JOIN enumeration_value ev2 on ev2.id = las.script_id
		   AND las.language_id is not null) as lang_struct on lang_struct.resource_id = resource.id
GROUP BY lang_struct.lang

