#Query to get data on records that have multiple subrecords
SELECT ao.id
	, ao.repo_id
	, no_dates.number_of_dates
	, no_events.number_of_linked_events
	, no_extents.number_of_extents
	, no_external_docs.number_of_external_documents
	, no_external_ids.number_of_external_ids
	, no_instances.number_of_instances
	, no_langs.number_of_languages
	, no_agents.number_of_linked_agents
	, no_notes.number_of_notes
	, no_restrictions.number_of_restrictions
	, no_subjects.number_of_linked_subjects
FROM archival_object ao
#ark_name - no data, skip
#assessment_rlshp - no data, skip
#dates
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_dates
		   FROM date
		   GROUP BY archival_object_id) as no_dates on no_dates.archival_object_id = ao.id
#event_link_rlshp
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_linked_events
		   FROM event_link_rlshp
		   GROUP BY archival_object_id) as no_events on no_events.archival_object_id = ao.id
#extents
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_extents
		   FROM extent
		   GROUP BY archival_object_id) as no_extents on no_extents.archival_object_id = ao.id
#external_documents
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_external_documents
		  FROM external_document
		  GROUP BY archival_object_id) as no_external_docs on no_external_docs.archival_object_id = ao.id
#external_ids
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_external_ids
		  FROM external_id
		  GROUP BY archival_object_id) as no_external_ids on no_external_ids.archival_object_id = ao.id
#instances
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_instances
		  FROM instance
		  GROUP BY archival_object_id) as no_instances on no_instances.archival_object_id = ao.id
#lang_material
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_languages
		  FROM lang_material
		  GROUP BY archival_object_id) as no_langs on no_langs.archival_object_id = ao.id
#linked_agents_rlshp
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_linked_agents
		  FROM linked_agents_rlshp
		  GROUP BY archival_object_id) as no_agents on no_agents.archival_object_id = ao.id
#notes - any way to get subcounts?
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_notes
		  FROM note
		  GROUP BY archival_object_id) as no_notes on no_notes.archival_object_id = ao.id
#rights_restrictions
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_restrictions
		  FROM note
		  GROUP BY archival_object_id) as no_restrictions on no_restrictions.archival_object_id = ao.id
#rights_statements - no data, skip
#subject_rlshp
LEFT JOIN (SELECT archival_object_id
			, COUNT(*) as number_of_linked_subjects
		  FROM note
		  GROUP BY archival_object_id) as no_subjects on no_subjects.archival_object_id = ao.id
WHERE (ao.repo_id is NULL or ao.repo_id = 12)
AND (no_dates.number_of_dates is not NULL
		OR no_events.number_of_linked_events is not NULL
		OR no_extents.number_of_extents is not NULL
		OR no_external_docs.number_of_external_documents is not NULL
		OR no_external_ids.number_of_external_ids is not NULL
		OR no_instances.number_of_instances is not NULL
		OR no_langs.number_of_languages is not NULL
		OR no_agents.number_of_linked_agents is NOT NULL
		OR no_notes.number_of_notes is not NULL
		OR no_restrictions.number_of_restrictions is not NULL
		OR no_subjects.number_of_linked_subjects is not NULL)

