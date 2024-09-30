
-- Values in c23_acid table
-- fdid handle

-- x 99  Type of resource
-- x 100 Yale Collection
-- x 103 Rights
-- x 180 Item Permission
-- x 275 Digital Collection
-- x 288 Content Type

-- Values in c23_strings table
-- fdid handle
-- x 74  Caption
-- x 71  Variant Titles
-- x 56  Local Record Number
-- x 307 Breadcrumb trail
-- x 127 _Filename
-- x 70  Title
-- x 57  Local record ID, other
-- x 152 Job Information
-- x 110 Note, extended
-- x 108 Classroom use

use pamoja;
SELECT DISTINCT dbo.c23.oid
	, dbo.c23._oid
	, dbo.c23._zindex
	, dbo.c23._bparent
	, dbo.c23._parent
	, dbo.c23.pid
	, dbo.hydra_publish.hydraID
	, titles.title_value
	, captions.caption_value
	, breadcrumbs.breadcrumb_value
	, filenames.filename_value
	, lrns.lrn_value
	, variants.variant_value
	, localids.localid_value
	, jobs.job_value
	, extnotes.extnote_value
	-- , classrooms.classroom_value as classroom_values
	, rtypes.rtype_value
	, collections.collection_value
	, rights.rights_value
	, perms.permissions_value
	, digcolls.digcoll_value
	, ctypes.ctype_value
FROM dbo.c23
LEFT JOIN dbo.c23_strings on dbo.c23_strings.oid = dbo.c23.oid
LEFT JOIN dbo.hydra_publish on dbo.hydra_publish.oid = dbo.c23.oid
LEFT JOIN dbo.hydra_publish hp2 on dbo.hydra_publish._oid = hp2.oid
LEFT JOIN (SELECT dbo.c23_strings.oid as title_oid
		, dbo.c23_strings.value as title_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 70) titles on titles.title_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_strings.oid as caption_oid
		, dbo.c23_strings.value as caption_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 74) captions on captions.caption_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_strings.oid as breadcrumb_oid
		, dbo.c23_strings.value as breadcrumb_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 307) breadcrumbs on breadcrumbs.breadcrumb_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_strings.oid as fname_oid
		, dbo.c23_strings.value as filename_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 127) as filenames on filenames.fname_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_strings.oid as lrn_oid
		, dbo.c23_strings.value as lrn_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 56) lrns on lrns.lrn_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_strings.oid as variant_oid
		, dbo.c23_strings.value as variant_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 71) variants on variants.variant_oid = dbo.c23.oid	 
LEFT JOIN (SELECT dbo.c23_strings.oid as localid_oid
		, dbo.c23_strings.value as localid_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 57) localids on localids.localid_oid = dbo.c23.oid	 
LEFT JOIN (SELECT dbo.c23_strings.oid as job_oid
		, dbo.c23_strings.value as job_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 152) jobs on jobs.job_oid = dbo.c23.oid	 
LEFT JOIN (SELECT dbo.c23_strings.oid as extnote_oid
		, dbo.c23_strings.value as extnote_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 110) extnotes on extnotes.extnote_oid = dbo.c23.oid	 
LEFT JOIN (SELECT dbo.c23_strings.oid as classroom_oid
		, dbo.c23_strings.value as classroom_value
	  FROM dbo.c23_strings
	  WHERE dbo.c23_strings.fdid = 108) classrooms on classrooms.classroom_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_acid.oid as rtype_oid
		, dbo.acid.value as rtype_value
	  FROM dbo.c23_acid
	  JOIN dbo.acid on dbo.acid.acid = dbo.c23_acid.acid
	  WHERE dbo.c23_acid.fdid = 99) rtypes on rtypes.rtype_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_acid.oid as collection_oid
		, dbo.acid.value as collection_value
	  FROM dbo.c23_acid
	  JOIN dbo.acid on dbo.acid.acid = dbo.c23_acid.acid
	  WHERE dbo.c23_acid.fdid = 100) collections on collections.collection_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_acid.oid as rights_oid
		, dbo.acid.value as rights_value
	  FROM dbo.c23_acid
	  JOIN dbo.acid on dbo.acid.acid = dbo.c23_acid.acid
	  WHERE dbo.c23_acid.fdid = 103) rights on rights.rights_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_acid.oid as permissions_oid
		, dbo.acid.value as permissions_value
	  FROM dbo.c23_acid
	  JOIN dbo.acid on dbo.acid.acid = dbo.c23_acid.acid
	  WHERE dbo.c23_acid.fdid = 180) perms on perms.permissions_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_acid.oid as digcoll_oid
		, dbo.acid.value as digcoll_value
	  FROM dbo.c23_acid
	  JOIN dbo.acid on dbo.acid.acid = dbo.c23_acid.acid
	  WHERE dbo.c23_acid.fdid = 275) digcolls on digcolls.digcoll_oid = dbo.c23.oid
LEFT JOIN (SELECT dbo.c23_acid.oid as ctype_oid
		, dbo.acid.value as ctype_value
	  FROM dbo.c23_acid
	  JOIN dbo.acid on dbo.acid.acid = dbo.c23_acid.acid
	  WHERE dbo.c23_acid.fdid = 288) ctypes on ctypes.ctype_oid = dbo.c23.oid


-- SELECT * FROM dbo.field_definition
-- WHERE dbo.field_definition.handle in ('Breadcrumb trail', 'Caption', 'Variant Titles', 'Local Record Number', 
-- 	'Local record ID, other', 'Job Information', 'Note, extended', 'Classroom use', '_Filename', 'Title')



-- Skip the dbo.c23_longstrings; just some random field. Only 1 row
-- Skip the dbo.c23_file; just file info from the import
-- Skip the dbo.c23_version + dbo.c23_audit - more rando stuff
-- p65_longstrings, p65, p65_file are all empty

# this is how the thumbs were generated for Kissinger, etc.

Use pamoja
select distinct
tbl1.oid as FirstThumbOid,
tbl1.hydraid as FirstThumbHydra,
tbl1._oid as ParentOID, 
tbl2.HydraID as ParentHydraId ,
CONCAT('http://imageserver.library.yale.edu/', tbl1.hydraid, '/300.jpg') as FirstThumbPath
CONCAT('http://hdl.handle.net/10079/digcoll/', replace(tbl2.hydraid, 'digcoll:', '')) as ParentLibLink,
 tbl1.cid as collection_id,
 tbl1.pid as project_id,
 project.label as project_name
from hydra_publish as tbl1
left join hydra_publish as tbl2 on tbl1._oid = tbl2.oid
left join hydra_accessCondition_oid on hydra_accessCondition_oid.oid = tbl2.oid
left join project on project.pid = tbl1.pid
WHERE tbl1.cid in (23)
AND tbl1.zindex = 1
ORDER BY tbl1.hydraid desc

