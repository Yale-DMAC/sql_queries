SELECT DISTINCT
	'4' as cid
	, NULL as pid
	, oid
	, fdid
	, value
FROM c4_strings
UNION ALL
SELECT DISTINCT 
	'4' as cid
	, NULL as pid
	, oid
	, fdid
	, value
FROM c4_longstrings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, NULL as pid
	, oid
	, fdid
	, value
FROM c19_strings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, NULL as pid
	, oid
	, fdid
	, value
FROM c19_longstrings