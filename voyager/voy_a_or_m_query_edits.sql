SELECT bib_text.bib_id
	, bib_text.series
	, bib_text.begin_pub_date
	, bib_text.end_pub_date
	, bib_text.pub_dates_combined
	, bib_text.author
	, bib_text.bib_format
	, bib_text.rda_content
	, bib_text.rda_carrier
	, bib_text.rda_media
	, bib_text.field_008
	, bib_text.descrip_form
	, "LOCATION".LOCATION_DISPLAY_NAME
	, bib_text.title
    , marc_data."display_heading"
FROM bib_text
LEFT JOIN BIB_LOCATION on BIB_LOCATION.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
LEFT JOIN (SELECT BIB_INDEX.bib_id as bib_num
            , LISTAGG(CONCAT((CONCAT(BIB_INDEX.index_code, ': ')), BIB_INDEX.DISPLAY_HEADING) , ', ') WITHIN GROUP (ORDER BY BIB_INDEX.DISPLAY_HEADING) "display_heading"
        FROM BIB_INDEX
        GROUP BY BIB_INDEX.bib_id) marc_data on BIB_TEXT.BIB_ID = marc_data.bib_num
WHERE (bib_text.publisher is NULL
		OR bib_text.publisher like '%Yale College%')
AND NOT (bib_text.bib_format = 'tm' AND 
		"LOCATION".LOCATION_DISPLAY_NAME in ('Library Shelving Facility (LSF)',
			'LSF-Request for Use at EPH Library',
			'LSF-Use in SML, Manuscripts and Archives only (Non-Circ)'))
