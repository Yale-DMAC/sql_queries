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
    , bib_locs."locations"
    , bib_text.title
    , marc_fields.marc_090
    , marc_fields.marc_300
    , marc_fields.marc_336
    , marc_fields.marc_545
    , marc_fields.marc_520
    , marc_fields.marc_650
    , marc_fields.marc_655
FROM bib_text
LEFT JOIN (SELECT BIB_LOCATION.BIB_ID
            , LISTAGG("LOCATION".LOCATION_DISPLAY_NAME , '; ') WITHIN GROUP (ORDER BY "LOCATION".LOCATION_DISPLAY_NAME) "locations"
            FROM BIB_LOCATION
            LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
            GROUP BY BIB_LOCATION.BIB_ID) bib_locs on bib_locs.BIB_ID = bib_text.bib_id
LEFT JOIN (SELECT BIB_ID
    , YALEDB.GETBIBTAG(BIB_ID, '090') as marc_090
    , YALEDB.GETBIBTAG(BIB_ID, '300') as marc_300
    , YALEDB.GETBIBTAG(BIB_ID, '336') as marc_336
    , YALEDB.GETBIBTAG(BIB_ID, '502') as marc_502
    , YALEDB.GETBIBTAG(BIB_ID, '545') as marc_545
    , YALEDB.GETBIBTAG(BIB_ID, '520') as marc_520
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '650') as marc_650
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '655') as marc_655
    FROM BIB_MASTER) marc_fields on marc_fields.BIB_ID = BIB_TEXT.BIB_ID
WHERE (bib_text.publisher is NULL
        OR bib_text.publisher like '%Yale College%')
AND NOT (bib_text.bib_format = 'tm' AND 
            (bib_locs.locations not like '%Library Shelving Facility (LSF)%'
            AND bib_locs.locations not like '%LSF-Request for Use at EPH Library%'
            AND bib_locs.locations not like '%LSF-Use in SML, Manuscripts and Archives only (Non-Circ)%'))
AND marc_fields.marc_502 is null
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
AND bib_text.field_008 != '020514||||||||||||||||||||||||||||||||||'
# update this to work with aggregated location subquery
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
        'ENGINEERING &' || ' APPLIED SCIENCE, Reserve',
        'EPIDEMIOLOGY &' || ' PUBLIC HEALTH LIBRARY',
        'Forestry &' || ' Environmental Studies Library Circulation Desk',
        'F&' || 'ES Course Reserve Desk',
        'Forestry &' || ' Environmental Studies Library Circulation Desk',
        'SML, Slavic &' || ' East European Reference, Room 406 (Non-Circ)',
        'HAAS ARTS LIBRARY, Art &' || ' Arch Collection',
        'EPIDEMIOLOGY &' || ' PUBLIC HEALTH LIBRARY',
        'MARX Library, 2-hour Reserve, ask at Info Desk',
        'MARX Library, Shelved in Office',
        'MARX Library, Reference',
        'MARX Library, Non-Library Material',
        'MUSIC LIBRARY, SML',
        'Pickup at Divinity Library Service Desk',
        'MED HIST-Periodicals (Non-Circulating),Morse Room, 1st floor',
        'MEDICAL,  Journal Reserve (Non-Circulating)',
        'MEDICAL,  Reference (Non-Circulating)',
        'MEDICAL,  Reference, Stacks (Non-Circulating)',
        'MEDICAL,  Reserve',
        'MEDICAL, Circulation (Non-Circulating)',
        'MEDICAL, Non-Library Material',
        'MEDICAL, Three-Day Reserve',
        'MEDICAL, Video/Audio Tape (1 Week Loan)',
        'LSF--Video Collection--Request for delivery',
        'LAW, Stacks',
        'HASS Course Reserve Desk',
        'EPH LIBRARY, Reference (Non-Circulating)',
        'EPH LIBRARY, Periodicals (Non-Circulating)',
        'ENGINEERING &' || ' APPLIED SCIENCE, 24-Hour Reserve',
        'MARX Library MICRO - ask at Info Desk',
        'MARX LIBRARY, ANNEX, request for use',
        'MARX LIBRARY',
        'MARX Library',
        'MARX Library - ask at Info Desk',
        'MARX LIBRARY, 24-hour reserve, ask at Info Desk',
        'MARX Library, 24-hour Reserve, ask at Info Desk')
