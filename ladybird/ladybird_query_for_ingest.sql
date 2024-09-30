# projects: 6, 7, 31, 35, 39, 43, 44, 61
# collections: 4, 19 (also 24, but none of the projects are in-scope)
# project/collection: 6/4, 7/4, 31/4, 35/4, 39/4, 43/19, 44/19, 61/19


SELECT DISTINCT
	'4' as cid
	, '6' as pid
	, oid
	, fdid
	, value
FROM p6_strings
UNION ALL
SELECT DISTINCT 
	'4' as cid
	, '7' as pid
	, oid
	, fdid
	, value
FROM p7_strings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '31' as pid
	, oid
	, fdid
	, value
FROM p31_strings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '35' as pid
	, oid
	, fdid
	, value
FROM p35_strings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '39' as pid
	, oid
	, fdid
	, value
FROM p39_strings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, '43' as pid
	, oid
	, fdid
	, value
FROM p43_strings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, '44' as pid
	, oid
	, fdid
	, value
FROM p44_strings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, '61' as pid
	, oid
	, fdid
	, value
FROM p61_strings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, '61' as pid
	, oid
	, fdid
	, value
FROM p61_longstrings
UNION ALL
SELECT DISTINCT
	'19' as cid
	, '43' as pid
	, oid
	, fdid
	, value
FROM p43_longstrings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '39' as pid
	, oid
	, fdid
	, value
FROM p39_longstrings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '35' as pid
	, oid
	, fdid
	, value
FROM p35_longstrings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '31' as pid
	, oid
	, fdid
	, value
FROM p31_longstrings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '7' as pid
	, oid
	, fdid
	, value
FROM p7_longstrings
UNION ALL
SELECT DISTINCT
	'4' as cid
	, '6' as pid
	, oid
	, fdid
	, value
FROM p6_longstrings






