AND bib_text.pub_place is null
AND bib_text.isbn is null
AND bib_text.issn is null
AND bib_text.lccn is null
AND bib_text.title not like '%[microform]%'
AND bib_text.title not like '%[microfiche]%'
AND bib_text.title not like '%[microfilm]%'
AND bib_text.title not like '%Temporary Circulation Record%'
AND bib_text.title not like '%[ILL]%'
AND bib_text.title not like '%(ILL)%'
AND bib_text.bib_format not like '%d%'
AND bib_text.bib_format not like '%f%'
AND bib_text.bib_format not like '%p%'
AND bib_text.bib_format not like '||'
AND "LOCATION".LOCATION_DISPLAY_NAME not in (
		'Yale Internet Resource', 'Unavailable - use request form to try BorrowDirect or ILL', 
		'Unavailable--Try BorrowDirect or Interlibrary Loan',
		'Withdrawn - Suppressed', 
		'SML ILL Desk', 'SML, Borrow Direct Office', 
		'SML, Interlibrary Loan Office',
		'SML, Circulation Desk', 
		'Pickup at Marx Library Information Desk', 
		'Pickup at Bass Library Service Desk',
		'**Sterling Hold Shelf', 
		'MEDICAL, Interlibrary Loan Office', 
		'BASS, Closed Reserve, 2-Hour Reserve - Ask at Service Desk',
		'SML, CD-ROM Reference Center (Non-Circulating)', 
		'BASS, Ask at Service Desk', 
		'LSF--Contact MEDLIB@yale.edu to request item',
        'MARX Library, Closed Reserve Pamphlets', 
        'BASS, Media Equipment - Ask at Service Desk', 
        'BASS, Lower Level, 3-Day Reserve',
        'BASS, Lower Level, 24-Hour Reserve', 
        'Request for delivery to any Yale Library', 
        'SML, Non-Library Material',
        'Yale Electronic Reserve', 
        'Pickup at Arts Library Service Desk ', 
        'BASS, Lower Level', 
        'BRITISH ART CENTER, Reference Lib., Conservation (Non-Circ)',
        'BRITISH ART CENTER, Reference Lib., Mezzanine (Non-Circ)', 
        'BRITISH ART CENTER, Reference Lib., Vertical File (Non-Circ)',
        'BRITISH ART CENTER, Reference Library (Non-Circulating)', 
        'CCL, Closed Reserve, Videotape', 
        'CHEMISTRY -- Request for delivery to any Yale Library',
        'DIVINITY, Reserve', 
        'MARX Library, Current Journals', 
        'SML, Stacks, LC Classification', 
        'SML, Starr Main Reference Room (Non-Circulating)',
        'Statistics Library (Non-Circulating)', 
        'MEDICAL,  Interlibrary Loan Office', 
        'MEDICAL,  Theses, Locked (Non-Circulating)',
        'MEDICAL, Course Reserve', 
        'MUSIC LIBRARY, SML, Recordings Collection', 
        'MEDICAL,  Periodicals (Non-Circulating)', 
        'MEDICAL',
        'MATH',
        'EPH LIBRARY, Reserve',
        'F"&"ES Course Reserve Desk',
        'Forestry "&" Environmental Studies Library Circulation Desk',
        'HAAS ARTS LIBRARY, Closed Reserve',
        'LSF - Request for delivery to any Yale Library',
        'Bass Library Reserve, Not Yet Available (B)',
        'acqART',
        'acqFES',
        'acqENGN',
        'acqGDC',
        'acqMEDSER',
        'acqSMLJUD',
        'acqMUS',
        'BEINECKE, Stack Reference (Non-Circulating)',
        '[ Staff Only ] TS 344',
        'MEDICAL, Circulation Desk (Non-Circulating)',
        'CCL, Closed Reserve, Software',
        'DIVINITY, 24-Hour Reserve',
        'DIVINITY, 7 day reserve',
        'DIVINITY, Circulation Desk',
        'DIVINITY, Reserve - No overnight loan',
        'DIVINITY, Ministry Resource Center',
        'DIVINITY, Three Day Reserve',
        'EPH LIBRARY, 24-Hour Reserve',
        'EPH, Circulation',
        'MUSIC LIBRARY, SML, Closed Reserve',
        'LSF--Archival Film Collection (Non-Circulating)',
        'SML, Near East - Request for delivery to any library',
        'SML, Newspaper Room (Non-Circulating)',
        'SML, Stacks, Engineering Collection',
        'YSN Commons, Reference (Nursing students only)',
        'SML, Stacks - 4th Floor, Bass Reference collection',
        'SML, Southeast Asia Reference, Room 214 (Non-Circulating)',
        'SML, Semitic Reference, Room 314A (Non-Circulating)',
        'FILM ARCHIVE--Video Collection',
        'Yale University Library',
        'SML, Map Collection GIS, Room 707 (Non-Circulating)',
        'SML, Microform (Non-Circulating)',
        'ORNITHOLOGY (Non-Circulating)',
        'DIVINITY, Day Missions Room',
        'DIVINITY, Trowbridge Reference Room (Non-Circulating)',
        'DIVINITY, Technical Services (Non-Circulating)',
        'HAAS ARTS LIBRARY, Reference (Non-Circulating)',
        'HAAS ARTS LIBRARY, Periodicals 1 (Non-Circulating)',
        'HAAS ARTS LIBRARY, Open Reserve',
        'HAAS ARTS LIBRARY, Uncataloged I (Non-Circulating)',
        'HAAS ARTS LIBRARY, Uncataloged D (Non-Circulating)',
        'MEDICAL/HISTORICAL, Stacks',
        'MUSIC LIBRARY, SML, Carrel Reserve, Ask at Desk',
        'MUSIC LIBRARY, SML, HSR reference (Non-Circulating)',
        'MUSIC LIBRARY, SML, Microforms (Non-Circulating)',
        'MUSIC LIBRARY, SML, Librarian''s Office, ML 112 (Non-Circ)',
        'MUSIC LIBRARY, SML, Reference Room, ML 101M (Non-Circ)',
        'Preservation Office',
        'Pickup at Yale Film Archive Service Desk',
        'Pickup at Music Library Service Desk',
        'Pickup at Law Library Service Desk',
        'Pickup at Divinity Library: Requires Divinity School Access',
        'SML East Asia Library Reference, Rm 219 (Non-Circulating)',
        'SML, Babylonian Collection, Room 322 (Non-Circulating)',
        'SML, Franke Periodical Reading Room (Non-Circulating)',
        'SML, Egyptology Reading Room, Room 329 (Non-Circulating)',
        'SML, Judaic Studies Reference, Room 335B (Non-Circulating)',
        'ENGINEERING "&" APPLIED SCIENCE, Reserve',
        'EPIDEMIOLOGY "&" PUBLIC HEALTH LIBRARY',
        'F"&"ES Course Reserve Desk',
        'Forestry "&" Environmental Studies Library Circulation Desk',
        'SML, Slavic "&" East European Reference, Room 406 (Non-Circ)',
        'HAAS ARTS LIBRARY, Art "&" Arch Collection',
        'EPIDEMIOLOGY "&" PUBLIC HEALTH LIBRARY')