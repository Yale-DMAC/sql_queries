SELECT * FROM
(SELECT bib_text.bib_id
	, bib_text.title
	, bib_text.isbn
	, bib_text.issn
	, bib_text.lccn
	, bib_text.series
	, bib_text.begin_pub_date
	, bib_text.end_pub_date
	, bib_text.pub_dates_combined
	, bib_text.pub_place
	, bib_text.publisher
	, bib_text.author
	, bib_text.imprint
	, bib_text.bib_format
	, bib_text.rda_content
	, bib_text.rda_carrier
	, bib_text.rda_media
	, bib_text.field_008
	, bib_text.descrip_form
    , LISTAGG("LOCATION".LOCATION_DISPLAY_NAME, ', ') WITHIN GROUP (ORDER BY "LOCATION".LOCATION_DISPLAY_NAME) "locs"
FROM bib_text
LEFT JOIN BIB_LOCATION on BIB_LOCATION.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
WHERE bib_text.publisher is NULL
AND bib_text.pub_place is null
AND bib_text.isbn is null
AND bib_text.issn is null
AND bib_text.title not like '%Temporary Circulation Record%'
AND bib_text.bib_format not like '%d%'
AND bib_text.bib_format not like '%f%'
AND bib_text.bib_format not like '%p%'
AND bib_text.bib_format not like '||'
GROUP BY bib_text.BIB_ID, bib_text.title, bib_text.isbn, bib_text.issn, bib_text.lccn, 
bib_text.series, bib_text.begin_pub_date, bib_text.end_pub_date, bib_text.pub_dates_combined, bib_text.pub_place, 
bib_text.publisher, bib_text.author, bib_text.imprint, bib_text.bib_format, bib_text.rda_content, 
bib_text.rda_carrier, bib_text.rda_media, bib_text.field_008, bib_text.descrip_form) bib_data
WHERE bib_data.locs not like 'Yale Internet Resource'