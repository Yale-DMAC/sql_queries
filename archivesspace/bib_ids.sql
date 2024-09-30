SELECT ud.string_2 as bib_id
    , CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri
	, CONCAT('https://archivesspace.library.yale.edu/resources/', ud.resource_id) as staff_url
    , resource.title as collection_title
    , JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as call_number
    , repository.name as repo_name
FROM user_defined ud
JOIN resource on resource.id = ud.resource_id
JOIN repository on repository.id = resource.repo_id