AND (bib_text.bib_format like '%k%'
        OR lower(bib_text.title) like '%photo%'
        OR lower(bib_text.title) like '%album%'
        OR lower(bib_text.title) like '%drawing%'
        OR lower(bib_text.title) like '%plate%'
        OR lower(bib_text.title) like '%illustration%'
        OR lower(bib_text.title) like '%postcard%'
        OR lower(bib_text.title) like '%portrait%'
        OR lower(bib_text.title) like '%postcard%'
        OR lower(bib_text.title) like '%slide%'
        OR lower(bib_text.title) like '%map%'
        OR lower(bib_text.title) like '%scrapbook%'
        OR lower(bib_text.title) like '%sketch%'
        OR lower(bib_text.title) like '%painting%'
        OR (lower(bib_text.title) like '%print%' AND lower(bib_text.title) not like '%printed%')
        OR lower(bib_text.title) like '%atlas%'
        OR lower(bib_text.title) like '%poster%'
        OR lower(marc_fields.marc_300) like '%photo%'
        OR lower(marc_fields.marc_300) like '%album%'
        OR lower(marc_fields.marc_300) like '%drawing%'
        OR lower(marc_fields.marc_300) like '%plate%'
        OR lower(marc_fields.marc_300) like '%illustration%'
        OR lower(marc_fields.marc_300) like '%postcard%'
        OR lower(marc_fields.marc_300) like '%portrait%'
        OR lower(marc_fields.marc_300) like '%postcard%'
        OR lower(marc_fields.marc_300) like '%slide%'
        OR lower(marc_fields.marc_300) like '%map%'
        OR lower(marc_fields.marc_300) like '%scrapbook%'
        OR lower(marc_fields.marc_300) like '%sketch%'
        OR lower(marc_fields.marc_300)like '%painting%'
        OR lower(marc_fields.marc_300) like '%print%'
        OR lower(marc_fields.marc_300) like '%atlas%'
        OR lower(marc_fields.marc_300) like '%poster%'
        OR lower(marc_fields.marc_300) like '%engraving%'
        OR lower(marc_fields.marc_650) like '%visual%'
        OR lower(marc_fields.marc_650) like '%pictorial%'
        OR lower(marc_fields.marc_650) like '%portrait%'
        OR lower(marc_fields.marc_655) like '%advertising card%'
        OR lower(marc_fields.marc_655) like '%artists'' books%'
        OR lower(marc_fields.marc_655) like '%visual work%'
        OR lower(marc_fields.marc_655) like '%engraving%'
        OR lower(marc_fields.marc_655) like '%photo%'
        OR lower(marc_fields.marc_655) like '%album%'
        OR lower(marc_fields.marc_655) like '%drawing%'
        OR lower(marc_fields.marc_655) like '%plate%'
        OR lower(marc_fields.marc_655) like '%illustration%'
        OR lower(marc_fields.marc_655) like '%postcard%'
        OR lower(marc_fields.marc_655) like '%portrait%'
        OR lower(marc_fields.marc_655) like '%postcard%'
        OR lower(marc_fields.marc_655) like '%slide%'
        OR lower(marc_fields.marc_655) like '%map%'
        OR lower(marc_fields.marc_655) like '%scrapbook%'
        OR lower(marc_fields.marc_655) like '%sketch%'
        OR lower(marc_fields.marc_655) like '%painting%'
        OR lower(marc_fields.marc_655) like '%print%'
        OR lower(marc_fields.marc_655) like '%atlas%'
        OR lower(marc_fields.marc_655) like '%poster%'
)