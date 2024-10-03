-- NULL	3935 (all repos, aos only)
SELECT ao.id
	, ao.repo_id
	, abstract.count as abstract_count
	, accessrestrict.count as accessrestrict_count
	, accruals.count as accruals_count
	, acqinfo.count as acqinfo_count
	, altformavail.count as altformavail_count
	, appraisal.count as appraisal_count
	, arrangement.count as arrangement_count
	, bioghist.count as bioghist_count
	, custodhist.count as custodhist_count
	, dimensions.count as dimensions_count
	, fileplan.count as fileplan_count
	, materialspec.count as materialspec_count
	, odd.count as odd_count
	, originalsloc.count as originalsloc_count
	, otherfindaid.count as otherfindaid_count
	, physdesc.count as physdesc_count
	, physfacet.count as physfacet_count
	, physloc.count as physloc_count
	, phystech.count as phystech_count
	, prefercite.count as prefercite_count
	, processinfo.count as processinfo_count
	, relatedmaterial.count as relatedmaterial_count
	, scopecontent.count as scopecontent_count
	, separatedmaterial.count as separatedmaterial_count
	, userestrict.count as userestrict_count
FROM archival_object ao
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'abstract'
		   GROUP BY note.archival_object_id) as abstract on abstract.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'accessrestrict'
		   GROUP BY note.archival_object_id) as accessrestrict on accessrestrict.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'accruals'
		   GROUP BY note.archival_object_id) as accruals on accruals.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'acqinfo'
		   GROUP BY note.archival_object_id) as acqinfo on acqinfo.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'altformavail'
		   GROUP BY note.archival_object_id) as altformavail on altformavail.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'appraisal'
		   GROUP BY note.archival_object_id) as appraisal on appraisal.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'arrangement'
		   GROUP BY note.archival_object_id) as arrangement on arrangement.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'bioghist'
		   GROUP BY note.archival_object_id) as bioghist on bioghist.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'custodhist'
		   GROUP BY note.archival_object_id) as custodhist on custodhist.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'dimensions'
		   GROUP BY note.archival_object_id) as dimensions on dimensions.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'fileplan'
		   GROUP BY note.archival_object_id) as fileplan on fileplan.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'materialspec'
		   GROUP BY note.archival_object_id) as materialspec on materialspec.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'odd'
		   GROUP BY note.archival_object_id) as odd on odd.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'originalsloc'
		   GROUP BY note.archival_object_id) as originalsloc on originalsloc.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'otherfindaid'
		   GROUP BY note.archival_object_id) as otherfindaid on otherfindaid.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'physdesc'
		   GROUP BY note.archival_object_id) as physdesc on physdesc.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'physfacet'
		   GROUP BY note.archival_object_id) as physfacet on physfacet.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'physloc'
		   GROUP BY note.archival_object_id) as physloc on physloc.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'phystech'
		   GROUP BY note.archival_object_id) as phystech on phystech.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'prefercite'
		   GROUP BY note.archival_object_id) as prefercite on prefercite.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'processinfo'
		   GROUP BY note.archival_object_id) as processinfo on processinfo.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'relatedmaterial'
		   GROUP BY note.archival_object_id) as relatedmaterial on relatedmaterial.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'scopecontent'
		   GROUP BY note.archival_object_id) as scopecontent on scopecontent.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'separatedmaterial'
		   GROUP BY note.archival_object_id) as separatedmaterial on separatedmaterial.archival_object_id = ao.id
LEFT JOIN (SELECT note.archival_object_id
			, COUNT(JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]'))) as count
		   FROM note
		   WHERE note.archival_object_id is not null
		   AND JSON_UNQUOTE(JSON_EXTRACT(CAST(CONVERT(note.notes using utf8) as json), '$.type[0]')) like 'userestrict'
		   GROUP BY note.archival_object_id) as userestrict on userestrict.archival_object_id = ao.id
WHERE ao.repo_id = 12