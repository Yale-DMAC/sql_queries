SELECT CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri	
	, npi.persistent_id
	, replace(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.subnotes[0].content')), 'mssa.assist@yale.edu', '<ref actuate="onRequest" show="new" href="mailto:beinecke.library@yale.edu">beinecke.library@yale.edu</ref>') as note_text
FROM note 
LEFT JOIN resource on resource.id = note.resource_id
LEFT JOIN note_persistent_id npi on npi.note_id = note.id
where note.notes like "%mssa.assist%"




<ref actuate="onRequest" show="new" href="mailto:beinecke.library@yale.edu>beinecke.library@yale.edu</ref>