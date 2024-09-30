SELECT bib_text.bib_id
    , bib_text.pub_place
    , bib_text.begin_pub_date
    , bib_text.end_pub_date
    , bib_text.author
    , bib_text.bib_format
    , bib_locs."locations"
    , bib_text.rda_content
    , bib_text.rda_carrier
    , bib_text.rda_media
    , bib_text.title
    , marc_fields.marc_300
    , marc_fields.marc_260
FROM bib_text
LEFT JOIN (SELECT BIB_LOCATION.BIB_ID
            , LISTAGG("LOCATION".LOCATION_DISPLAY_NAME , '; ') WITHIN GROUP (ORDER BY "LOCATION".LOCATION_DISPLAY_NAME) "locations"
            FROM BIB_LOCATION
            LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
            GROUP BY BIB_LOCATION.BIB_ID) bib_locs on bib_locs.BIB_ID = bib_text.bib_id
LEFT JOIN (SELECT BIB_ID
    , YALEDB.GETBIBTAG(BIB_ID, '260') as marc_260
    , YALEDB.GETBIBTAG(BIB_ID, '300') as marc_300
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '902') as marc_902
    FROM BIB_MASTER) marc_fields on marc_fields.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN (SELECT BIB_ID
    , SUPPRESS_IN_OPAC
    , ACTION_DATE
    FROM BIB_HISTORY
    WHERE ACTION_DATE = (SELECT MAX(BH.ACTION_DATE)
                         FROM BIB_HISTORY BH
                         WHERE BH.BIB_ID = BIB_HISTORY.BIB_ID)
    AND SUPPRESS_IN_OPAC = 'Y') suppressed_records on suppressed_records.BIB_ID = BIB_TEXT.BIB_ID
WHERE bib_text.bib_format = 'am' 
AND (marc_fields.marc_300 like '%box%'
            OR marc_fields.marc_300 like '%linear%'
            OR marc_fields.marc_300 like '%unpaged%')
AND suppressed_records.SUPPRESS_IN_OPAC is NULL
AND (bib_text.rda_carrier is NULL 
        or bib_text.rda_carrier != 'cr')