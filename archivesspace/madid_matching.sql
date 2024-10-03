select DISTINCT CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) as uri
	, ao.display_string as display_string
	, replace(replace(replace(replace(replace(resource.identifier, ',', ''), '"', ''), ']', ''), '[', ''), 'null', '') AS call_number
	# will need to get series data for some of this
	, tc.indicator as tc_indicator
	, sc.indicator_2 as sc_indicator
	, preservica_dos.dob_titles
	, CONCAT('https://archives.yale.edu/repositories', ao.repo_id, '/archival_objects/', ao.id) as aay_url
from archival_object ao
left join resource on resource.id = ao.root_record_id
left join instance on instance.archival_object_id = ao.id
left join sub_container sc on sc.instance_id = instance.id
left join top_container_link_rlshp tclr on tclr.sub_container_id = sc.id
left join top_container tc on tclr.top_container_id = tc.id
LEFT JOIN top_container_profile_rlshp tcpr on tcpr.top_container_id = tc.id
LEFT JOIN enumeration_value ev on ev.id = sc.type_2_id
LEFT JOIN enumeration_value ev2 on ev2.id = tc.type_id
LEFT JOIN (select ao.id
			, GROUP_CONCAT(dob.title SEPARATOR '; ') as dob_titles
		   from archival_object ao
		   join instance on instance.archival_object_id = ao.id
	       join instance_do_link_rlshp idlr on idlr.instance_id = instance.id
		   join digital_object dob on dob.id = idlr.digital_object_id
		   WHERE ao.repo_id = 12
		   AND dob.title like '%Preservica%'
		   GROUP BY ao.id
		   ) as preservica_dos on preservica_dos.id = ao.id
WHERE ao.repo_id = 12
and tc.id is not null
ORDER BY CAST(tc.indicator AS UNSIGNED)