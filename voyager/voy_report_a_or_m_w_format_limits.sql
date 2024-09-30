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
    , marc_fields.marc_090
    , marc_fields.marc_240
    , marc_fields.marc_300
    , marc_fields.marc_336
    , marc_fields.marc_500
    , marc_fields.marc_510
    , marc_fields.marc_545
    , marc_fields.marc_520
    , marc_fields.marc_590
    , marc_fields.marc_650
    , marc_fields.marc_655
FROM bib_text
LEFT JOIN BIB_LOCATION on BIB_LOCATION.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
LEFT JOIN (SELECT BIB_ID
    , YALEDB.GETBIBTAG(BIB_ID, '090') as marc_090
    , YALEDB.GETBIBTAG(BIB_ID, '240') as marc_240
    , YALEDB.GETBIBTAG(BIB_ID, '300') as marc_300
    , YALEDB.GETBIBTAG(BIB_ID, '336') as marc_336
    , YALEDB.GETBIBTAG(BIB_ID, '502') as marc_502
    , YALEDB.GETBIBTAG(BIB_ID, '510') as marc_510
    , YALEDB.GETBIBTAG(BIB_ID, '545') as marc_545
    , YALEDB.GETBIBTAG(BIB_ID, '520') as marc_520
    , YALEDB.GETBIBTAG(BIB_ID, '590') as marc_590
    , YALEDB.GETBIBTAG(BIB_ID, '773') as marc_773
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '500') as marc_500
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '650') as marc_650
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '655') as marc_655
    FROM BIB_MASTER) marc_fields on marc_fields.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN (SELECT BIB_ID
    , SUPPRESS_IN_OPAC
    , ACTION_DATE
    FROM BIB_HISTORY
    WHERE ACTION_DATE = (SELECT MAX(BH.ACTION_DATE)
                         FROM BIB_HISTORY BH
                         WHERE BH.BIB_ID = BIB_HISTORY.BIB_ID)
    AND SUPPRESS_IN_OPAC = 'Y') suppressed_records on suppressed_records.BIB_ID = BIB_TEXT.BIB_ID
WHERE suppressed_records.SUPPRESS_IN_OPAC is NULL
AND (bib_text.publisher is NULL
        OR bib_text.publisher like '%Yale College%')
AND NOT (bib_text.bib_format = 'tm' AND 
                "LOCATION".LOCATION_DISPLAY_NAME in ('Library Shelving Facility (LSF)',
                        'LSF-Request for Use at EPH Library',
                        'LSF-Use in SML, Manuscripts and Archives only (Non-Circ)'))
AND NOT (bib_text.title like '% / %' AND
                "LOCATION".LOCATION_DISPLAY_NAME = 'Library Shelving Facility (LSF)')
AND NOT (marc_fields.marc_300 = '[1 v.]' AND
                "LOCATION".LOCATION_DISPLAY_NAME = 'Library Shelving Facility (LSF)')
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
AND lower(bib_text.title) not like '%pamphlet%'
AND lower(bib_text.title) not like '%publication%'
AND lower(bib_text.title) not like '%proceedings%'
AND lower(bib_text.title) not like '%report%'
AND lower(bib_text.title) not like '%dissertatio%'
AND lower(bib_text.title) not like '%tract%'
AND lower(bib_text.title) not like '%catalog%'
AND lower(bib_text.title) not like '%essay%'
AND lower(bib_text.title) not like '%study guide%'
AND lower(bib_text.title) not like '%financial document%'
AND lower(bib_text.title) not like '%bibliography%'
AND lower(bib_text.title) not like '%miscellaneous works%'
AND lower(bib_text.title) not like '%publish%'
AND lower(bib_text.title) not like '%printed material%'
AND lower(bib_text.title) not like '%miscellaneous material about%'
AND lower(bib_text.title) not like '%miscellaneous articles%'
AND lower(bib_text.title) not like '%periodical%'
AND lower(bib_text.title) not like '%course packet%'
AND lower(bib_text.title) not like '%reprint%'
AND lower(bib_text.title) not like '%mimeograph%'
AND lower(bib_text.title) not like '%photostat%'
AND lower(bib_text.title) not like '%photocop%' 
AND (lower(bib_text.series) is NULL
                or lower(bib_text.series) like '%oral history%')
AND marc_fields.marc_773 IS NULL
AND (marc_fields.marc_090 is NULL
        OR lower(marc_fields.marc_090) not like '%pamphlet%')
AND (marc_fields.marc_300 is NULL
        OR (lower(marc_fields.marc_300) not like '%map%'
                AND lower(marc_fields.marc_300) not like 'p.%'
                AND lower(marc_fields.marc_300) not like 'pp.%'
                AND lower(marc_fields.marc_300) not like 'pages%'
                AND lower(marc_fields.marc_300) not like 'london%'

                ))
