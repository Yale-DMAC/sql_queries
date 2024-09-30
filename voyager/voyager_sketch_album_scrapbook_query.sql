SELECT bib_text.bib_id
	, bib_text.series
	, bib_text.begin_pub_date
	, bib_text.end_pub_date
	, bib_text.pub_dates_combined
	, bib_text.author
    , bib_text.publisher
    , bib_text.pub_place
    , bib_text.imprint
	, bib_text.bib_format
	, bib_text.rda_content
	, bib_text.rda_carrier
	, bib_text.rda_media
	, bib_text.field_008
	, bib_text.descrip_form
	, "LOCATION".LOCATION_DISPLAY_NAME
	, bib_text.title
FROM bib_text
LEFT JOIN BIB_LOCATION on BIB_LOCATION.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
WHERE (bib_text.title like '%scrapbook%'
    OR bib_text.title like '%album%'
    OR bib_text.title like '%sketchbook%'
    OR bib_text.title like '%sketch book%')
