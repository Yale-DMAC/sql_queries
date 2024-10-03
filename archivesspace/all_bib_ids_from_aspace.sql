SELECT CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) as uri
	, JSON_UNQUOTE(JSON_EXTRACT(resource.identifier, '$[0]')) as identifier
	, resource.title as title
	, ud.string_2
	, 'resource' as record_type
FROM user_defined ud
JOIN resource on resource.id = ud.resource_id
WHERE ud.string_2 is not null
UNION
SELECT CONCAT('/repositories/', accession.repo_id, '/accessions/', accession.id) as uri
	, CONCAT(JSON_UNQUOTE(JSON_EXTRACT(accession.identifier, '$[0]')),
				'-',
			 JSON_UNQUOTE(JSON_EXTRACT(accession.identifier, '$[1]')),
				'-',
			 JSON_UNQUOTE(JSON_EXTRACT(accession.identifier, '$[2]'))
			) as identifier
	, accession.title as title
	, ud.string_2
	, 'accession' as record_type
FROM user_defined ud
JOIN accession on accession.id = ud.accession_id
WHERE ud.string_2 is not null