And (marc_fields.marc_590 is NULL
        OR (lower(marc_fields.marc_590) not like 'SML, Y %'
                AND lower(marc_fields.marc_590) not like '%tract%')
        )
AND (marc_fields.marc_500 is NULL
        OR (lower(marc_fields.marc_500) not like '  ain %'
                AND lower(marc_fields.marc_500) not like '  a(in %'
                AND lower(marc_fields.marc_500) not like '%typescript%'
                AND lower(marc_fields.marc_500) not like '%photocop%'
                AND lower(marc_fields.marc_500) not like '%thesis%'
                AND lower(marc_fields.marc_500) not like '%pamphlet%'
                AND lower(marc_fields.marc_500) not like '%printed%'
                AND lower(marc_fields.marc_500) not like '%detached from%'
                AND lower(marc_fields.marc_500) not like '  afrom: %'
                AND lower(marc_fields.marc_500) not like '  afrom %'
                AND lower(marc_fields.marc_500) not like '%offprint%'
                AND lower(marc_fields.marc_500) not like '%photostat%'
                AND lower(marc_fields.marc_500) not like '%carbon copy%'
                AND lower(marc_fields.marc_500) not like '%reprint%'
                AND lower(marc_fields.marc_500) not like '%novel%'
                AND lower(marc_fields.marc_500) not like '%book review%'
                AND lower(marc_fields.marc_500) not like '%short story%'
                AND lower(marc_fields.marc_500) not like '%review of%'
                AND lower(marc_fields.marc_500) not like '%republication%'
                AND lower(marc_fields.marc_500) not like '%reproduced from%'
                AND lower(marc_fields.marc_500) not like '%published%'
                AND lower(marc_fields.marc_500) not like '%edited%'
                AND lower(marc_fields.marc_500) not like '%edition%'
                AND lower(marc_fields.marc_500) not like '%ed. %'
                AND lower(marc_fields.marc_500) not like '  apaper f%'
                AND lower(marc_fields.marc_500) not like '  apaper presented%'
                AND lower(marc_fields.marc_500) not like '  apaper submitted%'
                AND lower(marc_fields.marc_500) not like '%mimeograph%'
                AND lower(marc_fields.marc_500) not like '  aread %'
                AND lower(marc_fields.marc_500) not like '%proof copy%'
                AND lower(marc_fields.marc_500) not like '%diss.%'
                AND lower(marc_fields.marc_500) not like '  atranslat%'
                AND lower(marc_fields.marc_500) not like '%facsimil%'
                AND lower(marc_fields.marc_500) not like '%|  ain %'
                AND lower(marc_fields.marc_500) not like '%|  a(in %'
                AND lower(marc_fields.marc_500) not like '%|  atranslat%'
                AND lower(marc_fields.marc_500) not like '  ai��n��  %'
                AND lower(marc_fields.marc_500) not like '  a"from %'
                AND lower(marc_fields.marc_500) not like '  a[from  %'
                AND lower(marc_fields.marc_500) not like '%|  a"from  %'
                AND lower(marc_fields.marc_500) not like '%|  aextract from %'
                AND lower(marc_fields.marc_500) not like '%|  afrom %'
                AND lower(marc_fields.marc_500) not like '%|  afrom: %'
                AND lower(marc_fields.marc_500) not like '  a"(from %'
                AND lower(marc_fields.marc_500) not like '  a[from %'
                AND lower(marc_fields.marc_500) not like '  aadded %'
                AND lower(marc_fields.marc_500) not like '  aat head of title:%'
                AND lower(marc_fields.marc_500) not like '  abased on %'
                ))
AND bib_text.field_008 not in ('950119s18001899cc            000 0 tib d',
                '950119s1893    cc            000 0 tib d',
                '950119s1893    cc            000 0btib d',
                '950119s1893    cc a          000 0 tib d',
                '950119s1949    cc            000 0btib d',
                '950120q18001899cc            000 0 tib d',
                '940705n        xx             00 0 ger u',
                '940705n        xx             00 0 fre u',
                '940705n        xx             00 0 eng u')
AND (bib_text.author is null or (bib_text.author != 'Atomic Energy of Canada Limited. '
                AND bib_text.author != 'Beinecke Rare Book and Manuscript Library. Technical Services. '
                AND lower(bib_text.author) not like 'canada. %'
                AND lower(bib_text.author) not like 'great britain. %'
                AND lower(bib_text.author) not like 'michigan state university. %'
                AND lower(bib_text.author) not like 'national institut%'
                AND lower(bib_text.author) not like 'united states%'
                ))
AND "LOCATION".LOCATION_DISPLAY_NAME not in (
        'MUSIC LIBRARY, SML, Historical Sound Recording (Non-Circ)',
        'LSF, Historical Sound Recordings (Non-Circulating)',
        'MARX LIBRARY, Maps, Request to use at Marx',
        'SML, Judaica - Request for delivery to any library',
        'MEDICAL/HISTORICAL, Histories, Locked (Non-Circulating)',
        'SML, Franklin Collection, Room 230 (Non-Circulating)',
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
        'MARX Library, 24-hour Reserve, ask at Info Desk',
        'Elizabethan Club',
        'HAAS ARTS LIBRARY',
        'HAAS ARTS LIBRARY, Drama Collection',
        'HAAS ARTS LIBRARY, Old Drama (not LC), Lower Level',
        'HAAS ARTS LIBRARY, Non-Library Material',
        'Herbarium Coll, Room 359, ESC (Non-Circulating)',
        'Internet Archive',
        'CLASSICS (Non-Circulating)',
        'SML, African Collection, Room 317 (Non-Circulating)',
        'SML East Asia Library Special Collections (Non-Circulating)',
        'SML, American Oriental Society, Room 329 (Non-Circulating)',
        'SML, Linonia &' || ' Brothers Room',
        'SML, Historical Texts, Starr Reference Room, Non-Circulating',
        'SML, Zeta Folio Collection (Non-Circulating)',
        'SML, Slavic &' || ' East European Reading, Room 406 (Non-Circ)',
        'SML, Philosophy Study, Room 609-610 (Non-Circulating)',
        'SML, Negative Film (Staff Use Only, Non-Circulating)',
        'SML, Mountaineering Collection, Linonia &' || ' Brothers Room',
        'SML, Microtext Desk (In-Room Use, Non-Circulating)',
        'Sterling Memorial Library (SML)')
AND (bib_text.bib_format like '%k%'
        OR lower(bib_text.title) like '%photo%'
        OR lower(bib_text.title) like '%album%'
        OR lower(bib_text.title) like '%drawing%'
        OR lower(bib_text.title) like '%plate%'
        OR lower(bib_text.title) like '%postcard%'
        OR lower(bib_text.title) like '%post card%'
        OR lower(bib_text.title) like '%portrait%'
        OR lower(bib_text.title) like '%poster%'
        OR lower(bib_text.title) like '%slide%'
        OR lower(bib_text.title) like '%map%'
        OR lower(bib_text.title) like '%scrap%'
        OR lower(bib_text.title) like '%scapbook%'
        OR lower(bib_text.title) like '%sketch%'
        OR lower(bib_text.title) like '%painting%'
        OR lower(bib_text.title) like '%collection%'
        OR lower(bib_text.title) like '%records%'
        OR lower(bib_text.title) like '%manuscript%'
        OR lower(bib_text.title) like '%picture%'
        OR lower(bib_text.title) like '%production book%'
        OR lower(bib_text.title) like '%engraving%'
        OR (lower(bib_text.title) like '%print%' AND lower(bib_text.title) not like '%printed%'
                AND lower(bib_text.title) not like '%reprint%' AND lower(bib_text.title) not like '%imprint%')
        OR lower(bib_text.title) like '%program%'
        OR lower(bib_text.title) like '%promotional%'
        OR lower(bib_text.title) like '%letter%'
        OR lower(bib_text.title) like '%document%'
        OR lower(bib_text.title) like '%announcement%'
        OR lower(bib_text.title) like '%oral history%'
        OR lower(bib_text.title) like '%memorabilia%'
        OR lower(bib_text.title) like '%views of%'
        OR lower(bib_text.title) like '%record book%'
        OR lower(bib_text.title) like '%miscellaneous material%'
        OR lower(bib_text.title) like '%material relating to%'
        OR lower(bib_text.title) like '%correspondence%'
        OR lower(marc_fields.marc_300) like '%photo%'
        OR lower(marc_fields.marc_300) like '%album%'
        OR lower(marc_fields.marc_300) like '%drawing%'
        OR lower(marc_fields.marc_300) like '%postcard%'
        OR lower(marc_fields.marc_300) like '%portrait%'
        OR lower(marc_fields.marc_300) like '%slide%'
        OR lower(marc_fields.marc_300) like '%scrapbook%'
        OR lower(marc_fields.marc_300) like '%sketch%'
        OR lower(marc_fields.marc_300)like '%painting%'
        OR lower(marc_fields.marc_300) like '%poster%'
        OR lower(marc_fields.marc_300) like '%engraving%'
        OR lower(marc_fields.marc_300) like '%linear%'
        OR lower(marc_fields.marc_300) like '%box%'
        OR lower(marc_fields.marc_300) like '%ms.%'
        OR lower(marc_fields.marc_300) like '%mss.%'
        OR lower(marc_fields.marc_500) like '%scrap%'
        OR lower(marc_fields.marc_500) like '%memorabilia%'
        OR lower(marc_fields.marc_500) like '%compiled to document major production%'
        OR lower(marc_fields.marc_500) like '%ms.%'
        OR lower(marc_fields.marc_500) like '%manuscript%'
        OR lower(marc_fields.marc_500) like '%mss.%')